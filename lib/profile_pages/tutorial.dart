import 'package:division/division.dart';
import 'package:flutter/material.dart';

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
        title: Text('Tutorial'),
        centerTitle: true,
        backgroundColor: rgb(28,27,27),
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
            children: const [

              // imagen bacan

              Text(
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
            children: const [

              // imagen bacan

              Text(
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
            children: const [

              // imagen bacan

              Text(
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
            children: const [

              // imagen bacan
              
              Text(
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
      child: const Text("Volver al Perfil"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: Color(0xFF993A84),
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




