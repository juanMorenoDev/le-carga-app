import 'package:flutter/material.dart';
import 'package:le_carga_app/main.dart';
import 'package:le_carga_app/service/calls_service.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getCard(person) {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  var name = person['name']['first'] + ' ' + person['name']['last'];
  var pic = person['picture']['medium'];
  _launchURL(String phone) async {
    var url = 'tel: $phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return Card(
      child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(pic))),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              SizedBox(
                height: 5,
              ),
              Text(
                person['location']['city'],
                style: TextStyle(fontSize: 10),
              ),
              Text(
                person['phone'],
                style: TextStyle(fontSize: 10),
              ),
              Text(
                person['email'],
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                _service.call(person['phone']);
              })
        ],
      ),
    ),
  ));
}
