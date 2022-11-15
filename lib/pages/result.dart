import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import './home.dart';
import '../utils/secure_storage.dart';
import '../utils/shared_preferences.dart';
import '../entities/item_data.dart';

class Result extends StatefulWidget {
  Barcode url;
  Result({Key? key, required this.url}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool loadedList = true;
  @override
  void initState() {
    super.initState();// I don't know why, there's no output in this line.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 400,
                  child: FutureBuilder(
                      future: postRequest(widget.url.code),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              child: Center(
                                child: Text('Carregando...'),
                              )
                          );
                        } else
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title:  Text(snapshot.data[i].descricao),
                                  subtitle: Text(snapshot.data[i].data),
                                );
                              });
                      }
                  )
              ),
              if (loadedList)
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () => {
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

Future postRequest(String? url) async {
  final email = await UserSecureStorage.getUserEmail() ?? '';

  var urlApi = "https://api-anotai.herokuapp.com/anotai";
  var body = json.encode({
    'url': url,
    'email': email
  });

  var response = await http.post(
    Uri.parse(urlApi),
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json-patch+json',
    },
    body: body,
  );
  // todo - handle non-200 status code, etc

  var responseDecoded = json.decode(response.body);

  List<ItemData> note = [];
  for (var u in responseDecoded) {
    ItemData item = ItemData(descricao: u[2], data: u[1]);
    note.add(item);
  }
  saveNote(note);

  return note;
}

void saveNote(List<ItemData> note) async {
  List notesData = [];
  String notes = UserPreferences.getUserNotes() ?? '';

  if(notes != ''){
    List notesList = jsonDecode(notes);
    for (var note in notesList) {
      List<ItemData> itemsList = [];
      for (var item in note) {
        itemsList.add(ItemData().fromJson(item));
      }
      notesData.add(itemsList.map((e) => e.toJson()).toList());
    }
  }
  notesData.add(note.map((e) => e.toJson()).toList());

  String noteEncoded = jsonEncode(notesData);
  print('Encoded note: $noteEncoded');

  await UserPreferences.setUserNotes(noteEncoded);
}