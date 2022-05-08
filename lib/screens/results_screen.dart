import 'package:amazonclone/widgets/results_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/constants.dart';

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: true,
        isReadOnly: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Showing results for",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: query,
                      style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return ResultsWidget(
                    productModel: ProductModel(
                      url: categoryLogos[0],
                      sellerName: "Ayşe",
                      sellerUid: "asşdkjasşdkşals",
                      cost: 10,
                      discount: 0,
                      noOfRating: 1,
                      rating: 3,
                      uid: "asdasdasdasda",
                      productName: "Item",
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
