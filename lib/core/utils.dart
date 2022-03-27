import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Utils {
  static ImageProvider imageSelector(
      bool revealed, String revealUrl, String gender) {
    if (revealed) {
      return CachedNetworkImageProvider(revealUrl);
    } else {
      if (gender == 'Male') {
        return AssetImage('assets/images/default-profile-picture/male.png');
      } else {
        return AssetImage('assets/images/default-profile-picture/female.png');
      }
    }
  }

  static String formatHour(DateTime time) {
    return time.hour.toString().padLeft(2, '0') +
        ':' +
        time.minute.toString().padLeft(2, '0');
  }

  static String determineTime(DateTime time) {
    if (time.day == DateTime.now().day) {
      return 'Today';
    } else if (time.day == DateTime.now().day - 1) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  static String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
