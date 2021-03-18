import 'package:demo_project/screens/login.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String body;

  DetailScreen(this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Image.asset('images/program.jfif')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              body,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Close',style: TextStyle(
                  fontSize: 26.0,
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
