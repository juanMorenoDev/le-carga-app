import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:le_carga_app/ui/widgets/card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  String token = '';
  HomePage({Key key, @required this.token}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(this.token);
}

class _HomePageState extends State<HomePage> {
  String token;
  _HomePageState(this.token);
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    var url = 'https://randomuser.me/api/?results=20';
    var response = await http.get(url, headers: {'lecarga': 'widget.token'});
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      setState(() {
        users = items;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Le carga'),
        ),
        body: getBody());
  }

  Widget getBody() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (contex, index) {
        return getCard(users[index]);
      },
    );
  }
}
