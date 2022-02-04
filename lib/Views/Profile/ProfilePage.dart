import 'dart:io';
import 'package:e_commers/Helpers/LoadingUpload.dart';
import 'package:e_commers/Views/Profile/Shopping/ShoppingPage.dart';
import 'package:e_commers/Views/Profile/cards/main.dart';
import 'package:e_commers/Views/Start/HomeScreenPage.dart';
import 'package:e_commers/Widgets/CircleFrave.dart';
import 'package:e_commers/Widgets/floter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animate_do/animate_do.dart';

import 'package:e_commers/Views/Profile/InformationPage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Widgets/BottomNavigationFrave.dart';
import 'package:e_commers/Widgets/TextFrave.dart';


class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final size =  MediaQuery.of(context).size;

    return Scaffold(

      backgroundColor: Colors.white,
      floatingActionButton: getFloatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Stack(
        children: [

          ListProfile(),
          
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              child: Align(
                child: BottomNavigationFrave(index: 4)
              )
            ),
          ),  
          
        ],
      ),
     );
  }


}


class ListProfile extends StatefulWidget {
  @override
  _ListProfileState createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> 
{
    File image;
    String img;
    final picker = ImagePicker();

    Future getImage() async {

      var pickedFile = await picker.getImage(source: ImageSource.gallery);

      if( pickedFile != null ){

        image = File( pickedFile.path );
        img = pickedFile.path;

        BlocProvider.of<AuthBloc>(context).add( ChangePictureProfile(image: img) );
      }

      setState(() {});
    }

    Future getTakeFoto() async {

      var pickedFile = await picker.getImage(source: ImageSource.camera);

      if( pickedFile != null ){
          image = File( pickedFile.path );
          img = pickedFile.path;
          BlocProvider.of<AuthBloc>(context).add( ChangePictureProfile(image: img) );

        } 
      setState(() {});
  }

  @override
  Widget build(BuildContext context) 
  {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {

          if( state is LoadingImageState ){

              loadinUploadFile(context);
          } else if ( state is ChangeProfileSuccess ){

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextFrave(text: 'Image Updated success', fontSize: 18), backgroundColor: Colors.green));
          
          } else if( state is LogOutState ) {
            Navigator.pushReplacement(context, rutaFrave(page: HomeScreenPage(), curved: Curves.easeInOut));
          }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
            return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 35.0, bottom: 90.0),
            children: [


                  Center(

                    child: Stack(
                      children:<Widget> [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: state.profile == ''
                          ? GestureDetector(
                              onTap: () => changeProfile(context),
                              child:

                              Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.black)
                                ),
                                child: CircleFrave(
                                  radius: 110,
                                  child: Center(child: TextFrave(text: state.username.substring(0,2).toUpperCase(), fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              )
                            )
                          : GestureDetector(
                              onTap: () => changeProfile(context),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: Colors.black)
                                  ),
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage( 'http://3.19.60.176:7080/' + state.profile.toString() )
                                      )
                                    ),
                                  ),
                                ),
                              ),
                          )
                        ),


                      ],
                    ),
                  ),

              SizedBox(height: 25.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BounceInRight(
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFrave(text: state.username , fontSize: 21, color: Colors.black,)
                    ),
                  ),
                  FadeInRight(
                    child: Align(
                        alignment: Alignment.center,
                        child: TextFrave(text: state.email, fontSize: 18, color: Colors.grey,)
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.0),
              Container(
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child:
                    CardProfile(
                      text: 'Personal Information', 
                      borderRadius: BorderRadius.circular(30.0),
                      icon: Icons.person_outline_rounded,
                      backgroundColor: Color(0xff0C6CF2),
                      onPressed: () => Navigator.of(context).push(rutaFrave(page: InformationPage(), curved: Curves.easeInOut)),
                    ),



                ),
              SizedBox(height: 10.0),

            Container(
            width: size.width,
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0)
            ),
            child: CardProfile(
            text: 'Credit Card',
            borderRadius: BorderRadius.circular(30.0),

            icon: Icons.credit_card_rounded,
            backgroundColor: Color(0xff0C6CF2),
            onPressed: () => Navigator.of(context).push(rutaFrave(page: MyApp(), curved: Curves.easeInOut)),
            ),
          ),


              SizedBox(height: 10.0),
              Container(

                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 10.0),

                width: size.width,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(30.0)
                ),
                child:

                      CardProfile(
                        text: 'My Shopping',

                        backgroundColor: Color(0xff0C6CF2),
                        icon: Icons.shopping_bag_outlined,
                        borderRadius: BorderRadius.circular(30.0),
                        onPressed: () => Navigator.of(context).push(rutaFrave(page: ShoppingPage(), curved: Curves.easeInOut)),
                      ),

              ),



              SizedBox(height: 10.0),
              Container(
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 10.0),

                width: size.width,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: CardProfile(

                  text: 'Sign Out',
                  borderRadius: BorderRadius.circular(30.0),
                  icon: Icons.power_settings_new_sharp,
                  backgroundColor: Color(0xff0C6CF2),
                  onPressed: () => authBloc.add( LogOutEvent() ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void changeProfile(BuildContext context){

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    enableDrag: false,
    builder: (context) {
      
      return Container(
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.0, top: 25.0),
              child: TextFrave(text: 'Change profile picture', fontSize: 20, fontWeight: FontWeight.w500 ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 0,
                child: InkWell(
                  onTap: (){
                    getImage();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.0),
                    child: Align( alignment: Alignment.centerLeft,child: TextFrave(text: 'Select an image', fontSize: 18 )),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 0,
                child: InkWell(
                  onTap: (){
                    getTakeFoto();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.0),
                    child: Align(alignment: Alignment.centerLeft, child: TextFrave(text: 'Take a picture', fontSize: 18,)),
                  ),
                ),
              ),
            ),
          ],
        )
      );
    },
  );

}

  
}

class _Divider extends StatelessWidget {

  final Size size;

  _Divider({ @required this.size,  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, right: 25.0),
      child: Container(
        height: 1,
        width: size.width,
        color: Colors.grey[300],
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  
  final String text;
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final IconData icon;

  CardProfile({ this.text, this.onPressed, this.borderRadius, this.backgroundColor, this.icon });
  
  @override
  Widget build(BuildContext context) 
  {
    final size = MediaQuery.of(context).size;

    return 
      Container(
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: borderRadius
        ),
        child: Card(
          color: Color(0xFFF2F8FF),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0.0,
          margin: EdgeInsets.all(0.0),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Icon(icon, color: Colors.white,),
                    ),
                    SizedBox(width: 10.0),
                    TextFrave(text: text, fontSize: 18,),
                  ],
                ),
              )
            ),
          ),
        ),
      );
  }
}




