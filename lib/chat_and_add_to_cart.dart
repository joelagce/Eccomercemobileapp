import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'Bloc/Product/product_bloc.dart';
import 'Helpers/ModalAddCart.dart';
import 'Models/Home/ProductsHome.dart';
import 'Models/Product.dart';
import 'Views/Cart/CartPage.dart';
import 'Views/Home/HomePage.dart';
import 'Widgets/AnimationRoute.dart';

class ChatAndAddToCart extends StatelessWidget {
  final Product product;
  final String uidProduct;


  const ChatAndAddToCart({
    @required this.product,
    this.uidProduct,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
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
                Icons.shopping_cart_outlined
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
              Icons.shopping_cart_outlined
            ),
            label: Text(
              "Buy Now",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
