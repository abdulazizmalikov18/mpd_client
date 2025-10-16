import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class AppIcons {
  static const home = 'assets/icons/home.svg';
  static const homeFilled = 'assets/icons/home_filled.svg';
  static const calendar = 'assets/icons/calendar-tick.svg';
  static const calendarFilled = 'assets/icons/calendar-tick_filled.svg';
  static const user = 'assets/icons/user.svg';
  static const userFilled = 'assets/icons/user_filled.svg';
  static const receiptFilled = 'assets/icons/receipt-edit_filled.svg';
  static const receipt = 'assets/icons/receipt-edit.svg';
  static const shop = 'assets/icons/shop.svg';
  static const unfilledLocation = 'assets/icons/location_unfilled.svg';
  static const shopFilled = 'assets/icons/shop_filled.svg';
  static const share = 'assets/icons/share.svg';
  static const edit = 'assets/icons/edit.svg';
  static const search = 'assets/icons/search-normal.svg';
  static const back = 'assets/icons/back.svg';
  static const arrowDown = 'assets/icons/arrow-down.svg';
  static const logOut = 'assets/icons/logout.svg';
  static const cardPos = 'assets/icons/card-pos.svg';
  static const infoCircle = 'assets/icons/info-circle.svg';
  static const languageCircle = 'assets/icons/language-circle.svg';
  static const userAdd = 'assets/icons/user-add.svg';
  static const notification = 'assets/icons/notification.svg';
  static const star = 'assets/icons/star.svg';
  static const clock = 'assets/icons/clock.svg';
  static const userTick = 'assets/icons/user-tick.svg';
  static const location = 'assets/icons/location.svg';
  static const sort = 'assets/icons/sort.svg';
  static const circleCancel = 'assets/icons/close-circle.svg';
  static const circleTick = 'assets/icons/tick-circle.svg';
  static const clockTransparent = 'assets/icons/clock_transparent.svg';
  static const forward = 'assets/icons/arrow-right.svg';
  static const dateCalendar = 'assets/icons/calendarDate.svg';
  static const map = 'assets/icons/map.svg';
  static const verify = 'assets/icons/verify.svg';
  static const documentUpload = 'assets/icons/document-upload.svg';

  // Specialist order statistics icons
  static const order = 'assets/icons/order.svg';
  static const noActiveMessage = 'assets/icons/no_active_messages.svg';
  static const message = 'assets/icons/message.svg';
  static const patient = 'assets/icons/patient.svg';
  static const briefcase = 'assets/icons/briefcase.svg';

  // Avatar default icon
  static const avatarDefault = 'assets/icons/avatar_default.svg';

  static const mapOrient = 'assets/icons/tabler_current-location.svg';
  static const mainComponent = 'assets/icons/main-component.svg';
  static const moreIcon = 'assets/icons/more.svg';
  static const searchStatus = 'assets/icons/search-status.svg';
  static const searchStatusFilled = 'assets/icons/search-status_filled.svg';
  static const cartUnfilled = 'assets/icons/shopping-cart.svg';
  static const mainComponentUnfill = 'assets/icons/main-component_unfilled.svg';
  static const userOctagon = 'assets/icons/user-octagon.svg';
  static const userOctagonUnfill = 'assets/icons/user-octagon_unfilled.svg';
  static const settings = 'assets/icons/setting-4.svg';

  // Book date time error icon
  static const noWorkingDay = 'assets/icons/noWorkingDay.svg';

  // Yandex map icons
  static const arrowLeft = 'assets/icons/arrow-left.svg';
  static const send = 'assets/icons/send.svg';

  // Service icons
  static const minus = 'assets/icons/minus.svg';
  static const plus = 'assets/icons/plus.svg';
  static const myLocation = 'assets/icons/my_location.svg';

  // Add Post icons
  static const plusCircle = 'assets/icons/add_circle.svg';
  static const gallery = 'assets/icons/gallery.svg';
  static const remove = 'assets/icons/remove.svg';

  // Call icon
  static const call = 'assets/icons/call.svg';
  static const eye = 'assets/icons/eye.svg';

  // Post icons
  static const coment = 'assets/icons/coment.svg';
  static const unliked = 'assets/icons/unliked.svg';
  static const liked = 'assets/icons/liked.svg';

  // User avatar png for map
  static const serviceEmpty = 'assets/icons/service_empty.svg';

  // PDF Document of specialist
  static const documentSvg = 'assets/icons/document.svg';

  // Error page icons
  static const error404 = 'assets/icons/404_error.svg';
  static const connectionLostError = 'assets/icons/connection_lost_error.svg';
  static const serverError = 'assets/icons/server_error.svg';

  // Coment page icon
  static const emoji = 'assets/icons/emoji.svg';
  static const timer = 'assets/icons/timer.svg';
  static const clipboardCancel = 'assets/icons/clipboard_cancel.svg';

  // Tutorials
  static const tutorial_1 = 'assets/icons/tutorial_1.svg';
  static const tutorial_2 = 'assets/icons/tutorial_2.svg';
  static const tutorial_3 = 'assets/icons/tutorial_3.svg';
  static const tutorial_4 = 'assets/icons/tutorial_4.svg';

  static const logo = 'assets/icons/logo.svg';
  static const filter = 'assets/icons/setting-4.svg';

  static const qrCodeBorder = 'assets/icons/qr_code_border.svg';
  static const trash = "assets/icons/trash.svg";
  static const warning = "assets/icons/warning.svg";
  static const files = "assets/icons/files.svg";
  static const briefcaseLite = "assets/icons/briefcase_lite.svg";
  static const scanBarcode = "assets/icons/scan-barcode.svg";
  static const likeDislike = "assets/icons/like-dislike.svg";

  static const tickCircle = "assets/icons/tick_circle.svg";
  static const tickCircleOff = "assets/icons/tick_circle_off.svg";
  static const notificationImage = 'assets/icons/notification_logo.svg';

  static const circleCheck = "assets/icons/circle-check.svg";
  static const circleCheckBig = "assets/icons/circle-check-big.svg";

  static const share2 = "assets/icons/share-2.svg";
  static const userMinus = "assets/icons/user-minus.svg";
  static const circleUserRound = "assets/icons/circle-user-round.svg";
  static const messageCircleWarning = "assets/icons/message-circle-warning.svg";
  static const copy = "assets/icons/copy.svg";
  static const download = "assets/icons/download.svg";
  static const pencil = "assets/icons/pencil.svg";
}

extension SvgExt on String {
  SvgPicture svg({Color? color, double? width, double? height}) {
    return SvgPicture.asset(
      this,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      width: width,
      height: height,
    );
  }
}
