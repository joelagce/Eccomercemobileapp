import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Controller/HomeController.dart';
import 'package:e_commers/Models/Home/CategoriesProducts.dart';
import 'package:e_commers/Models/Home/HomeCarousel.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Views/Cart/CartPage.dart';
import 'package:e_commers/Views/Categories/CategoryCustom.dart';
import 'package:e_commers/Views/Categories/CategoryProductsPage.dart';
import 'package:e_commers/Views/Products/DetailsProductPage.dart';
import 'package:e_commers/Views/Categories/CategoriesPage.dart';
import 'package:e_commers/Widgets/AnimationRoute.dart';
import 'package:e_commers/Widgets/BottomNavigationFrave.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:e_commers/Widgets/floter.dart';
import 'package:e_commers/constants.dart';
import 'package:e_commers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:e_commers/size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'dart:math' as math;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: getFloatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListHome(),
          Positioned(
            bottom: 0,
            child: Container(
                width: size.width,
                child: Align(
                    child: BlocBuilder<GeneralBloc, GeneralState>(
                        builder: (context, state) => BottomNavigationFrave(
                            index: 0, showMenu: state.showMenuHome)))),
          ),
        ],
      ),
    );
  }
}

class ListHome extends StatefulWidget {
  @override
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  ScrollController scrollControllerHome = ScrollController();
  double scrollPrevious = 0;

  @override
  void initState() {
    scrollControllerHome.addListener(() {
      if (scrollControllerHome.offset > scrollPrevious) {
        BlocProvider.of<GeneralBloc>(context, listen: false)
            .add(OnShowHideMenuHome(showMenu: false));
      } else {
        BlocProvider.of<GeneralBloc>(context, listen: false)
            .add(OnShowHideMenuHome(showMenu: true));
      }

      scrollPrevious = scrollControllerHome.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollControllerHome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBlocState = BlocProvider.of<AuthBloc>(context).state;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        child: ListView(
          children: [
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.3 - 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(36),
                          bottomLeft: Radius.circular(36)),
                      color: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeInLeft(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 3.0),
                                  child: TextFrave(
                                      text: "Welcome,",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 23),
                                ),
                                SizedBox(width: 5.0),
                                TextFrave(
                                  text: authBlocState.username + "!",
                                  fontSize: 23,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () => Navigator.of(context).pushReplacement(
                                rutaFrave(
                                    page: CartPage(),
                                    curved: Curves.easeInOut)),
                            child: Stack(
                              children: [
                                FadeInRight(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(Icons.shopping_cart_rounded,
                                            color: Colors.black, size: 30))),
                                Positioned(
                                  left: 4,
                                  top: 8,
                                  child: FadeInDown(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: BlocBuilder<ProductBloc,
                                                  ProductState>(
                                              builder: (context, state) => state
                                                          .amount ==
                                                      0
                                                  ? TextFrave(
                                                      text: '0',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : TextFrave(
                                                      text:
                                                          '${state.products.length}',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 80.0, right: 10.0),
                      child: _CarCarousel(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(
                    text: 'Categories',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(rutaFrave(
                        page: CategoriesPage(), curved: Curves.easeInOut)),
                    child: Row(
                      children: [
                        TextFrave(text: 'See All', fontSize: 17),
                        SizedBox(width: 5.0),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 18, color: Color(0xff006CF2))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: _ListCategories(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(
                    text: 'Popular Products',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: _ListProducts(),
            )
          ],
        ),
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return FutureBuilder<List<Product>>(
      future: dbHomeController.getListProductsHome(),
      builder: (context, snapshot) {
        List<Product> list = snapshot.data;
        return !snapshot.hasData
            ? _LoadingShimmerProducts()
            : GridView.builder(
                padding: EdgeInsets.only(bottom: 90),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 220),
                itemCount: list.length == null ? 0 : list.length,
                itemBuilder: (context, i) => SizedBox(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => DetailsProductPage(product: list[i]))),
                    child: AspectRatio(
                      aspectRatio: 0.83,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(),
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
                                      list[i].nameProduct,
                                      style: GoogleFonts.getFont('Roboto',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.0),
                                    TextFrave(
                                        text: '\$ ${list[i].price}',
                                        fontSize: 16),
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
                                    tag: list[i].id,
                                    child: Image.network(
                                      'http://3.19.60.176:7080/' +
                                          list[i].picture,
                                      height: 150,
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Category>>(
        future: dbHomeController.getListCategoriesProducts(),
        builder: (context, snapshot) {
          List<Category> list = snapshot.data;

          return !snapshot.hasData
              ? _LoadingShimmerCategories()
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length == null ? 0 : list.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () => Navigator.of(context).push(rutaFrave(
                        page: CategoryProductsPage(
                            uidCategory: list[i].id,
                            category: list[i].category),
                        curved: Curves.easeInOut)),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xff0C6CF2),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Center(
                          child: Text(
                        list[i].category,
                        style: GoogleFonts.getFont('Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class _CarCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<SliderHome>>(
          future: dbHomeController.getHomeCarouselSlider(),
          builder: (context, snapshot) {
            List<SliderHome> silerHome = snapshot.data;

            return !snapshot.hasData
                ? _LoadingShimmerCarosusel()
                : PageView.builder(
                    itemCount: silerHome.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(silerHome[i].image))),
                      );
                    },
                  );
          }),
    );
  }
}

class _LoadingShimmerProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Color(0xFFF7F7F7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 250,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            Container(
              height: 250,
              width: 190,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ],
        ));
  }
}

class _LoadingShimmerCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF7F7F7),
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _LoadingShimmerCarosusel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF7F7F7),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
