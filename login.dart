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

  // --- BASE DE DATOS SIMULADA ---
  // Actualizado para aceptar el nuevo código 2025
  List<Map<String, String>> usuariosRegistrados = [
    {'nombre': 'Josue Chino', 'codigo': 'CODIGO2025'}, // Usuario por defecto pedido
    {'nombre': 'Maria Lopez', 'codigo': '1234'},
    {'nombre': 'Admin', 'codigo': 'CODIGO2025'}
  ];

  void _iniciarSesion() {
    String usuarioIngresado = _usuarioController.text.trim();
    String codigoIngresado = _codigoController.text.trim();

    if (usuarioIngresado.isEmpty || codigoIngresado.isEmpty) {
      _mostrarSnack("Por favor llena todos los campos.", Colors.orange);
      return;
    }

    bool credencialesValidas = false;
    String nombreReal = usuarioIngresado;

    // Validación flexible: Permite entrar si el código es CODIGO2025 directamente
    // o si coincide con un usuario registrado.
    if (codigoIngresado == "CODIGO2025") {
      credencialesValidas = true;
    } else {
      for (var usuario in usuariosRegistrados) {
        if (usuario['codigo'] == codigoIngresado) {
          credencialesValidas = true;
          break;
        }
      }
    }

    if (credencialesValidas) {
      _mostrarSnack("¡Bienvenido, $nombreReal!", Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AlarmaVecinal(nombreUsuario: nombreReal),
        ),
      );
    } else {
      _mostrarSnack("Código incorrecto. Intenta con CODIGO2025", Colors.red);
    }
  }

  void _mostrarDialogoRegistro() {
    TextEditingController nuevoNombreCtrl = TextEditingController();
    TextEditingController nuevoCodigoCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.person_add, color: Colors.blue),
            SizedBox(width: 10),
            Text("Nuevo Vecino"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nuevoNombreCtrl,
              decoration: InputDecoration(
                labelText: "Tu Nombre (Ej. Josue Chino)",
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nuevoCodigoCtrl,
              decoration: InputDecoration(
                labelText: "Crea tu Código",
                prefixIcon: Icon(Icons.vpn_key),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nuevoNombreCtrl.text.isNotEmpty && nuevoCodigoCtrl.text.isNotEmpty) {
                setState(() {
                  usuariosRegistrados.add({
                    'nombre': nuevoNombreCtrl.text.trim(),
                    'codigo': nuevoCodigoCtrl.text.trim(),
                  });
                  _usuarioController.text = nuevoNombreCtrl.text;
                  _codigoController.text = nuevoCodigoCtrl.text;
                });
                Navigator.pop(context);
                _mostrarSnack("¡Registro Exitoso!", Colors.blue);
              }
            },
            child: Text("REGISTRARME"),
          ),
        ],
      ),
    );
  }

  void _mostrarSnack(String mensaje, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.security, size: 90, color: Colors.blueAccent),
              SizedBox(height: 10),
              Text(
                'ALERTA VECINAL',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              Text(
                'Protección Comunitaria 2025',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 40),

              TextField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Usuario (Ej. Josue Chino)',
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _codigoController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Código de Acceso',
                  filled: true,
                  fillColor: Colors.grey[100],
                  helperText: "Código actual: CODIGO2025" // Ayuda visual
                ),
              ),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('INGRESAR', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              SizedBox(height: 20),
              
              OutlinedButton.icon(
                onPressed: _mostrarDialogoRegistro,
                icon: Icon(Icons.person_add_alt),
                label: Text("Soy nuevo, quiero registrarme"),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
