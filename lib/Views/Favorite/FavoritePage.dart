import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Views/Categories/CategoryCustom.dart';
import 'package:e_commers/Views/Products/DetailsProductPage.dart';
import 'package:e_commers/Widgets/floter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'package:e_commers/Controller/ProductController.dart';
import 'package:e_commers/Models/Product/FavoriteProduct.dart';
import 'package:e_commers/Widgets/BottomNavigationFrave.dart';
import 'package:e_commers/Widgets/TextFrave.dart';


class FavoritePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final size =  MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: getFloatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: 'Favorites', color: Colors.black,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [

          FutureBuilder<List<Favorite>>(
            future: dbProductController.favoriteProducts(),
            builder: (context, snapshot){
              return !snapshot.hasData
                      ? LoadingFavoriteProduct()
                      : ListFavoriteProduct(list: snapshot.data );
            },
          ),
          
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              child: Align(
                child: BottomNavigationFrave(index: 1)
              )
            ),
          ),

          
        ],
      ),
     );
  }
}

class LoadingFavoriteProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.white,
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 90),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 20,
          mainAxisExtent: 210
        ),
        itemCount: 6,
        itemBuilder: (context, index) 
          => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0)
            ),
          ),
      ),
    );
  }
}


class ListFavoriteProduct extends StatelessWidget {

  final List<Product>lists;
  final List<Favorite>list;


  ListFavoriteProduct({this.list,this.lists});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 90),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 20,
        mainAxisExtent: 220
      ),
      itemCount: list.length == null ? 0 : list.length,
      itemBuilder: (context, i)
        =>  SizedBox(

          child: GestureDetector(
           // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsProductPage(product: lists[i]))),
            child: AspectRatio(
              aspectRatio: 0.83,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[

                  ClipPath(
                    clipper: CategoryCustomShape(),
                    child: AspectRatio(
                      aspectRatio: 1.025,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Color(0xFFF2F8FF),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              list[i].productId.nameProduct,
                              style: GoogleFonts.getFont('Roboto', fontSize: 17, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.0),
                            TextFrave(text: '\$ ${list[i].productId.price}', fontSize: 16 ),
                          ],
                        ),
                      ),

                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AspectRatio(
                        aspectRatio: 1.15,
                        child: Hero(
                            tag: list[i].productId.id,
                            child: Image.network('http://3.19.60.176:7080/'+ list[i].productId.picture, height: 150,)
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
    );
  }
}



