import 'dart:typed_data';

import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 4;
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: !isLoading
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            image == null
                                ? Stack(
                                    children: [
                                      Image.network(
                                        categoryLogos[1],
                                        height: screenSize.height / 10,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.file_upload_outlined),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Image.memory(
                                        image!,
                                        height: screenSize.height / 10,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.file_upload_outlined),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : LoadingWidget()),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.orange[900],
      ),
    );
  }
}
