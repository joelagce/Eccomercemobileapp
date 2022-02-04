
import 'dart:ui';

import 'package:e_commers/Models/Card/CreditCardFrave.dart';
import 'package:flutter/cupertino.dart';
enum CardBrand { visa, mastercard }


class CreditCardFrave {

  final String cardNumberHidden;
  final String cardNumber;
  CardBrand brand;
  final String cvv;
  final String expiracyDate;
  final String cardHolderName;
  double amount;
  List<Color> colors;

  CreditCardFrave({
    @required this.cardNumberHidden,
    @required this.cardNumber,
    @required this.brand,
    @required this.cvv,
    @required this.expiracyDate,
    @required this.cardHolderName,
    @required this.amount,

    @required this.colors,
  });

}




final List<CreditCardFrave> cards = [

  CreditCardFrave(
    cardNumberHidden: '4242',
    cardNumber: '4242424242424242',
      brand: CardBrand.visa,
      amount: 2572.52,
      colors: [
        Color(0xFF0000FF),
        Color(0XFF377CFF),
      ],
    cvv: '123',
    expiracyDate: '01/25',
    cardHolderName: 'Frave Developer'
  ),
  CreditCardFrave(
    cardNumberHidden: '5555',
    cardNumber: '5555555555554444',
      brand: CardBrand.mastercard,
      amount: 7535.41,
      colors: [
        Color(0xFFFFA351),
        Color(0xFFF83D34),
      ],
    cvv: '213',
    expiracyDate: '01/25',
    cardHolderName: 'Frave Programmer'
  ),
  CreditCardFrave(
    cardNumberHidden: '3782',
    cardNumber: '378282246310005',
      brand: CardBrand.mastercard,
      amount: 12517.07,
      colors: [
        Color(0xFF990099),
        Color(0xFF660066),
      ],
    cvv: '2134',
    expiracyDate: '01/25',
    cardHolderName: 'Franklin Perez'
  ),

];