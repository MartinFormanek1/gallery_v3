import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/database/user_register.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/login/login.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';
import 'package:page_transition/page_transition.dart';

class MyRegister extends StatefulWidget {
  final Function toggleView;
  MyRegister({this.toggleView});

  @override
  _MyRegisterState createState() => _MyRegisterState();
  static const routeName = '/register';
}

//final AuthService _auth = AuthService();
GlobalKey<FormState> _regFormKey =
    GlobalKey<FormState>(debugLabel: '_regFormKey');
bool isBtnDisabled = true;

final UserRegistration _auth = UserRegistration();

String email = '';
String emailValid = '';
String password = '';
String confPass = '';
String error = '';
String username = '';

class _MyRegisterState extends State<MyRegister> {
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
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ColorPallete.vermillion,
        title: Text('Sign Up to Gallery'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              icon: Icon(
                Icons.person,
                color: ColorPallete.fullWhite,
              ),
              label: Text(
                'Sign In',
                style: TextStyle(
                  color: ColorPallete.fullWhite,
                ),
              ),
              onPressed: () => (isBtnDisabled)
                  ? null
                  : Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: MyLogin(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
            ),
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
                style: TextStyle(
                  color: CustomTheme.getTheme
                      ? ColorPallete.fullBlack
                      : ColorPallete.fullWhite,
                ),
                decoration: CustomInputDecoration.authDecoration
                    .copyWith(hintText: 'Username'),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Field must not be empty.';
                  }
                  if (val.length < 3) {
                    return 'Username must have at least 3 characters.';
                  }
                  return null;
                },
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
                style: TextStyle(
                  color: CustomTheme.getTheme
                      ? ColorPallete.fullBlack
                      : ColorPallete.fullWhite,
                ),
                decoration: CustomInputDecoration.authDecoration
                    .copyWith(hintText: 'Email'),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Field must not be empty.';
                  }
                  if (!EmailValidator.validate(email)) {
                    return 'Email is not valid.';
                  }
                  return null;
                },
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
                style: TextStyle(
                  color: CustomTheme.getTheme
                      ? ColorPallete.fullBlack
                      : ColorPallete.fullWhite,
                ),
                decoration: CustomInputDecoration.authDecoration
                    .copyWith(hintText: 'Password'),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Field must not be empty.';
                  }
                  if (val.length < 6) {
                    return 'Password must be longer than 6 characters.';
                  }
                  return null;
                },
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
              TextFormField(
                style: TextStyle(
                  color: CustomTheme.getTheme
                      ? ColorPallete.fullBlack
                      : ColorPallete.fullWhite,
                ),
                decoration: CustomInputDecoration.authDecoration
                    .copyWith(hintText: 'Confirm Password'),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Field must not be empty.';
                  }
                  if (confPass != password) {
                    return 'Passwords must match.';
                  }
                  return null;
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    confPass = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorPallete.vermillion),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                ),
                onPressed: () async {
                  if (_regFormKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailPassword(
                        email, password, username);
                    if (result == null) {
                      error = 'there was an error';
                      print(error);
                    } else {
                      Navigator.of(context).pushReplacement(Home.route);
                    }
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: ColorPallete.fullWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
