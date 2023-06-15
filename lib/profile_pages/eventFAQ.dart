import 'package:flutter/material.dart';

class EventFAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
  backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
  title: Container(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'JodapFAQ',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF993A84),
      ),
    ),
  ),
),
        body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. ¿De qué se trata la aplicación de búsqueda de eventos?",  style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text("La aplicación de búsqueda de eventos es una plataforma que ayuda a los usuarios a descubrir y asistir a varios eventos en su área.",style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.0),
              Text("2. ¿Cómo funciona la aplicación?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("La aplicación utiliza la ubicación del usuario para mostrarles una lista de eventos cercanos. Luego, pueden filtrar los eventos según sus preferencias y elegir asistir a un evento.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("3. ¿Es gratis usar la aplicación?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Sí, la aplicación se puede descargar y utilizar de forma gratuita.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("4. ¿Necesito crear una cuenta para usar la aplicación?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Sí, necesitas crear una cuenta para acceder a todas las funciones de la aplicación y confirmar asistencia a eventos.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("5. ¿Puedo agregar mi propio evento a la aplicación?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Sí, la aplicación permite a los usuarios agregar sus propios eventos y promocionarlos a una audiencia más amplia.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("6. ¿Cómo sé si un evento es adecuado para mí?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("La aplicación proporciona una descripción detallada de cada evento y su público objetivo, lo que puede ayudarte a determinar si el evento es adecuado para ti.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("7. ¿Puedo ver eventos que ocurren en otras ciudades?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Sí, la aplicación te permite buscar eventos en cualquier ubicación ingresando el nombre de la ciudad.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("8. ¿Cómo puedo contactar al organizador del evento si tengo alguna pregunta?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Puedes contactar al organizador del evento a través de la aplicación utilizando la información de contacto proporcionada en la página de detalles del evento.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("9. ¿Puedo cancelar mi confirmación de asistencia a un evento?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("Sí, puedes cancelar tu confirmación de asistencia a un evento si cambias de opinión. Simplemente ve a la página de detalles del evento y haz clic en el botón 'Cancelar confirmación de asistencia'.",style: TextStyle(color: Colors.grey)),
              Text("10. ¿Cómo sabré si se cancela un evento?", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8.0),
Text("La aplicación te enviará una notificación si un evento al que te hayas apuntado se cancela por parte del organizador.",style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

