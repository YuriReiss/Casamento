const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
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

app.use(cors()); // Liberar CORS para todas as origens
app.use(express.json()); // Para interpretar os corpos das requisições como JSON

// Endpoint para obter a lista de convidados
app.get('/convidados', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT Id, Nome, PresencaConfirmada
      FROM Convidado
    `);

    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar convidados');
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

    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar presentes');
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

    res.json(result.rows);
  } catch (error) {
    console.error('Erro ao buscar destinos de lua de mel:', error);
    res.status(500).json({ message: 'Erro ao buscar destinos de lua de mel', error: error.message });
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

// Outras funções e endpoints continuam inalterados...

// Inicia o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
