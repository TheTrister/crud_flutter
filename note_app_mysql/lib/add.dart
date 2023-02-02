import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
//inisialize field
  //var id = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var level = TextEditingController();
  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse("http://10.4.36.34/latihan_api/create.php"),
        body: {
          //"id": id.text,
          "username": username.text,
          "password": password.text,
          "level": level.text,
        },
      ).then((value) {
//print message after insert to database
//you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'ID',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 5),
              // TextFormField(
              //   controller: id,
              //   decoration: InputDecoration(
              //       hintText: "Masukan iD",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //       ),
              //       fillColor: Colors.white,
              //       filled: true),
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16,
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Penting!';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(height: 5),
              Text(
                'USERNAME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: username,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Masukan Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    filled: true),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Penting!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 5),
              Text(
                'PASSWORD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Masukan Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    filled: true),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Penting!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 5),
              Text(
                'LEVEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: level,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Masukan LEVEL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.white,
                    filled: true),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Penting!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
//validate
                  if (_formKey.currentState!.validate()) {
//send data to database with this method
                    _onSubmit();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
