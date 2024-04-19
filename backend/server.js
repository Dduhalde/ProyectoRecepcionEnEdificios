import express from 'express';
import mysql from 'mysql';
import env from 'dotenv';

const app = express();
const port = 3001;S

env.config()

const passwordbd = process.env.DB_PASSWORD;
const hostdb = process.env.DB_HOST;
const userdb = process.env.DB_USER;
const namedb = process.env.DB_NAME;
const portdb = process.env.DB_PORT;

// Configuración de la conexión a la base de datos
const connection = mysql.createConnection({
  host: hostdb,
  user: userdb,
  password: passwordbd,
  database: namedb,
  port: portdb
});

// Establecer conexión a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }
  console.log('Conexión exitosa a la base de datos de Azure MySQL');
});

// Ruta para obtener datos desde la base de datos
app.get('/inhabitants/:apartment/:housing_unit', (req, res) => {
  const apartment = req.params.apartment;
  const housing_unit = req.params.housing_unit;
  const query = 'SELECT * FROM inhabitants WHERE apartment = ? AND housing_unit = ?;';

  // Agregar encabezados CORS en la respuesta
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000'); // Reemplaza con el origen de tu aplicación React
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  res.setHeader('Access-Control-Allow-Credentials', true);

  connection.query(query, [apartment, housing_unit], (err, rows) => {
    if (err) {
      console.error('Error al ejecutar la consulta:', err);
      res.status(500).send('Error al obtener datos desde la base de datos');
      return;
    }
    res.json(rows); // Enviar los datos como JSON al cliente
  });
});

// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor en ejecución en http://localhost:${port}`);
});
