import 'dart:convert';
import 'package:flutter/material.dart';
import '../entities/item_data.dart';
import './home.dart';

class Note extends StatefulWidget {
  List<ItemData> note;
  Note({Key? key, required this.note}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.note.length,
                      itemBuilder: (BuildContext context, int index){
                        return  ListTile(
                            title: Text(widget.note[index].descricao ?? ''),
                            subtitle: Text(widget.note[index].data ?? '')
                        );
                      }
                    )
                  ),
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () =>
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      )
                    },
                  )
                ]
            )
        )
    );
  }
}