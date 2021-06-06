import 'package:flutter/material.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:page_transition/page_transition.dart';

import '../authentication.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
  static const routeName = '/register';
}

//final AuthService _auth = AuthService();
GlobalKey<FormState> _regFormKey =
    GlobalKey<FormState>(debugLabel: '_regFormKey');
bool isBtnDisabled = true;

final UserAuth _auth = UserAuth();

String email = '';
String password = '';
String error = '';
String username = '';

class _RegisterState extends State<Register> {
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
        title: Text('Sign Up to Gallery'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => (isBtnDisabled)
                ? null
                : Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Login(), type: PageTransitionType.fade)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _regFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                //decoration: textInputDecoration.copyWith(hintText: 'username'),
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                validator: (val) => val.isEmpty ? 'Enter a username' : null,
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                //decoration: textInputDecoration.copyWith(hintText: 'email'),
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
                //decoration: textInputDecoration.copyWith(hintText: 'password'),
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
                  if (_regFormKey.currentState.validate()) {
                    /*setState(() {
                      loading = true;
                    });*/
                    dynamic result = await _auth.registerWithEmailPassword(
                        email, password, username);
                    Navigator.of(context).pushReplacement(Home.route);
                    if (result == null) {
                      /*setState(() {
                        loading = false;
                        error = 'there was an error';
                      });*/
                    }
                  }
                },
                child: Text(
                  'Register',
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
