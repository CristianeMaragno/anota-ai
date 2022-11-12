import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Result extends StatefulWidget {
  Barcode url;
  Result({Key? key, required this.url}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    super.initState();// I don't know why, there's no output in this line.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
      ),
      body: Container(
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
      )
    );
  }
}

Future postRequest(String? url) async {
  // todo - fix baseUrl
  var urlApi = "https://api-anotai.herokuapp.com/anotai";
  var body = json.encode({
    'url': url
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

  List<NoteData> notes = [];
  for (var u in responseDecoded) {
    NoteData note = NoteData(u[2], u[1]);
    notes.add(note);
  }
  return notes;
}

class NoteData {
  final String descricao;
  final String data;

  NoteData(this.descricao, this.data);
}