import 'package:flutter/material.dart';

class Configuracion extends StatefulWidget {
  final String nombreActual;
  final String direccionActual;
  final String telefonoActual;
  final String tipoSangreActual;

  const Configuracion({
    super.key, 
    required this.nombreActual, 
    required this.direccionActual,
    required this.telefonoActual,
    required this.tipoSangreActual,
  });

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  late TextEditingController _nombreCtrl;
  late TextEditingController _direccionCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _tipoSangreCtrl;

  @override
  void initState() {
    super.initState();
    // Iniciamos con los valores pasados, o los por defecto si están vacíos
    _nombreCtrl = TextEditingController(text: widget.nombreActual.isEmpty ? "Josue Chino" : widget.nombreActual);
    _direccionCtrl = TextEditingController(text: widget.direccionActual);
    _telefonoCtrl = TextEditingController(text: widget.telefonoActual.isEmpty ? "79538888" : widget.telefonoActual);
    _tipoSangreCtrl = TextEditingController(text: widget.tipoSangreActual);
  }

  void _guardarYSalir() {
    Map<String, String> datosActualizados = {
      'nuevoNombre': _nombreCtrl.text,
      'nuevaDireccion': _direccionCtrl.text,
      'nuevoTelefono': _telefonoCtrl.text,
      'nuevoSangre': _tipoSangreCtrl.text,
    };
    Navigator.pop(context, datosActualizados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Datos Personales")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                  SizedBox(height: 10),
                  Text("Perfil de Usuario", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 30),
            
            _buildLabel("Nombre Completo"),
            TextField(
              controller: _nombreCtrl,
              decoration: InputDecoration(
                hintText: "Ej. Josue Chino", // Placeholder pedido
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 15),
            
            _buildLabel("Dirección"),
            TextField(
              controller: _direccionCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            SizedBox(height: 15),
            
            _buildLabel("Teléfono de Contacto"),
            TextField(
              controller: _telefonoCtrl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                hintText: "79538888", // Placeholder pedido
              ),
            ),
            SizedBox(height: 15),

            _buildLabel("Tipo de Sangre"), // NUEVO CAMPO
            TextField(
              controller: _tipoSangreCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bloodtype, color: Colors.red),
                hintText: "Ej. O+",
              ),
            ),

            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _guardarYSalir,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: Text("GUARDAR CAMBIOS"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
    );
  }
}
