import 'dart:typed_data';

import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 4;
  Uint8List? image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _costController = TextEditingController();
  Expanded space = Expanded(child: Container());
  List<int> keysForDiscount = [
    0,
    60,
    70,
    80,
  ];
  @override
  void dispose() {
    _costController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel info =
        Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetailsModel;
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            image == null
                                ? Stack(
                                    children: [
                                      Image.network(
                                        categoryLogos[1],
                                        height: screenSize.height / 10,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          Uint8List? temp =
                                              await Utils().pickImage();
                                          if (temp != null) {
                                            setState(() {
                                              image = temp;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.file_upload_outlined),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Image.memory(
                                        image!,
                                        height: screenSize.height / 8,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          Uint8List? temp =
                                              await Utils().pickImage();
                                          if (temp != null) {
                                            setState(() {
                                              image = temp;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.file_upload_outlined),
                                      ),
                                    ],
                                  ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 10,
                              ),
                              height: screenSize.height * 0.7,
                              width: screenSize.width * 0.7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    title: "Name",
                                    controller: _nameController,
                                    obsText: false,
                                    hint: "Enter the name of item",
                                  ),
                                  TextFieldWidget(
                                    title: "Cost",
                                    controller: _costController,
                                    obsText: false,
                                    hint: "Enter the cost of item",
                                  ),
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("None"),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("%60"),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("%70"),
                                    leading: Radio(
                                      value: 3,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("%80"),
                                    leading: Radio(
                                      value: 4,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomMainButton(
                              child: Text(
                                "Sell",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              color: Colors.orange,
                              isLoading: isLoading,
                              onPressed: () async {
                                try {
                                  String output = await FirestoreMethods()
                                      .uploadProductToDatabase(
                                    image: image!,
                                    productName: _nameController.text.trim(),
                                    cost: _costController.text.trim(),
                                    discont: keysForDiscount[1],
                                    sellerName: info.name,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );if (output == "success") {
                                  Utils().showSnackBar(
                                      context: context,
                                      content: "Posted Product Successfully");
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output);
                                }
                                } catch (e) {
                                  print(e.toString());
                                }

                                
                              },
                            ),
                            CustomMainButton(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              color: Colors.grey,
                              isLoading: false,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
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
