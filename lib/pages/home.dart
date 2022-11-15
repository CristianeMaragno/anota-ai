import 'package:flutter/material.dart';
import './scanner.dart';
import '../utils/shared_preferences.dart';
import '../entities/item_data.dart';
import 'dart:convert';
import './note.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  List allNotesData = [];

  @override
  void initState() {
    super.initState();
    String notes = UserPreferences.getUserNotes() ?? '';
    print('Home: $notes');
    if (notes != ''){
      List notesList = jsonDecode(notes);
      for (var note in notesList) {
        List<ItemData> itemsList = [];
        for (var item in note) {
          itemsList.add(ItemData().fromJson(item));
        }
        setState(() {
          allNotesData.add(itemsList);
        });
      }
      print(allNotesData.length);
      //print('Primeiro item' + allNotesData[0][0].data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Seus cupons cadastrados',
            ),
            ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: allNotesData.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Note(note: allNotesData[index])),
                    );
                  },
                  child: ListTile(
                      title: Text(allNotesData[index][0].data)//allNotesData[index][0].data
                  )
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scanner()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}