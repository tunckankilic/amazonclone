import 'package:amazonclone/screens/results_screen.dart';
import 'package:amazonclone/screens/search_screen.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  SearchBarWidget({
    Key? key,
    required this.hasBackButton,
    required this.isReadOnly,
  })  : prefferedSizeW = Size.fromHeight(kAppBarHeight),
        super(key: key);
  final Size prefferedSizeW;
  final bool isReadOnly;
  final bool hasBackButton;
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.grey, width: 1),
  );
  @override
  Size get preferredSize {
    return prefferedSizeW;
  }

  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                )
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: (value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: value),
                    ),
                  );
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen()));
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search for something in amazon",
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mic_none_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
