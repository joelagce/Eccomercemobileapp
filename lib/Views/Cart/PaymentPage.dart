import 'package:e_commers/Bloc/Cart/cart_bloc.dart';
import 'package:e_commers/Data/ListCard.dart';


import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:e_commers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stripe_payment/stripe_payment.dart';


class PaymentPage extends StatelessWidget {
 
  
  @override
  Widget build(BuildContext context)
  {
    final cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFrave(text: 'Payment', color: Colors.black, fontSize: 21),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [

        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (_, i) {
                   final CreditCardFrave card = cards[i];

                   return BlocBuilder<CartBloc, CartState>(
                     builder: (context, state) 
                      => GestureDetector(
                       onTap: () => cartBloc.add( OnSelectCard(creditCardFrave: card) ),
                       child: Container(
                         margin: EdgeInsets.only(bottom: 20.0),
                         padding: EdgeInsets.all(10.0),
                         height: 80,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15.0),
                           border: Border.all(
                             color: state.creditCardFrave == null 
                              ? Colors.black
                              : state.creditCardFrave.cvv == card.cvv ? kPrimaryColor : Colors.black
                           )
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               height: 80,
                               width: 80,
                               child: SvgPicture.asset(
                                 card.brand == CardBrand.visa
                                     ? "Assets/visa.svg"
                                     : "Assets/mastercard.svg",

                                 color:
                                 card.brand == CardBrand.visa ? Colors.black: null,
                               )
                             ),
                             Container(
                               child: TextFrave(text: '**** **** **** ${card.cardNumber}')
                             ),
                             Container(
                               child: state.creditCardFrave == null 
                               ? Icon(Icons.radio_button_off_rounded, size: 31)
                               : state.creditCardFrave.cvv == card.cvv
                                ? Icon(Icons.radio_button_checked_rounded, size: 31, color: kPrimaryColor,)
                                : Icon(Icons.radio_button_off_rounded, size: 31)
                             )
                           ],
                         ),
                       ),
                     ),
                   );
                } ,
              ),
            ),
          )
        ],
      ),
     );
  }
}