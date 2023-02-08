import 'package:division/division.dart';
import 'package:flutter/material.dart';
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
              Image.asset(
                'images/binario1.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16.0),
              const Text("Report a Bug", style: TextStyle(color: Colors.grey)),
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
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // show a snackbar to confirm the bug report was sent
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bug report sent!', style: TextStyle(color: Colors.grey[300]))));

                    // clear the form
                    _problemController.clear();
                  }
                },
                child: const Text("Submit", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
                // code to send the bug report
                // ...
            )],
          ),
        ),
      ),
    ));
  }
}


