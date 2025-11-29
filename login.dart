import 'package:flutter/material.dart';
import 'package:inter/alarma_vecinal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();

  // SIMULACIÓN DE SEGURIDAD
  // En una app real, esto vendría de una base de datos.
  final String _codigoComunidadSecreto = "VECINO2024"; 
  final List<String> _usuariosPermitidos = ["Juan", "Maria", "Pedro", "Admin"];

  void _iniciarSesion() {
    String usuario = _usuarioController.text.trim();
    String codigo = _codigoController.text.trim();
    
    // 1. Lógica de Verificación de Campos Vacíos
    if (usuario.isEmpty || codigo.isEmpty) {
      _mostrarError("Por favor completa todos los campos.");
      return;
    }

    // 2. Lógica de Verificación de Credenciales (Simulación Backend)
    if (codigo == _codigoComunidadSecreto) {
      // Éxito: Pasamos el nombre del usuario a la siguiente pantalla
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AlarmaVecinal(nombreUsuario: usuario),
        ),
      );
    } else {
      // Error: Código incorrecto
      _mostrarError("Código de vecindario incorrecto. Intenta de nuevo.");
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text(mensaje)),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.security, size: 80, color: Colors.blueAccent),
              SizedBox(height: 20),
              Text(
                'Seguridad Vecinal',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 40),
              
              Text('Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Ej: Juan Perez',
                ),
              ),
              
              SizedBox(height: 20),
              
              Text('Código de Acceso', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _codigoController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Código del vecindario',
                  suffixIcon: Icon(Icons.visibility_off),
                  helperText: "Prueba con: VECINO2024" // Pista para probar
                ),
              ),
              
              SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('INGRESAR AL SISTEMA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
