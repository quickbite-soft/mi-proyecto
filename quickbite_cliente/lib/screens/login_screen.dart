import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.orange[50], // Color de fondo suave
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Espacio para imagen/logo
                SizedBox(
              height: MediaQuery.of(context).size.height * 0.35, // 35% de la pantalla
              child: Image.asset(
                'assets/logo.png', // Asegúrate de tener esta imagen en assets
                fit: BoxFit.contain,
              ),
            ),

                // Nombre de la app
                const Text(
                  'QuickBite Delivery App',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F00),
                  ),
                ),
                const SizedBox(height: 40),

                // Campo de correo
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo de contraseña
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón Iniciar Sesión
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6F00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),

                // Botón Crear cuenta
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: const Text('Create account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}