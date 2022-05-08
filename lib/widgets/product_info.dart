import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  ProductInfo({
    Key? key,
    required this.productName,
    required this.cost,
    required this.sellerName,
  }) : super(key: key);
  SizedBox space = SizedBox(
    height: 7,
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.9,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          space,
          Align(
            alignment: Alignment.centerLeft,
            child: CostWidget(
              color: Colors.black,
              cost: cost,
            ),
          ),
          space,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Sold by: ",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  TextSpan(
                    text: sellerName,
                    style: TextStyle(color: Colors.cyan[700], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
