import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gallery_v3/database/user_login.dart';
import 'package:gallery_v3/providers/my_user_provider.dart';
import 'package:gallery_v3/screens/home/home.dart';
import 'package:gallery_v3/screens/log_reg/register/register.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:gallery_v3/styles/custom_themes.dart';
import 'package:page_transition/page_transition.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key key}) : super(key: key);
  static const routeName = '/myLogin';
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const MyLogin(),
      );

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  GlobalKey<FormState> _logFormKey =
      GlobalKey<FormState>(debugLabel: '_logFormKey');
  bool isBtnDisabled = true;

  final UserLogin _auth = UserLogin();

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
      backgroundColor: CustomTheme.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ColorPallete.vermillion,
        title: Text('Sign In to Gallery'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              icon: Icon(
                Icons.person,
                color: ColorPallete.fullWhite,
              ),
              label: Text(
                'Register',
                style: TextStyle(
                  color: ColorPallete.fullWhite,
                ),
              ),
              onPressed: () => (isBtnDisabled)
                  ? null
                  : Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: MyRegister(),
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
          key: _logFormKey,
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
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorPallete.vermillion),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                ),
                onPressed: () async {
                  if (_logFormKey.currentState.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailPass(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'there was an error';
                      });
                    } else {
                      UserProvider.instance.setUser = result;
                      Navigator.of(context).pushReplacement(Home.route);
                    }
                  }
                },
                child: Text(
                  'Sign In',
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
