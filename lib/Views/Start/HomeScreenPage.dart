import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:e_commers/Widgets/btnFrave.dart';
import 'package:flutter/material.dart';


class HomeScreenPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
        backgroundColor: Color(0xff0C6CF2),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('Assets/logo-white.png')
                            )
                          )
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFrave(text: 'ELECTRONIC', fontSize: 32, color: Colors.white),
                            TextFrave(text: ' SHOP', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ],
                        ),
                        TextFrave(text: 'All your products in your hands', fontSize: 20, color: Colors.white60,),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        BtnFrave(text: 'Get Started', color: Color(0xff1C2834), onPressed: () => Navigator.of(context).pushNamed('authPage')),
                        SizedBox(height: 15.0),

                      ],
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