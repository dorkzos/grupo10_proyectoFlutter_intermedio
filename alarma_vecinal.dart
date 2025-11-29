import 'package:flutter/material.dart';
import 'package:inter/configuracion.dart';

class AlarmaVecinal extends StatefulWidget {
  final String nombreUsuario;

  const AlarmaVecinal({super.key, this.nombreUsuario = "Josue Chino"});

  @override
  State<AlarmaVecinal> createState() => _AlarmaVecinalState();
}

class _AlarmaVecinalState extends State<AlarmaVecinal> {
  late String nombreActual;
  String direccionActual = "Calle Principal #123";
  String telefonoActual = "79538888"; 
  String tipoSangreActual = "O+"; 

  @override
  void initState() {
    super.initState();
    nombreActual = widget.nombreUsuario.isEmpty ? "Josue Chino" : widget.nombreUsuario;
  }

  Future<void> _irAConfiguracion() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Configuracion(
          nombreActual: nombreActual,
          direccionActual: direccionActual,
          telefonoActual: telefonoActual,
          tipoSangreActual: tipoSangreActual,
        ),
      ),
    );

    if (resultado != null) {
      setState(() {
        nombreActual = resultado['nuevoNombre'];
        direccionActual = resultado['nuevaDireccion'];
        telefonoActual = resultado['nuevoTelefono'];
        tipoSangreActual = resultado['nuevoSangre'];
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("¡Perfil actualizado con éxito!"), backgroundColor: Colors.green),
      );
    }
  }

  final List<Map<String, dynamic>> alertas = [
    {'titulo': 'Médica', 'icono': Icons.medical_services, 'color': Colors.redAccent},
    {'titulo': 'Policía', 'icono': Icons.local_police, 'color': Colors.blue[800]},
    {'titulo': 'Incendio', 'icono': Icons.local_fire_department, 'color': Colors.orange[800]},
    {'titulo': 'Sospechoso', 'icono': Icons.visibility, 'color': Colors.grey[700]},
    {'titulo': 'Alarma', 'icono': Icons.notifications_active, 'color': Colors.amber[700]},
    {'titulo': 'Luces', 'icono': Icons.lightbulb, 'color': Colors.yellow[700]},
  ];

  List<Map<String, String>> historialAlertas = [
    {'usuario': 'Guardia', 'tipo': 'Ronda iniciada', 'hora': 'Hace 10 min'},
  ];

  void _simularNotificacionPush(String tipoAlerta) {
    final snackBar = SnackBar(
      content: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.notification_important, color: Colors.red),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ALERTA DE SEGURIDAD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text("Has enviado una alerta de: $tipoAlerta", style: TextStyle(fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150,
        left: 10,
        right: 10
      ),
      duration: Duration(seconds: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _procesarEnvio(String alerta) {
    setState(() {
      historialAlertas.insert(0, {
        'usuario': 'Tú',
        'tipo': alerta,
        'hora': 'Ahora'
      });
    });
    _simularNotificacionPush(alerta);
  }

  void _confirmarAlerta(String titulo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¿Enviar Alerta?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Se notificará a todos los vecinos."),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Usuario: $nombreActual", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Teléfono: $telefonoActual"),
                  Text("Tipo Sangre: $tipoSangreActual"),
                  Text("Ubicación: $direccionActual", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            )
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _procesarEnvio(titulo);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: Text("ENVIAR AHORA"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Centramos el título como pediste
        
        // --- TÍTULO CON VIDA Y ESTILO ---
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono rojo vibrante para darle "vida" y sentido de alerta
                Icon(Icons.security_rounded, color: Colors.redAccent, size: 28),
                SizedBox(width: 8),
                Text(
                  "ALARMA VECINAL",
                  style: TextStyle(
                    color: Colors.blue[900], // Azul oscuro para contraste
                    fontSize: 22, 
                    fontWeight: FontWeight.w900, // Letra muy gruesa (Impacto)
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            // Subtítulo pequeño
            Text(
              "Hola, $nombreActual",
              style: TextStyle(
                color: Colors.grey[600], 
                fontSize: 13, 
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.blue[800]),
              onPressed: _irAConfiguracion,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemCount: alertas.length,
              itemBuilder: (context, index) {
                return _buildCard(alertas[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.history, size: 20, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  "Historial de Alertas", 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 16)
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: historialAlertas.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  color: Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200)
                  ),
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.history_toggle_off, size: 20, color: Colors.blue[300]),
                    ),
                    title: Text(historialAlertas[index]['tipo']!, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${historialAlertas[index]['usuario']} • ${historialAlertas[index]['hora']}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _confirmarAlerta(item['titulo']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: item['color'].withOpacity(0.2),
              blurRadius: 10, 
              offset: Offset(0, 5)
            )
          ],
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icono'], size: 40, color: item['color']),
            ),
            SizedBox(height: 12),
            Text(
              item['titulo'], 
              style: TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]
              )
            ),
          ],
        ),
      ),
    );
  }
}
