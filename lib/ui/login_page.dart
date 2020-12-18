import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List users = [];
  bool isLoading = false;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() async {
    // var url = 'http://localhost:3000/user/login';// mock backend
    var url = 'https://lecargaback.herokuapp.com/user/login';
    setState(() {
      isLoading = true;
    });
    var response = await http.post(url,
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'username': emailController.text,
          'password': passwordController.text
        }));
    var body = json.decode(response.body);
    if (body['message'] == 'success') {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/list');
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter your email', icon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter your password', icon: Icon(Icons.lock)),
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                    child: Text(
                      "Iniciar sesion",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => this.login(),
                    color: Colors.blue),
                Visibility(
                    visible: this.isLoading,
                    child: SpinKitChasingDots(
                      color: Colors.blue,
                      size: 50.0,
                    ))
              ]),
        ),
      ),
    );
  }
}
