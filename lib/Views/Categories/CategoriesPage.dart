import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Models/Home/CategoriesProducts.dart';
import 'package:e_commers/Views/Categories/CategoryProductsPage.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CategoriesPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
          onPressed: () => Navigator.of(context).pushReplacement(rutaFrave(page: HomePage(), curved: Curves.easeInOut)),
        ),
        elevation: 0,
        title: TextFrave(text: 'Categories', color: Colors.black),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Category>>(
         future: dbHomeController.getListCategories(),
         builder: (context, snapshot){
            return !snapshot.hasData
            ? Center(
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    TextFrave(text: 'Loading...')
                  ],
                )
              )
            : _ListCategories( list: snapshot.data );
         },
      ),
     );
  }
}

class _ListCategories extends StatelessWidget 
{
  
  final List<Category> list;

  _ListCategories({this.list}); 

  @override
  Widget build(BuildContext context) 
  {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 180
      ),
      itemCount: list.length == null ? 0 : list.length,
      itemBuilder: (context, i) => GestureDetector(
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color(0xff0C6CF2),
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Column(
            children: [
              SvgPicture.network('http://3.19.60.176:7080/'+ list[i].picture, height: 85, color: Colors.white),
              SizedBox(height: 10.0),
              TextFrave(text: list[i].category, fontSize: 22, color: Colors.white,)
            ],
          ),
        ),
        onTap: () => Navigator.of(context).push(rutaFrave(page: CategoryProductsPage(uidCategory: list[i].id, category: list[i].category), curved: Curves.easeInOut))
      ),
    );
  }
}