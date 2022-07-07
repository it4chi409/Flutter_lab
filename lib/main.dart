// @dart=2.9
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController pass = TextEditingController();
  var encryptedS = 'null';
  var new_key = 'null';
  var text = 'null';
  final password = "S3cure_Str1ng";
  var cryptor = new PlatformStringCryptor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("String Encrypt"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: 'String',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue)),
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.white,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                var new_key = await Generate_key();
                print(new_key);
                Encrypt(new_key);
              },
              child: Text("Encrypt"),
            ),
            RaisedButton(
              onPressed: () {
                // Decrypt(encryptedS, key);
              },
              child: Text("Decrypt"),
            ),
          ],
        ),
      ),
    );
  }

// method to Encrypt String Password
  Future<String> Generate_key() async {
    try {
      cryptor = PlatformStringCryptor();
      var key = 'null';
      final salt = await cryptor.generateSalt();
      key = await cryptor.generateKeyFromPassword(password, salt);
      // here pass the password entered by user and the key
      print("Encryption Key : ");
      print(key);
      print("Salt: ");
      print(salt);
      return key;
    } on MacMismatchException {
      return "ERROR";
    }
  }

  // Decrypt(encryptedS, key) async{
  //   try{
  //     //here pass encrypted string and the key to decrypt it
  //     decryptedS = await cryptor.decrypt(encryptedS, key);
  //     print(decryptedS);
  //     print(key);
  //   }on MacMismatchException{
  //   }
  // }
  Future<String> Encrypt(key) async {
    try {
      cryptor = PlatformStringCryptor();
      text = pass.text;
      encryptedS = await cryptor.encrypt(text, key);
      print("Encrypted String :");
      print(encryptedS);
      return encryptedS;
    } on MacMismatchException {
      return "ERROR";
    }
  }
}
// method to decrypt String Password
