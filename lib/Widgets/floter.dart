import 'package:e_commers/Views/Cart/CartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math' as math;
import 'AnimationRoute.dart';

Widget getFloatingButton(context) {
  return GestureDetector(
    onTap: () => Navigator.pushReplacement(context, rutaFrave( page: CartPage(), curved: Curves.easeInOut)),
    child: Transform.rotate(
      angle: -math.pi / 4,
      child: Container(
        margin: EdgeInsets.only(left:20, bottom: 25),
        width: 60,
        height: 60,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 1)),
        ], color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: RotationTransition(
          turns: new AlwaysStoppedAnimation(45 / 360),
          child: Center(
              child: Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 26,
              )),
        ),
      ),
    ),
  );
}