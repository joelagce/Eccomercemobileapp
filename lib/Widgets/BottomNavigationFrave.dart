import 'package:e_commers/Views/Categories/CategoriesPage.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Views/Cart/CartPage.dart';
import 'package:e_commers/Views/Favorite/FavoritePage.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Views/Profile/ProfilePage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'dart:math' as math;







class BottomNavigationFrave extends StatelessWidget
{

  final int index;
  final bool showMenu;

  BottomNavigationFrave({ @required this.index, this.showMenu = true });


  @override
  Widget build(BuildContext context)
  {
    return

     AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: ( showMenu ) ? 1 : 0,
        child: Container(
          height: 70,

          decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemsButton(i: 0, index: index, svg: 'Assets/home.svg', activeSvg: 'Assets/home-selected.svg', onPressed: () => Navigator.pushReplacement(context, rutaFrave( page: HomePage(), curved: Curves.easeInOut))),
                  _ItemsButton(i: 1, index: index, icon: Icons.favorite_outline_rounded, isIcon: true, activeIcon: Icons.favorite_rounded, onPressed: () => Navigator.pushReplacement(context, rutaFrave( page: FavoritePage(), curved: Curves.easeInOut))),

                  _ItemsButton(i: 3, index: index, icon: Icons.category_outlined, isIcon: true, activeIcon: Icons.category,onPressed: () => Navigator.pushReplacement(context, rutaFrave( page: CategoriesPage(), curved: Curves.easeInOut))),
                  _ItemsButton(i: 4, index: index, icon: Icons.person_outline_rounded, isIcon: true, activeIcon:  Icons.person, onPressed: () => Navigator.pushReplacement(context, rutaFrave( page: ProfilePage(), curved: Curves.easeInOut))),
                ]
            ),
          ),
        ),
      );


  }


}



class  _ItemsButton extends StatelessWidget
{
  final IconData icon;
  final String svg;
  final bool isIcon;
  final bool center;
  final Function onPressed;
  final IconData activeIcon;
  final String activeSvg;
  final int index;
  final int i;

  _ItemsButton({
    this.i,
    this.index,
    this.icon,
    this.svg,
    this.center = false,
    this.isIcon = false,
    this.onPressed,
    this.activeIcon,
    this.activeSvg
  });


  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
        onTap: onPressed,
        child: center
            ? Transform.rotate(
          angle: -math.pi / 4,
              child: Container(
          width: 50,
          height: 50,

          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: Offset(0, 1)),
                ],
              color: Color(0xff006cf2),
              borderRadius: BorderRadius.circular(15.0)

          ),


          child:
          RotationTransition
            (
              turns: new AlwaysStoppedAnimation(45 / 360),
              child: SvgPicture.asset( i == index ? activeSvg : svg, height: 16, color: Colors.white )),
        ),
            )
            : isIcon
            ? Icon( i == index ? activeIcon : icon , size: 30, color: i == index ? Colors.black : Colors.black )
            : SvgPicture.asset( i == index ? activeSvg : svg , height: 26, color: i == index ? Colors.black : Colors.black )
    );
  }
}