const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

const pool = new Pool({
  user: 'postgres',
  host: 'demurely-spacious-flycatcher.data-1.use1.tembo.io',
  database: 'postgres',
  password: 'R3S81ya2kjUF7hBX',
  port: 5432,
  ssl: { rejectUnauthorized: false }, // Necessário para muitos bancos na nuvem
});

// Endpoint para obter a lista de convidados
app.get('/convidados', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT Id, Nome, PresencaConfirmada
      FROM Convidado
    `);
    res.header('Access-Control-Allow-Origin', '*');
    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar convidados --');
  } finally {
    client.release(); // Libera a conexão de volta para o pool
  }
});

// Endpoint para obter a lista de presentes
app.get('/presentes', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT p.Id, p.Nome, p.Valor, p.ValorObtido, p.PresenteUnico, d.Nome as Destino, p.URLFoto, p.URLLoja
      FROM Presente p
      LEFT JOIN DestinoLuaDeMel d ON p.DestinoId = d.Id
    `);
    res.header('Access-Control-Allow-Origin', '*');
    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar presentes');
  } finally {
    client.release(); // Libera a conexão de volta para o pool
  }
});

app.get('/convidado-presente', async (req, res) => {
  const client = await pool.connect();

  try {
    const result = await client.query(`
      SELECT 
        cp.Id,
        cp.ConvidadoId,
        cp.PresenteId,
        c.Nome AS NomeConvidado,
        cp.ValorConcedido
      FROM ConvidadoPresente cp
      INNER JOIN Convidado c ON cp.ConvidadoId = c.Id
    `);
    res.header('Access-Control-Allow-Origin', '*');
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar contribuições dos convidados:', error);
    res.status(500).json({ message: 'Erro ao buscar contribuições', error: error.message });
  } finally {
    client.release();
  }
});

app.get('/destinos-lua-de-mel', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT Id, Nome, ValorNecessario, URLFoto
      FROM DestinoLuaDeMel
    `);
    res.header('Access-Control-Allow-Origin', '*');
    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar destinos de lua de mel:', error);
    res.status(500).json({ message: 'Erro ao buscar destinos de lua de mel', error: error.message });
  } finally {
    client.release(); // Libera a conexão de volta para o pool
  }
});

app.post('/convidado-presente', async (req, res) => {
  const { ConvidadoId, PresenteId, ValorConcedido } = req.body;

  const client = await pool.connect();

  try {
    const result = await client.query(`
      INSERT INTO ConvidadoPresente (ConvidadoId, PresenteId, ValorConcedido)
      VALUES ($1, $2, $3)
      RETURNING *;
    `, [ConvidadoId, PresenteId, ValorConcedido]);
    res.header('Access-Control-Allow-Origin', '*');
    res.status(201).json({
      message: 'Contribuição registrada com sucesso',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Erro ao registrar contribuição:', error);
    res.status(500).json({ message: 'Erro ao registrar contribuição', error: error.message });
  } finally {
    client.release();
  }
});

app.put('/convidados/:id/confirmar-presenca', async (req, res) => {
  const { id } = req.params;
  const { presenca } = req.body; // true ou false

  const client = await pool.connect();

  try {
    const result = await client.query(`
      UPDATE Convidado
      SET PresencaConfirmada = $1
      WHERE Id = $2
      RETURNING *;
    `, [presenca, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Convidado não encontrado' });
    }
    res.header('Access-Control-Allow-Origin', '*');
    res.json({
      message: `Presença ${presenca ? 'confirmada' : 'não confirmada'} com sucesso`,
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Erro ao confirmar presença:', error);
    res.status(500).json({ message: 'Erro ao confirmar presença', error: error.message });
  } finally {
    client.release();
  }
});

function calcularCRC16(payload) {
  let polinomio = 0x1021;
  let resultado = 0xFFFF;

  for (let i = 0; i < payload.length; i++) {
    resultado ^= payload.charCodeAt(i) << 8;
    for (let bit = 0; bit < 8; bit++) {
      if ((resultado & 0x8000) !== 0) {
        resultado = ((resultado << 1) ^ polinomio);
      } else {
        resultado <<= 1;
      }
      resultado &= 0xFFFF;
    }
  }

  return resultado.toString(16).toUpperCase().padStart(4, '0');
}

function gerarPixCopiaECola(chave, nome, cidade, valor) {
  const GUI = 'br.gov.bcb.pix';
  const txid = '***'; // pode ser personalizado

  // Monta o campo 26 (Merchant Account Info)
  const chavePix = `01${chave.length.toString().padStart(2, '0')}${chave}`;
  const guiField = `00${GUI.length.toString().padStart(2, '0')}${GUI}`;
  const merchantAccountInfo = guiField + chavePix;
  const campo26 = `26${merchantAccountInfo.length.toString().padStart(2, '0')}${merchantAccountInfo}`;

  // Monta o payload
  let payload =
    '000201' + // Payload Format Indicator
    campo26 +
    '52040000' + // Merchant Category Code
    '5303986';   // Currency (BRL)

  // Valor
  const valorFormatado = valor.toFixed(2);
  payload += `54${valorFormatado.length.toString().padStart(2, '0')}${valorFormatado}`;

  // País, nome e cidade
  payload +=
    '5802BR' +
    `59${nome.slice(0, 25).length.toString().padStart(2, '0')}${nome.slice(0, 25)}` +
    `60${cidade.slice(0, 15).length.toString().padStart(2, '0')}${cidade.slice(0, 15)}` +
    `62070503${txid}` + // TXID

    // Adiciona campo CRC (sem o valor ainda)
    '6304';

  // Calcula o CRC e finaliza
  const crc = calcularCRC16(payload);
  return payload + crc;
}

// Endpoint GET: /pix?valor=99.90
app.get('/pix', (req, res) => {
  const valor = parseFloat(req.query.valor);
  if (isNaN(valor) || valor <= 0) {
    return res.status(400).json({ error: 'Valor inválido' });
  }

  const chave = '+5562994523722';
  const nome = 'Yuri dos Reis de Oliveira';
  const cidade = 'GOIANIA';

  const copiaECola = gerarPixCopiaECola(chave, nome, cidade, valor);
  
  res.header('Access-Control-Allow-Origin', '*');
  return res.json({ copiaECola });
});

// Inicia o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
