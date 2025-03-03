const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

const pool = new Pool({
  user: 'postgres',
  host: 'heartily-punctual-petrel.data-1.use1.tembo.io',
  database: 'postgres',
  password: 'LTDD5QMvJiVzGdAZ',
  port: 5432, // A maioria dos PostgreSQL usa 5432
  ssl: { rejectUnauthorized: false }, // Necessário para muitos bancos na nuvem
});

// Endpoint para obter a lista de convidados
app.get('/convidados', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT c.Id, c.Nome, c.PresencaConfirmada, c.ValorConcedido, p.Nome as Presente
      FROM Convidado c
      LEFT JOIN Presente p ON c.PresenteId = p.Id
    `);
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
    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar presentes');
  } finally {
    client.release(); // Libera a conexão de volta para o pool
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
  } finally {
    client.release(); // Libera a conexão de volta para o pool
  }
});


// Inicia o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
