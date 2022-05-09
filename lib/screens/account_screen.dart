import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/account_screen_app_bar.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/introduction_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetailsModel;
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AccountScreenAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                IntroductionWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Sell",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.yellow,
                    isLoading: false,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SellScreen()));
                    },
                  ),
                ),
                ProductsShowcaseListView(
                  title: "Your Orders",
                  children: testChildren,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Requests",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "Order: Black Shoe",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text("Address: SomeWhere on earth"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                      ),
                    ),
                  ),
                  itemCount: 5,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
