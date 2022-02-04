import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Views/Cart/CheckoutPage.dart';
import 'package:e_commers/Views/Home/HomePage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:e_commers/Widgets/btnFrave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final size = MediaQuery.of(context).size;
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          _ListProductsCard(),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              height: 133,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 5)]
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFrave(text: 'Total', fontSize: 18, fontWeight: FontWeight.w600 ),
                        BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state)
                          => TextFrave(text: '\$ ${state.total.toStringAsFixed(2) }', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff0C6CF2)),
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 18.0),
                  BtnFrave(
                    text: 'Checkout',
                    borderRadius: 10,
                    fontSize: 22,
                    height: 56,
                    onPressed: (){
                      if( productBloc.product.isNotEmpty ) {
                        Navigator.of(context).push(rutaFrave(page: CheckOutPagePage(), curved: Curves.easeInOut));
                      }
                    },
                  ),
                ],
              ),
            ),
          )



        ],
      ),
     );
  }
}

class _ListProductsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 15.0),
          _AppBarCart(),
          SizedBox(height: 20.0),
          productBloc.product.isEmpty ? WithoutProducts() : _DetailsProducts()
        ],
      ),
    );
  }
}


class _DetailsProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .75,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state)
            => ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.products.length,
            itemBuilder: (context, i) {

              return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding: EdgeInsets.all(15.0),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFF2F8FF),
                          boxShadow: [
                          BoxShadow(
                          offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
              ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          child: Image.network('http://3.19.60.176:7080/'+ state.products[i].image )
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 230,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 205,
                                    child: TextFrave(text: state.products[i].name, fontSize: 19, textOverflow: TextOverflow.ellipsis )
                                  ),
                                  GestureDetector(
                                    onTap: () => productBloc.add( DeleteProductToCart(index: i) ),
                                    child: Container(
                                        padding: EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: Colors.red
                                        ),
                                        child: Icon(Icons.close, color: Colors.white, size: 19))
                                )
                              ],
                              ),
                            ),
                          SizedBox(height: 10.0),
                          TextFrave(text: '\$ ${state.products[i].price}', fontSize: 22, fontWeight: FontWeight.w600 ),
                          SizedBox(height: 20.0),
                          Container(
                            width: 230,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(7.0)
                                    ),
                                    child:
                                      Icon(Icons.remove, color: Colors.white ),
                                  ),
                                  onTap: (){
                                    if( state.products[i].amount > 1 ){
                                      productBloc.add( SubtractQuantityProductEvent(subtract: i) );
                                    }
                                  },
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  color: Colors.white,
                                  child: Center(child: TextFrave(text: '${state.products[i].amount}', fontSize: 18)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productBloc.add( PlusQuantityProduct(plus: i));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(7.0)
                                    ),
                                    child: Icon(Icons.add, color: Colors.white ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class _AppBarCart extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 17,
                child: InkWell(
                  onTap: () => Navigator.of(context).pushReplacement(rutaFrave(page: HomePage(), curved: Curves.easeInOut)),
                  child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black )
                ),
              ),
              SizedBox(width: 20.0),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFrave(text: 'My Cart', fontSize: 18, fontWeight: FontWeight.w500 ),
                    Container(
                        child: BlocBuilder<ProductBloc, ProductState>(
                          // builder: (_, state) => TextFrave(text: '${state.products.length} items', fontSize: 19, color: Colors.black54 ),
                            builder: (_, state) {

                              if( state.products == null ){
                                return TextFrave(text: '0 items', fontSize: 13, color: Colors.black54, );
                              }

                              return TextFrave(text: '${state.products.length} items', fontSize: 13, color: Colors.black54 );
                            }
                        )
                    ),
                  ],
                )
              ),
            ],
          ),


        ],
      ),
    );
  }
}


class WithoutProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state)
        => (state.products == null )
           ? Padding(
             padding: const EdgeInsets.only(top:100.0, right: 40.0, left: 40.0),
             child: Container(

                child: Column(
                    children: [
                    Icon(Icons.remove_shopping_cart, size: 90, color: Color(0xff0C6CF2).withOpacity(.7)),
                    SizedBox(height: 20),
                    TextFrave(text: 'There is a cart to fill!', fontSize: 18 ),
                    SizedBox(height: 20),
                    TextFrave(text: 'Currently do not have any products in your shopping cart', fontSize: 16 ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextButton(
                        style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                          padding: MaterialStateProperty.all( EdgeInsets.symmetric(horizontal: 50, vertical: 10))
                        ),
                        child: TextFrave(text: 'Go Products', fontSize: 19,color: Colors.white, ),
                        onPressed: () => Navigator.of(context).pushReplacement(rutaFrave(page: HomePage(), curved: Curves.easeInOut)),
                      ),
                    )
                  ],
                ),
      ),
           )
      : null
    );
  }


}













