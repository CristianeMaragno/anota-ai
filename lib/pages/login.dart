import 'package:flutter/material.dart';
import './home.dart';
import '../utils/secure_storage.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController editingController = TextEditingController();
  var email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: editingController,
                decoration: InputDecoration(
                  labelText: 'Email',
                )
            ),
            ElevatedButton(
              child: Text('Entrar'),
              onPressed: () => {
                setState(() {
                  email = editingController.text;
                  saveUserEmail(email);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                })
              },
            )
          ],
        ),
      )
    );
  }

  void saveUserEmail(email) async {
    await UserSecureStorage.setUserEmail(email);
  }
}