import 'package:flutter/material.dart';
import 'package:inter/configuracion.dart';

class AlarmaVecinal extends StatefulWidget {
  // Recibimos el usuario logueado para personalizar la experiencia
  final String nombreUsuario;

  const AlarmaVecinal({super.key, this.nombreUsuario = "Usuario"});

  @override
  State<AlarmaVecinal> createState() => _AlarmaVecinalState();
}

class _AlarmaVecinalState extends State<AlarmaVecinal> {
  final String direccionUsuario = "Calle Los Olivos #123";

  // Lógica de Notificaciones: Lista simulada de alertas recientes
  List<Map<String, String>> historialAlertas = [
    {'usuario': 'Maria (Vecina)', 'tipo': 'Sospechoso', 'hora': 'Hace 5 min'},
    {'usuario': 'Guardia Garita', 'tipo': 'Ronda Iniciada', 'hora': 'Hace 15 min'},
  ];

  final List<Map<String, dynamic>> alertas = [
    {'titulo': 'Emergencia Médica', 'icono': Icons.local_hospital, 'color': Colors.redAccent},
    {'titulo': 'Policía', 'icono': Icons.local_police, 'color': Colors.blue},
    {'titulo': 'Incendio', 'icono': Icons.local_fire_department, 'color': Colors.orange},
    {'titulo': 'Sospechoso', 'icono': Icons.visibility, 'color': Colors.grey},
    {'titulo': 'Alarma Sonora', 'icono': Icons.notifications_active, 'color': Colors.amber},
    {'titulo': 'Luces', 'icono': Icons.lightbulb, 'color': Colors.yellow.shade700},
  ];

  void _mostrarConfirmacion(BuildContext context, String tipoAlerta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 10),
              Expanded(child: Text("Confirmar Alerta")),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("¿Confirmar envío de alerta a todos los vecinos?"),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tipo: $tipoAlerta", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Emisor: ${widget.nombreUsuario}"),
                    Text("Ubicación: $direccionUsuario"),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _simularEnvio(tipoAlerta);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: Text("ENVIAR AHORA"),
            ),
          ],
        );
      },
    );
  }

  // Lógica de Notificaciones: Agrega la alerta al historial local y muestra feedback
  void _simularEnvio(String alerta) {
    setState(() {
      historialAlertas.insert(0, {
        'usuario': 'Tú',
        'tipo': alerta,
        'hora': 'Ahora mismo'
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text("Notificación de $alerta enviada a la comunidad.")),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: Duration(seconds: 4),
        action: SnackBarAction(label: "DESHACER", textColor: Colors.white, onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Panel de Seguridad", style: TextStyle(color: Colors.black87, fontSize: 18)),
            Text("Hola, ${widget.nombreUsuario}", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Configuracion()),
              );
            },
            icon: CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sección de Botones de Pánico
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
            child: Text(
              "Activar Alerta",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: alertas.length,
              itemBuilder: (context, index) {
                return _buildAlertCard(alertas[index]);
              },
            ),
          ),
          
          Divider(thickness: 5, color: Colors.grey[200]),

          // Sección de Historial de Notificaciones (Lógica Visual)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Actividad Reciente", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Icon(Icons.history, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: historialAlertas.length,
              itemBuilder: (context, index) {
                final notificacion = historialAlertas[index];
                bool esMio = notificacion['usuario'] == 'Tú';
                return Card(
                  elevation: 0,
                  color: esMio ? Colors.blue[50] : Colors.grey[50],
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: esMio ? Colors.blue : Colors.grey,
                      child: Icon(Icons.notifications, color: Colors.white, size: 20),
                      radius: 16,
                    ),
                    title: Text(
                      "${notificacion['tipo']} - ${notificacion['usuario']}",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      notificacion['hora']!,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    dense: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _mostrarConfirmacion(context, item['titulo']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: Offset(0, 2))
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item['icono'], size: 32, color: item['color']),
            SizedBox(height: 8),
            Text(
              item['titulo'],
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
