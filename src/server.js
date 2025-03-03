const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

// Configuração do PostgreSQL (substitua pelas suas credenciais)
const pool = new Pool({
  user: 'postgres',  // Substitua pelo seu usuário
  host: 'heartily-punctual-petrel.data-1.use1.tembo.io',
  database: 'postgres',  // Substitua pelo nome do seu banco
  password: 'LTDD5QMvJiVzGdAZ',  // Substitua pela sua senha
  port: 5432,
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

// Endpoint para obter a lista de destinos de lua de mel
app.get('/destinos-lua-de-mel', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT Id, Nome, ValorNecessario, URLFoto
      FROM DestinoLuaDeMel
    `);
    res.json(result.rows); // Retorna os dados em formato JSON
  } catch (error) {
    console.error(error);
    res.status(500).send('Erro ao buscar destinos de lua de mel');
  }
});

// Inicia o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
