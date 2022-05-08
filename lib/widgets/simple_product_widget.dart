import 'package:amazonclone/screens/product_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/model/product_model.dart';

class SimpleProductWidget extends StatelessWidget {
 
  final ProductModel productModel;
  const SimpleProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: productModel),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
