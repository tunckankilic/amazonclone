import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.56),
        child: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
      ),
    );
  }
}
