import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  ReviewDialog({
    Key? key,
    required this.productUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: Text(
        'Type review for product',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type Here',
      onSubmitted: (RatingDialogResponse response) async {
        FirestoreMethods().uploadReviewToDatabase(
          model: ReviewModel(
            senderName: Provider.of<UserDetailsProvider>(context,listen: false).userDetailsModel.name,
            description: response.comment,
            rating: response.rating.toInt(),
          ),
          productUid: productUid,
        );
      },
    );
  }
}
