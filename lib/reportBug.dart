import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportBugPage extends StatefulWidget {
  @override
  _ReportBugPageState createState() => _ReportBugPageState();
}

class _ReportBugPageState extends State<ReportBugPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:const  Color.fromRGBO(28, 27, 27, 1),
      child: Scaffold(
        backgroundColor:const  Color.fromRGBO(28, 27, 27, 1),
        appBar: AppBar(
          backgroundColor:const Color.fromRGBO(28, 27, 27, 1),
          title: Row(
            children: [
              Container(
                child: Image.asset('images/reportbug.png',
                height: 50,
                
                )
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please describe the problem you encountered with the app:", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.grey[300])),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _problemController,
                maxLines: 5,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF993A84), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF993A84), width: 2.0),
                  ),
                ),
                style: TextStyle(color: Colors.grey[300]),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the problem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // show a snackbar to confirm the bug report was sent
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bug report sent!', style: TextStyle(color: Colors.grey[300]))));

                    // launch the email client with the problem description
                    final url = 'mailto:raulduhaldee@gmail.com?subject=Bug%20Report&body=${_problemController.text}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }

                    // clear the form
                    _problemController.clear();
                    }
                  },
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF993A84)),
                  ),
                ),
              ]
            ),
          )
        )
      )       
    );
  }
}


