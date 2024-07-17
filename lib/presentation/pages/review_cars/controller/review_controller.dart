import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:provider/provider.dart';

class ReviewController {
  final selectedIndex = ValueNotifier(0);

  final rateList = ["☆☆☆☆☆", "★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"];

  final TextEditingController commentController = TextEditingController();

  final List<({String icon, String name})> filterItems = [];

  final bodyTypeId = ValueNotifier<int?>(null);

  final orderValue = ValueNotifier("-users-rating");
  final orderingBy = ["-users-rating", "-orient_motors_rating", "-design"];

  int rateValue = 5;

  onSave({required BuildContext context, required int id}) {
    if (commentController.text.isNotEmpty) {
      context.read<ReviewBloc>().add(
            ReviewEvent.postComment(CommentModel((b) => b
              ..rating = rateValue.toDouble()
              ..comment = commentController.text
              ..carReview = id)),
          );
      commentController.clear();
    }
  }
}
