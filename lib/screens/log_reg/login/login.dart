import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/register/register.dart';
import 'package:page_transition/page_transition.dart';

import '../authentication.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  static const routeName = '/login';
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _logFormKey =
      GlobalKey<FormState>(debugLabel: '_logFormKey');
  bool isBtnDisabled = true;

  final UserAuth _auth = UserAuth();

  String email = '';
  String password = '';
  String error = '';

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          isBtnDisabled = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Sign in to Gallery'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Register',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () => (isBtnDisabled)
                ? null
                : Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Register(), type: PageTransitionType.fade)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _logFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (val) => val.length < 6
                    ? 'Enter a password longer than 6 characters'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.pink[400],
                onPressed: () async {
                  if (_logFormKey.currentState.validate()) {
                    /* setState(() {
                      loading = true;
                    });*/
                    dynamic result =
                        await _auth.signInWithEmailPass(email, password);
                    Navigator.of(context).pushReplacement(Home.route);
                    if (result == null) {
                      setState(() {
                        //loading = false;
                        error = 'there was an error';
                      });
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
