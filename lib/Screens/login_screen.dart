import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shoping/provider/loginstat.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/servis/auth.dart';
import 'package:shoping/widgets/custom_textField.dart';

import 'admin/adminHome.dart';

class LoginScrren extends StatefulWidget {
  static String id = "/login";

  @override
  _LoginScrrenState createState() => _LoginScrrenState();
}

class _LoginScrrenState extends State<LoginScrren> {
  final loginKey = GlobalKey<FormState>();

  String _email, _password, _name;

  final auth = Auth();

  bool isAdmin = !true;

  final AdminPassworde = "123456";

  bool _isLogIn = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final modelhud = Provider.of<ModelHud>(context, listen: false);
//   / print(isLoged);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loginBG.jpg"),
              fit: BoxFit.cover),
        ),
        child: ModalProgressHUD(
          progressIndicator: JumpingDotsProgressIndicator(
            fontSize: 100.0,
          ),
          inAsyncCall: Provider.of<ModelHud>(context).isLoding,
          child: Form(
            key: loginKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Welcome.... ",
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.purple,
                                    fontFamily: "Pacifico"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 2,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Let`s Start Login Now!!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontFamily: "Pacifico"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      if (_isLogIn != true)
                        CtextField(
                          txtIcon: Icons.person,
                          hint: "Enter Your Name",
                          TextValue: (x) {
                            _name = x;
                          },
                        ),
                      if (_isLogIn != true)
                        SizedBox(
                          height: 5,
                        ),
                      CtextField(
                        txtIcon: Icons.email,
                        hint: "Enter Your Email",
                        TextValue: (x) {
                          _email = x;
                        },
                        KeyType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CtextField(
                        txtIcon: Icons.lock_outline,
                        hint: "Enter Your Password",
                        TextValue: (x) {
                          _password = x;
                        },
                        KeyType: TextInputType.visiblePassword,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => RaisedButton(
                        child: modelhud.isLoding == false
                            ? Text(
                                _isLogIn == true ? "Log in" : "Sign Up",
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              )
                            : JumpingDotsProgressIndicator(
                                fontSize: 20.0,
                              ),
                        onPressed: () async {
                          if (_isLogIn == true) {
                            await _login(context);
                          } else {
                            await _SingUp(context);
                          }
                        },
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don`t have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLogIn = !_isLogIn;
                        });
                      },
                      child: Text(
                        _isLogIn == true ? "Sign Up" : "Log In",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    loginKey.currentState.save();
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    final loginStat = LoginStat();
    modelhud.ChangeIsLoding(true);
    if (loginKey.currentState.validate()) {
      try {
        await auth.signIn(_email, _password);
        modelhud.ChangeIsLoding(true);
        Navigator.pushReplacementNamed(context, AdminHomeScreen.id);
      } on PlatformException catch (e) {
        modelhud.ChangeIsLoding(false);
        Scaffold.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
          ),
          duration: Duration(seconds: 5),
          content: Text(
            e.message,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white54,
        ));
      }

//      else {
//        modelhud.ChangeIsLoding(true);
//        Scaffold.of(context).showSnackBar(SnackBar(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(20),
//            side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
//          ),
//          duration: Duration(seconds: 5),
//          content: Text(
//            "Admin Password InValid!!",
//            style: TextStyle(color: Colors.black),
//          ),
//          backgroundColor: Colors.white54,
//        ));
//      }

//      else {
//        try {
//          await auth.signIn(_email, _password);
//
//          modelhud.ChangeIsLoding(true);
//          Navigator.pushReplacementNamed(context, HomeScreen.id);
//          loginStat.saveData(true);
//        } on PlatformException catch (e) {
//          Scaffold.of(context).showSnackBar(SnackBar(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(20),
//              side: BorderSide(color: Colors.black, style: BorderStyle.solid),
//            ),
//            duration: Duration(seconds: 5),
//            backgroundColor: Colors.white54,
//            content: Text(
//              e.message,
//              style: TextStyle(color: Colors.black),
//            ),
//          ));
//        }
//      }
      modelhud.ChangeIsLoding(false);
    }
    modelhud.ChangeIsLoding(false);
  }

  Future _SingUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.ChangeIsLoding(true);
    if (loginKey.currentState.validate()) {
      try {
        loginKey.currentState.save();
        final autthresult = await auth.signUp(_email, _password, _name);
        modelHud.ChangeIsLoding(true);
        setState(() {
          // ignore: unnecessary_statements
          _isLogIn = true;
        });
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
      }
    }
    modelHud.ChangeIsLoding(false);
  }
}
