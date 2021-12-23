import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    String msg, [
      length = 'long',
      gravity = ToastGravity.BOTTOM,
      time = 4, // in sec (for IOS & Web)
      background,
      textColor,
    ]) {
  var _toastLength = length == 'long' ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT;

  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: _toastLength,
    gravity: gravity,
    timeInSecForIosWeb: time,
    backgroundColor: background,
    textColor: textColor,
  );
}