import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/model/product_model.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel productModel;
  const ResultsWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        //
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(
                productModel.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                productModel.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStarWidget(
                        rating: productModel.rating,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      productModel.noOfRating.toString(),
                      style: TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  color: Colors.red[900]!,
                  cost: productModel.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
