import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
            appBar: AppBar(
  backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
  title: Container(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'Terminos y condiciones',
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
            children:const  [
              Text("Términos y Condiciones", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 16.0),
Text("Propósito de la App:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("La aplicación Buscador de Eventos JODAP (“App”) está diseñada para proporcionar a los usuarios información sobre eventos que suceden en todo Chile. La App permite a los usuarios buscar eventos según la ubicación, fecha y tipo de evento.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Información del usuario:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("Para usar la App, los usuarios deben registrarse con su nombre completo, correo electrónico y edad. JODAP COMPANY no utilizará la información del usuario para ningún otro propósito que no sea mejorar la App y comprender qué eventos son de interés para los usuarios.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Contenido:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("JODAP COMPANY es responsable del contenido que aparece en la App. El contenido proviene de una base de datos de eventos en Chile y se actualiza regularmente para garantizar la precisión. Los usuarios no pueden cargar o crear contenido en la App.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Propiedad intelectual:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("La App y todo su contenido, incluyendo, pero no limitado a, texto, imágenes y gráficos, son propiedad intelectual de JODAP COMPANY. Los usuarios no están autorizados para reproducir, modificar o distribuir ningún contenido en la App sin el consentimiento expreso por escrito de JODAP COMPANY.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Responsabilidad:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("JODAP COMPANY no se hace responsable de ningún error o inexactitud en el contenido de la App, ni de ningún daño que pueda resultar del uso de la App o de su contenido. JODAP COMPANY no ofrece garantías o representaciones de ningún tipo, expresas o implícitas, sobre la integridad, precisión, confiabilidad, adecuación o disponibilidad con respecto a la App o la información contenida en la App.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Resolución de disputas:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("En caso de una disputa entre un usuario y JODAP COMPANY, el usuario puede informar la disputa por escrito a JODAP COMPANY. JODAP COMPANY hará todo lo posible para resolver la disputa de manera justa y eficiente. Si la disputa no se puede resolver, puede ser llevada al tribunal adecuado en Chile para su resolución.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Cambios en los Términos y Condiciones:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("JODAP COMPANY se reserva el derecho de modificar estos Términos y Condiciones en cualquier momento. Cualquier cambio en los Términos y Condiciones será publicado en la aplicación y tendrá efecto inmediato al momento de su publicación.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
Text("Aceptación de Términos y Condiciones:", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
Text("Al utilizar la aplicación, los usuarios se consideran que han aceptado estos Términos y Condiciones en su totalidad.",style: TextStyle(color: Colors.grey)),
SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    }
  }
