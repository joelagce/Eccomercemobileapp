import 'package:e_commers/Controller/ProductController.dart';
import 'package:e_commers/Models/Home/ProductsHome.dart';
import 'package:e_commers/Views/Products/DetailsProductPage.dart';
import 'package:e_commers/Widgets/StaggeredDualView.dart';
import 'package:e_commers/Widgets/TextFrave.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CategoryCustom.dart';


class CategoryProductsPage extends StatefulWidget {

  final String uidCategory;
  final String category;

  const CategoryProductsPage({ @required this.uidCategory, @required this.category});

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}


class _CategoryProductsPageState extends State<CategoryProductsPage> 
{

  List<Product> listProduct = [];

  getProducts() async {

    listProduct = await dbProductController.getProductsForCategories(id: widget.uidCategory );
    setState(() { });
  }


  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: widget.category, color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: StaggeredDualView(
          itemCount: listProduct.length,
          spacing: 5,
          alturaElement: 0.15,
          aspectRatio: 0.8,
          itemBuilder: (_, i) 
            =>
                SizedBox(

                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsProductPage(product: listProduct[i]))),
                     child: AspectRatio(
                      aspectRatio: 0.83,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(

                          ),
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
                                      listProduct[i].nameProduct,
                                      style: GoogleFonts.getFont('Roboto', fontSize: 17, fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.0),
                                    TextFrave(text: '\$ ${listProduct[i].price}', fontSize: 16 ),
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
                                    tag: listProduct[i].id,
                                    child: Image.network('http://3.19.60.176:7080/'+ listProduct[i].picture, height: 150,)
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),

        ),
      )
     );
  }
}