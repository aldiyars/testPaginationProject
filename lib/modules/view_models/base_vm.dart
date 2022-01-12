import 'package:flutter/material.dart';
import 'package:test_flutter_app/core/helpers/navigator_helper.dart';
import 'package:test_flutter_app/core/widgets/loader.dart';

class BaseVM with ChangeNotifier {
  bool _busy = false;
  bool _loaderOpen = false;
  bool isSilent = false;

  bool get busy => _busy;

  void setBusy(BuildContext context, [bool val = false]) {
    _busy = val;
    if (_busy) {
      _loaderOpen = true;
      if (!isSilent) {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const LoaderWidget(
            isPop: true,
          ),
        );
      }
    }
    if (!_busy && _loaderOpen) {
      _loaderOpen = false;
      if (!isSilent) {
        NavHelper.back(context);
      }
    }
    notifyListeners();
  }

  void rebuild() => notifyListeners();
}