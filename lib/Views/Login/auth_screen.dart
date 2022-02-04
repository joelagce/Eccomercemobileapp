import 'dart:math';


import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Helpers/ModalLoading.dart';
import 'package:e_commers/Helpers/ValidatorsForm.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Views/Login/LoadingPage.dart';
import 'package:e_commers/Views/Login/SignInPage.dart';
import 'package:e_commers/Views/Login/SignupPage.dart';

import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/TextFormFrave.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:e_commers/Widgets/btnFrave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isShowSignUp = false;
   AnimationController _animationController;
   Animation<double> _animationText;

  void setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: defaultDuration,
    );

    _animationText =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      isShowSignUp = !isShowSignUp;
    });
    isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    setupAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isChangeSuffixIcon = true;
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // Lgoin
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  top: 0,
                  left: isShowSignUp ? -_size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: isShowSignUp ? 0 : 1,
                      child:  SignInPage()
                    ),
                  ),
                ),
                // Sign Up
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: 0,
                  left: isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    height: _size.height,
                    width: _size.width * 0.88,
                    color: signup_bg,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: isShowSignUp ? 1 : 0,
                      child: SignUpPage(),
                    ),
                  ),
                ),
                // Logo

                // Socal btns

                // Lgoin Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      isShowSignUp ? _size.height / 2 - 80 : _size.height * 0.3,
                  left: isShowSignUp ? 0 : _size.width * 0.44 - 80,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isShowSignUp ? 20 : 34,
                      fontWeight: FontWeight.bold,
                      color: isShowSignUp ? Colors.white : Colors.transparent,
                    ),
                    child: Transform.rotate(
                      angle: -_animationText.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          if (isShowSignUp)
                            updateView();
                          else {
                            // Check your login form
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            "Log In".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Sign Up Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      isShowSignUp ? _size.height * 0.3 : _size.height / 2 - 80,
                  right: isShowSignUp ? _size.width * 0.44 - 80 : 0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isShowSignUp ? 34 : 20,
                      fontWeight: FontWeight.bold,
                      color: isShowSignUp ? Colors.transparent : Colors.white,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationText.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (!isShowSignUp)
                            updateView();
                          else {
                            // check sign up form
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          child: Text(
                            "Sign Up".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
