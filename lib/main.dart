import 'package:flutter/material.dart';
import 'package:ssh/ssh.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    title: "Mei",
    theme: ThemeData(
      primaryColor: Colors.orange,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isConnected = false;
  final urlController = TextEditingController();
  final portController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var client;
  Future<void> sshConnect() async {
    if (urlController.text == '' ||
        portController.text == '' ||
        usernameController.text == '' ||
        passwordController.text == '') {
      Fluttertoast.showToast(
        msg: "Cannot leave empty fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
      );
      return;
    }
    client = new SSHClient(
      host: urlController.text,
      port: int.parse(portController.text),
      username: usernameController.text,
      passwordOrKey: passwordController.text,
    );
    String res = '';
    try {
      res = await client.connect();
    } catch (e) {
      print("---------------------\n$e\n--------------------------");
    }
    if (res == "session_connected") {
      _isConnected = true;
    } else {
      Fluttertoast.showToast(
        msg: "Cannot connect",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget HomePage = Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Mei",
                      style: TextStyle(
                        fontSize: 120,
                      ),
                    ),
                  ),
                  SizedBox(height: 110),
                  TextField(
                    obscureText: false,
                    controller: urlController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Host IP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    obscureText: false,
                    controller: portController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Port',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    obscureText: false,
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  FloatingActionButton(
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.check),
                    onPressed: () {
                      _isConnected = true;
                      setState(() {
                        
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    Widget MainApp = Scaffold(
        appBar: AppBar(
          title: Text("Mei"),
        ),
        body: Center(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      iconSize: 100.0,
                      icon: Icon(Icons.lock_open),
                    ),
                    SizedBox(height: 100),
                    IconButton(
                      onPressed: () {},
                      iconSize: 100.0,
                      icon: const Icon(Icons.lock_outline),
                    ),
                  ],
                )),
          ),
        ));
    if (_isConnected) {
      return MainApp;
    } else {
      return HomePage;
    }
  }
}
