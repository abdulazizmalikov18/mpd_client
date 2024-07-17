import 'package:easy_localization/easy_localization.dart';

enum CarReviewTypes {
  grade,
  design,
  size,
  specification,
  price,
  link,
  comments,
}

extension CarReviewsToString on CarReviewTypes {
  String get carToString {
    switch (this) {
      case CarReviewTypes.grade:
        return "grade".tr();

      case CarReviewTypes.design:
        return "design".tr();

      case CarReviewTypes.size:
        return "size".tr();

      case CarReviewTypes.specification:
        return "specification".tr();

      case CarReviewTypes.price:
        return "price".tr();

      case CarReviewTypes.link:
        return "link".tr();

      case CarReviewTypes.comments:
        return "comments".tr();

      default:
        return "grade".tr();
    }
  }
}

CarReviewTypes toCarReviewTypes(String value) {
  switch (value) {
    case "Grade":
      return CarReviewTypes.grade;

    case "Design":
      return CarReviewTypes.design;

    case "Size":
      return CarReviewTypes.size;

    case "Specification":
      return CarReviewTypes.specification;

    case "Price":
      return CarReviewTypes.price;

    case "Link":
      return CarReviewTypes.link;

    case "Comments":
      return CarReviewTypes.comments;

    default:
      return CarReviewTypes.grade;
  }
}

// extension CarReviewsToColor on CarReviewTypes {
//   Color get appointToColor {
//     switch (this) {
//       case CarReviewTypes.requested:
//         return Style.requested;
//
//       case CarReviewTypes.confirmed:
//         return Style.confirmed;
//
//       case CarReviewTypes.completed:
//         return Style.iconSelect;
//
//       case CarReviewTypes.cancelled:
//         return Style.redText;
//     }
//   }
// }
