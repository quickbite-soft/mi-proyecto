import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _contrasenaController = TextEditingController();
  final _repetirContrasenaController = TextEditingController();

  String nombre = '';
  String correo = '';
  String contrasena = '';
  String cedula = '';
  String fechaNacimiento = '';
  String celular = '';

  @override
  void dispose() {
    _contrasenaController.dispose();
    _repetirContrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: const Text('QuickBite Registration'),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                label: 'Full name',
                onSaved: (value) => nombre = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Mandatory field' : null,
              ),
              _buildTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => correo = value!,
                validator: (value) =>
                    value!.contains('@') ? null : 'Invalid email',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value != null && value.length >= 6
                      ? null
                      : 'Minimum 6 characters',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _repetirContrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Repeat password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == _contrasenaController.text
                          ? null
                          : 'Passwords do not match',
                ),
              ),
              _buildTextField(
                label: 'ID',
                keyboardType: TextInputType.number,
                onSaved: (value) => cedula = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Mandatory field' : null,
              ),
              _buildTextField(
                label: 'Date of birth (YYYY-MM-DD)',
                onSaved: (value) => fechaNacimiento = value!,
                validator: (value) =>
                    RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value!)
                        ? null
                        : 'Invalid format',
              ),
              _buildTextField(
                label: 'Cellphone',
                keyboardType: TextInputType.phone,
                onSaved: (value) => celular = value!,
                validator: (value) => value!.length >= 8
                    ? null
                    : 'Invalid cell phone number',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _registrarUsuario,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _registrarUsuario() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      contrasena = _contrasenaController.text;

      print(
          'Registering: $nombre, $correo, $contrasena, $cedula, $fechaNacimiento, $celular');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration sent (simulated)')),
      );
    }
  }
}