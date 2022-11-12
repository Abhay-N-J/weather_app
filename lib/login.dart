import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = "", _passwd = "";
  bool vis = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _passwd = value.trim();
                });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
              // color: Theme.of(context).accentColor,
              child: const Text('Sign-in'),
              onPressed: () {
                _auth
                    .signInWithEmailAndPassword(
                        email: _email, password: _passwd)
                    .then((_) {
                  setState(() {
                    vis = false;
                  });
                  if (_auth.currentUser?.uid == null) {
                    setState(() {
                      vis = true;
                    });
                  }

                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => const Home()));
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Home.route, (route) => false);
                });
              },
            ),
            ElevatedButton(
              // color: Theme.of(context).accentColor,
              child: const Text('Sign-up'),
              onPressed: () {
                _auth
                    .createUserWithEmailAndPassword(
                        email: _email, password: _passwd)
                    .then((_) {
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => const Home()));
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Home.route, (route) => false);
                });
              },
            ),
            Visibility(
                visible: vis,
                child: const Text(
                  "Login failed",
                  selectionColor: Colors.red,
                ))
          ])
        ],
      ),
    ));
  }
}
