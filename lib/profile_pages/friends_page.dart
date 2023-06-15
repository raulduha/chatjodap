import 'package:flutter/material.dart';





class FriendsPage extends StatefulWidget {
  const FriendsPage();

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
            appBar: AppBar(
  backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
  title: Container(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'Amigos',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF993A84),
      ),
    ),
  ),
),
        
      
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:  
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [

                const SizedBox(height: 20,),
                Text(
                  "Tienes X amigos",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Brand Bold",
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: TextField(
                    style: const TextStyle(
                      color: Color.fromRGBO(28, 27, 27, 1),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(28, 27, 27, 1)),
                      hintText: 'Buscar amigos',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(28, 27, 27, 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),



      ),
    );
  }
}