import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  AccountScreenAppBar({
    Key? key,
  })  : prefferedSizeW = Size.fromHeight(kAppBarHeight),
        super(key: key);
  final Size prefferedSizeW;

  @override
  Size get preferredSize {
    return prefferedSizeW;
  }

  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Image.network(
              amazonLogoUrl,
              height: kAppBarHeight * 0.7,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
