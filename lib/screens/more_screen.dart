import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/category_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return CategoryWidget(index: index);
          },
        ),
      ),
    );
  }
}
