import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bitmec/models.dart';
import 'package:bitmec/services.dart';

class ImageDBProvider with ChangeNotifier {
  static ImageDBProvider of(context) => Provider.of(context);

  // Todo: fix load times.
  void create(int urlID, File file, int referenceID,
      [Function(ImageDB) callback]) {
    ImageDBService.create(urlID, file, referenceID).then((response) {
      if (callback != null) {
        callback(response);
      }
    });
  }
}
