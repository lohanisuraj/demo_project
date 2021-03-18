import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:demo_project/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url = 'https://jsonplaceholder.typicode.com/posts';
  bool loading = true;

  var _suggestionTextFieldController = TextEditingController();

  List<int> id = [];
  List<String> title = [];
  List<String> body = [];

  _getData() async {
    try {
      for (int i = 1; i <= 12; i++) {
        String temp = url + '/$i';
        final response = await http.get(temp);
        if (response.statusCode == 200) {
          var jsonBody = json.decode(response.body);
          id.add(jsonBody['id']);
          title.add(jsonBody['title']);
          body.add(jsonBody['body']);
        }
      }
      if (id.isNotEmpty) {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print('error found');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
            children: [
              SizedBox(height: 50.0,),
              AutoCompleteTextField(
                    controller: _suggestionTextFieldController,
                    clearOnSubmit: false,
                    itemSubmitted: (item){
                      _suggestionTextFieldController.text = item;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(item)),
                      );
                    },
                    key: null,
                    suggestions: title,
                    style: TextStyle(fontSize: 16.0,color: Colors.blue),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 16.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                    ),
                    itemBuilder: (context,item){
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(child: Text(item,style: TextStyle(fontSize: 16.0),))
                          ],
                        ),
                      );
                    },
                    itemSorter: (a,b){
                      return a.compareTo(b);
                    },
                    itemFilter: (item,query){
                      return item.toLowerCase().contains(query.toLowerCase());
                    }),
                Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                        itemCount: id.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              leading: Icon(Icons.arrow_right),
                              title: Text(
                                title[index],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.lightBlue),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailScreen(body[index])),
                                );
                              },
                            ),
                          );
                        })),
              ),
            ],
          ),
    );
  }
}
