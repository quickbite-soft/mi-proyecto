const express = require('express');
const app = express();
const authRoutes = require('./routes/auth'); // Asegúrate que esta ruta es correcta

// Middleware para permitir JSON en las peticiones
app.use(express.json());

// Usar las rutas de autenticación
app.use('/api', authRoutes);

// Puerto de la aplicación
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});