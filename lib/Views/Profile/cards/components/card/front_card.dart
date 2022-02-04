import 'dart:math';



import 'package:e_commers/Data/ListCard.dart';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../size_config.dart';

class FrontCard extends StatelessWidget {
  final CreditCardFrave card;
  final bool showCardNumber;
  final bool animateCardNumber;

  const FrontCard(
      {Key key,
      @required this.card,
      this.showCardNumber = false,
      this.animateCardNumber = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  card.colors[0],
                  card.colors[1],
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0, 0.8],
                tileMode: TileMode.clamp)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultWidth * 2,
              vertical: SizeConfig.defaultHeight * 2),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Credit Card",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Transform.rotate(
                      angle: pi / 2,
                      child: Icon(
                        Icons.wifi,
                        size: SizeConfig.defaultHeight * 4,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Transform.translate(
                      offset: Offset(-SizeConfig.defaultWidth, 0),
                      child: Image.asset(
                        "Assets/chip.png",
                        height: 120,
                        width: 80,
                      ),
                    ),
                    if (showCardNumber)
                      Expanded(
                          flex: 5,
                          child: PlayAnimation(
                            tween: IntTween(begin: 0, end: card.cardNumber.length),
                            delay: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 500),
                            builder: (context, child, value) {
                              return Text(
                                animateCardNumber
                                    ? card.cardNumber.substring(0, value)
                                    : card.cardNumber,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              );
                            },
                          ))
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CARD HOLDER",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.white70),
                        ),
                        Text(
                          card.cardHolderName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      card.brand == CardBrand.visa
                          ? "Assets/visa.png"
                          : "Assets/mastercard.png",
                      height: SizeConfig.defaultHeight * 3,
                      color:
                          card.brand == CardBrand.visa ? Colors.white70 : null,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
