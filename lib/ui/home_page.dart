import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:le_carga_app/ui/widgets/card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    var url = 'https://randomuser.me/api/?results=20';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      setState(() {
        users = items;
      });
      print(items);
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('log out'),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
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
