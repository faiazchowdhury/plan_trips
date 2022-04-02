import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plan_trips/Bloc/bloc/authentication_bloc.dart';
import 'package:plan_trips/Constants/SizeConfig.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:plan_trips/Screens/Registration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widget/ErrorText.dart';
import '../Widget/Toast.dart';
import 'HomePage.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = new TextEditingController();
  final passController = new TextEditingController();
  bool obscure = true;
  double hRatio = SizeConfig.heightRatio;
  double wRatio = SizeConfig.widthRatio;
  final bloc = new AuthenticationBloc();
  String errorText = "";

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: hRatio * 5,
              ),
              Image.asset(
                "assets/protect.png",
                height: hRatio * 13,
                color: defaultColor,
              ),
              SizedBox(
                height: hRatio * 3,
              ),
              Container(
                alignment: Alignment.center,
                width: wRatio * 65,
                child: Text(
                  "Velkommen til Kjetils Bussreiser!",
                  style: defaultHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: hRatio * 3,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.fromLTRB(wRatio * 5, 0, wRatio * 5, 0),
                padding: EdgeInsets.fromLTRB(
                    wRatio * 6, wRatio * 4, wRatio * 6, wRatio * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "E-post",
                      style: TextStyle(
                          fontSize: hRatio * 1.8,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(100, 100, 100, 1)),
                    ),
                    SizedBox(
                      height: hRatio * 1,
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: hRatio * 2.1,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Enter Email",
                          hintStyle: hintTextStyle,
                          border: InputBorder.none),
                      cursorColor: defaultColor,
                      controller: emailController,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: hRatio * 2,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.fromLTRB(wRatio * 5, 0, wRatio * 5, 0),
                padding: EdgeInsets.fromLTRB(
                    wRatio * 6, wRatio * 4, wRatio * 6, wRatio * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: hRatio * 1.8,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(100, 100, 100, 1)),
                    ),
                    SizedBox(
                      height: hRatio * 1,
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: wRatio * 69,
                            child: TextFormField(
                              obscureText: obscure,
                              style: TextStyle(
                                fontSize: hRatio * 2.1,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "Enter Password",
                                  hintStyle: hintTextStyle,
                                  border: InputBorder.none),
                              cursorColor: defaultColor,
                              controller: passController,
                            ),
                          ),
                          SizedBox(
                            width: wRatio * 9,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: obscure
                                      ? Color.fromRGBO(100, 100, 100, 1)
                                      : defaultColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: hRatio * 2,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(wRatio * 5, 0, wRatio * 5, 0),
                alignment: Alignment.centerRight,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Forgot Password? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: hRatio * 2.1,
                      )),
                  TextSpan(
                      text: "Reset",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: defaultColor,
                        fontWeight: FontWeight.w500,
                        fontSize: hRatio * 2.1,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ])),
              ),
              SizedBox(
                height: hRatio * 1.5,
              ),
              ErrorText(errorText),
              SizedBox(
                height: hRatio * 1.5,
              ),
              BlocProvider(
                create: (context) => bloc,
                child: BlocListener(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is AuthenticationLoaded) {
                      if (state.statusCode == 200) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false,
                        );
                      } else if (state.statusCode == 201) {
                        Tost("No user found for the email provided.", context)
                            .showErrorToast();
                      } else if (state.statusCode == 202) {
                        Tost("Wrong password", context).showErrorToast();
                      } else if (state.statusCode == 204) {
                        Tost("Invalid email provided.", context)
                            .showErrorToast();
                      } else {
                        Tost("Something went wrong.", context).showErrorToast();
                      }
                    }
                  },
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is AuthenticationInitial ||
                          state is AuthenticationLoaded) {
                        return button();
                      } else {
                        return CircularProgressIndicator(
                          backgroundColor: defaultColor,
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: hRatio * 3,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: hRatio * 2.1,
                    )),
                TextSpan(
                    text: "Signup",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: defaultColor,
                      fontWeight: FontWeight.w500,
                      fontSize: hRatio * 2.1,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Registration()));
                      }),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  button() {
    return TextButton(
        onPressed: () {
          if (emailController.text == "" || passController.text == "") {
            setState(() {
              errorText = "Fill up all the fields!";
            });
          } else {
            setState(() {
              errorText = "";
            });
            bloc.add(login(emailController.text, passController.text));
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(top: wRatio * 4, bottom: wRatio * 4)),
            minimumSize: MaterialStateProperty.all(Size(wRatio * 90, 00)),
            backgroundColor: MaterialStateProperty.all(defaultColor)),
        child: Text(
          "Neste",
          style: TextStyle(color: Colors.white, fontSize: hRatio * 2.5),
        ));
  }
}
