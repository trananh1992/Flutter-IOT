import 'package:charge/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {
  final BuildContext _context;
  Loading(this._context);

  ///打开loading
  void show() {
    showDialog(
      context: _context,
      builder: (context) {
        return SpinKitFadingCircle(color: KColor.loadingColor);
      },
    );
  }

  ///关闭loading
  void close() {
    Navigator.of(_context).pop();
  }
}
