import 'package:division/division.dart';
import 'package:flutter/material.dart';


class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentStep = 0;
  final int _totalSteps = 4; // usarlo para cambiar al boton al final

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgb(28, 27, 27),

            appBar: AppBar(
  backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
  title: Container(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'Tutorial',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF993A84),
      ),
    ),
  ),
),

      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: _buildStepUI(),
          ),
          
          const SizedBox(height: 40),

          Center(
            child: _buildButton(),
          ),
          
        ],
      ),
    );
  }

  Widget _buildStepUI() {
    switch (_currentStep) {

      case 0:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              // imagen bacan
              Container(
                height: 300,
                child: Image.asset(
                  "images/tutorial-1.png",
                  fit: BoxFit.cover,
                ),
                
              ),

              const Text(
                "Tienes ganas de salir con tus amigos, pero no sabes realmente a donde deberias ir?",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                
              ),
            ]
          ),
        );

      
        
      case 1:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              // imagen bacan
              Container(
                height: 300,
                child: Image.asset(
                  "images/tutorial-2.png",
                  fit: BoxFit.cover,
                ),
                
              ),

              const Text(
                "Ve en el Mapa los eventos cerca tuyo para el día que quieras!",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                
              ),
            ]
          ),
        );
        
        
      case 2:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              // imagen bacan
              Container(
                height: 300,
                child: Image.asset(
                  "images/tutorial-3.png",
                  fit: BoxFit.cover,
                ),
                
              ),

              const Text(
                "En Eventos busca el evento ideal para ti según tus preferencias! Ya sea por nombre, ambiente, promotora, etc.",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                
              ),
            ]
          ),
        );

        

      case 3:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [

              // imagen bacan
              Container(
                height: 300,
                child: Image.asset(
                  "images/tutorial-4.png",
                  fit: BoxFit.cover,
                ),
                
              ),

              const Text(
                "Adelante! tus eventos favoritos están esperandote.",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                
              ),
            ]
          ),
        );
        
        
      default:
        return Container();
    }
  }


  Widget _buildButton() {
  if (_currentStep == _totalSteps - 1) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF993A84),
      ),
      child: const Text("Volver al Perfil"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF993A84),
    ),
    child: const Text("Siguiente"),
    
    onPressed: () {
      setState(() {
        _currentStep + 1 < _totalSteps
            ? _currentStep++
            : _currentStep = 0;
      });
    },
  );
}



}




