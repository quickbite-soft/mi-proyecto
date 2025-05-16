import mssql from "mssql";


const sql = require('mssql');

const dbConfig = {
  user: 'quickbite_user',
  password: 'Quickbite123!',
  server: 'localhost', // o 'DESKTOP-9B1DULO'
  database: 'quickbite',
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

async function getConnection() {
  try {
    return await sql.connect(dbConfig);
  } catch (err) {
    console.error('❌ Error en la conexión a SQL Server:', err);
    throw err;
  }
}

module.exports = { getConnection, sql };