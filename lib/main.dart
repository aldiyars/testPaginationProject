import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_app/core/constants/route_names.dart';
import 'package:test_flutter_app/core/constants/styles.dart';
import 'package:test_flutter_app/modules/page_views/home_page_view.dart';

import 'generated/l10n.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      /*1080*2160*/
      designSize: const Size(392.72727272727275, 737.4545454545455),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            textTheme: AppTheme.mainTxtTheme,
          ),
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
            Locale('ru', 'RU'),
            Locale('kk', 'KZ'),
          ],
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          // locale: const Locale('kk'),
          locale: const Locale('ru'),
          // locale: const Locale('en'),
          initialRoute: RouteNames.splashScreen,
          routes: {
            RouteNames.splashScreen: (context) => const HomePageView(),
          },
        );
      },
    );
  }
}
