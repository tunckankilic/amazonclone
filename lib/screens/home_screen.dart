import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/banner_ad_widget.dart';
import 'package:amazonclone/widgets/categories_horizontal_list_view_bar.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;
  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount80;
  List<Widget>? discount0;

  void getData() async {
    List<Widget> temp70 = await FirestoreMethods().getProductsFromDiscount(70);
    List<Widget> temp80 = await FirestoreMethods().getProductsFromDiscount(80);
    List<Widget> temp60 = await FirestoreMethods().getProductsFromDiscount(60);
    List<Widget> temp0 = await FirestoreMethods().getProductsFromDiscount(0);
    setState(() {
      discount0 = temp0;
      discount60 = temp60;
      discount70 = temp70;
      discount80 = temp80;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body: (discount0 != null &&
                discount60 != null &&
                discount70 != null &&
                discount80 != null)
            ? Stack(
                children: [
                  UserDetailsBar(
                    offset: offset,
                  ),
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        CategoriesHorizontalListViewBar(),
                        BannerAdWidget(),
                        ProductsShowcaseListView(
                          title: "Upto 70% off",
                          children: discount70!,
                        ),
                        ProductsShowcaseListView(
                          title: "Upto 60% off",
                          children: discount60!,
                        ),
                        ProductsShowcaseListView(
                          title: "Upto 80% off",
                          children: discount80!,
                        ),
                        ProductsShowcaseListView(
                          title: "Explore",
                          children: discount0!,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : LoadingWidget(),
      ),
    );
  }
}
