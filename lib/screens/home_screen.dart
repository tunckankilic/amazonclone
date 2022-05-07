import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/banner_ad_widget.dart';
import 'package:amazonclone/widgets/categories_horizontal_list_view_bar.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoriesHorizontalListViewBar(),
            BannerAdWidget(),
            ProductsShowcaseListView(
              title: "Upto 70% off",
              children: testChildren,
            ),
            ProductsShowcaseListView(
              title: "Upto 60% off",
              children: testChildren,
            ),
            ProductsShowcaseListView(
              title: "Upto 50% off",
              children: testChildren,
            ),
            ProductsShowcaseListView(
              title: "Explore",
              children: testChildren,
            ),
          ],
        ),
      ),
    );
  }
}
