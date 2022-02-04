import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Helpers/ModalAddCart.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Models/Product.dart';
import 'package:e_commers/Views/Cart/CartPage.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../chat_and_add_to_cart.dart';
import '../../constants.dart';
import '../../product_image.dart';


class DetailsProductPage extends StatelessWidget
{
  final Product product;
  final String uidProduct;
  DetailsProductPage({ @required this.product, this.uidProduct});

  @override
  Widget build(BuildContext context)
  {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () async {

                modalAddCartSuccess(context, product.picture );

                final productSelect = ProductCart(
                    uidProduct: product.id,
                    image: product.picture,
                    name: product.nameProduct,
                    price: product.price.toDouble(),
                    amount: 1
                );

                productBloc.add( AddProductToCart( product: productSelect ));
                await Future.delayed(Duration(seconds: 2));
                Navigator.pop(context);
                Navigator.of(context).push(rutaFrave(page: HomePage(), curved: Curves.easeInOut));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              label: Text(
                "Add to Cart",
                style: TextStyle(color: Colors.white),
              ),
            ),

            // it will cover all available spaces
            Spacer(),
            FlatButton.icon(
              onPressed: (){

                final productSelect = ProductCart(
                    uidProduct: product.id,
                    image: product.picture,
                    name: product.nameProduct,
                    price: product.price.toDouble(),
                    amount: 1
                );

                productBloc.add( AddProductToCart( product: productSelect ));

                Navigator.of(context).push(rutaFrave(page: CartPage(), curved: Curves.easeInOut));

              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              label: Text(
                "Buy Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: kPrimaryColor,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: kDefaultPadding),
          icon:
          Icon(
              Icons.arrow_back,
              color: Colors.black
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          'Back'.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () => productBloc.add( AddOrDeleteProductFavorite(uidProduct: uidProduct)),
          ),
        ],
      ),
      body:Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(

                    width: double.infinity,

                    padding: EdgeInsets.only( right: kDefaultPadding,
                    left: kDefaultPadding,
                    top: kDefaultPadding,
                    bottom:  kDefaultPadding),
                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: _ImageProduct( uidProduct: product.id, imageProduct: product.picture),
                        ),
                        SizedBox(height: 60,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Text(
                              product.nameProduct,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          '\$ ${product.price}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                          child: Text(
                            product.description,
                            style: TextStyle(color: kTextLightColor),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),


                ],
              ),

            ),
          ),
        ],
      )





     );
  }
}



class _ImageProduct extends StatelessWidget {

  final String imageProduct;
  final String uidProduct;

  const _ImageProduct({this.uidProduct, this.imageProduct});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$uidProduct',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.37,
        width: MediaQuery.of(context).size.width,
        child: Image.network('http://3.19.60.176:7080/'+ imageProduct),
      ),
    );
  }
}

