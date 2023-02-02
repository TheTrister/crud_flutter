import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Edit extends StatefulWidget {
  Edit({required this.id});
  String id;
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
//inisialize field
  var id= TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var level = TextEditingController();
  @override
  void initState() {
    super.initState();
//in first time, this method will be executed
    _getData();
  }

//Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
//you have to take the ip address of your computer.
//because using localhost will cause an error
//get detail data with id
          "http://10.4.36.34/latihan_api/detail.php?ID='${widget.id}'"));
// if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          id = TextEditingController(text: data['ID'].toString());
          username = TextEditingController(text: data['USERNAME'].toString());
          password = TextEditingController(text: data['PASSWORD'].toString());
          level = TextEditingController(text: data['LEVEL'].toString());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse("http://10.4.36.34/latihan_api/update.php"),
        body: {
          "id": id.text,
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

  Future _onDelete(context) async {
    try {
      return await http.post(
        Uri.parse("http://10.4.36.34/latihan_api/delete.php"),
        body: {
          "id": widget.id,
        },
      ).then((value) {
//print message after insert to database
//you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);
// Remove all existing routes until the home.dart, then rebuild
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
        title: Text("EDIT DATA NO :" + widget.id),
// ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
//show dialog to confirm delete data
                      return AlertDialog(
                        content: Text('Are you sure you want to delete this?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check_circle),
                            onPressed: () => _onDelete(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: id,
                decoration: InputDecoration(
                    hintText: "Masukan iD",
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
              SizedBox(height: 15),
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
                    _onUpdate(context);
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
