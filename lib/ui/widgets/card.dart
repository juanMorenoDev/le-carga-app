import 'package:flutter/material.dart';
import 'package:le_carga_app/main.dart';
import 'package:le_carga_app/service/calls_service.dart';

Widget getCard(person) {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  var name = person['name'];
  var pic = 'assets/truck-icon.jpg';
  _getElements(List<dynamic> data) {
    String result = '';
    for (var i = 0; i < data.length; i++) {
      if (i > 0) result += ',';
      result += data[i];
    }
    return result;
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
                image:
                    DecorationImage(fit: BoxFit.cover, image: AssetImage(pic))),
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
                _getElements(person['city']),
                style: TextStyle(fontSize: 10),
              ),
              Text(
                person['phone'],
                style: TextStyle(fontSize: 10),
              ),
              Text(
                _getElements(person['carType']),
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
