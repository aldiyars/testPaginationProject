import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_flutter_app/generated/l10n.dart';

class _Wrapper extends StatelessWidget {
  final Widget child;

  const _Wrapper(this.child);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      const BoxConstraints(maxWidth: 1125, maxHeight: 2436),
      context: context,
    );
    return child;
  }
}

Widget testableWidget({required Widget child}) {
  return Localizations(
    delegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      S.delegate,
    ],
    locale: const Locale('ru'),
    child: MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(body: _Wrapper(child)),
      ),
    ),
  );
}