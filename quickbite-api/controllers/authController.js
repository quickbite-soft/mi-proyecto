let usuarios = [];

async function register(req, res) {
  const {
    DNI,
    nombre,
    telefono_movil,
    fecha_nacimiento,
    correo_electronico,
    contraseña
  } = req.body;

  if (!DNI || !nombre || !telefono_movil || !fecha_nacimiento || !correo_electronico || !contraseña) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }

  const yaExiste = usuarios.find(u => u.correo_electronico === correo_electronico);
  if (yaExiste) {
    return res.status(409).json({ message: 'Ya existe una cuenta con este correo electrónico' });
  }

  usuarios.push({
    DNI,
    nombre,
    telefono_movil,
    fecha_nacimiento,
    correo_electronico,
    contraseña
  });

  return res.status(201).json({ message: 'Usuario registrado (modo prueba)' });
}

module.exports = { register };