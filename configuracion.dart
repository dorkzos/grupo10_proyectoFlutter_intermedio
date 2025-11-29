import 'package:flutter/material.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  // Controladores para manejar el estado de los inputs
  late TextEditingController _nombreController;
  late TextEditingController _contactoController;
  late TextEditingController _direccionController;

  @override
  void initState() {
    super.initState();
    // Simulamos datos cargados
    _nombreController = TextEditingController(text: "Juan Pérez");
    _contactoController = TextEditingController(text: "+591 79538888");
    _direccionController = TextEditingController(text: "Calle Los Olivos #123");
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _contactoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    // Simular guardado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Datos actualizados correctamente"),
        backgroundColor: Colors.green,
      ),
    );
    // Opcional: Volver atrás después de guardar
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil y Seguridad'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Importante para evitar error de overflow con teclado
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            
            _buildLabel('Nombres y Apellidos'),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                suffixIcon: Icon(Icons.edit, size: 18),
              ),
            ),
            
            SizedBox(height: 20),
            
            _buildLabel('Dirección del Domicilio'),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_outlined),
                suffixIcon: Icon(Icons.edit, size: 18),
              ),
            ),

            SizedBox(height: 20),
            
            _buildLabel('Contacto de Emergencia (SOS)'),
            TextField(
              controller: _contactoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_in_talk, color: Colors.redAccent),
                fillColor: Colors.red[50], // Destacar campo importante
              ),
            ),

            SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _guardarCambios,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('GUARDAR CAMBIOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
