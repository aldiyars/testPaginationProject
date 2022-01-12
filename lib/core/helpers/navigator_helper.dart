import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Этот helper в этом проекте не исползуеться
class NavHelper {
  static Future<T?> push<T>(BuildContext context, Widget page) =>
      Navigator.pushReplacement<T, Object?>(context, MaterialPageRoute(builder: (BuildContext context) => page));

  static Future<T?> pushNamed<T>(BuildContext context, String routeName, [dynamic arguments]) =>
      Navigator.pushNamed<T>(context, routeName, arguments: arguments);

  static Future<T?> pushAndReplaceNamed<T>(BuildContext context, String routeName) => Navigator.pushReplacementNamed(context, routeName);

  static Future<T?> pushPage<T>(BuildContext context, Widget page) => Navigator.push<T>(context, MaterialPageRoute(builder: (BuildContext context) => page));

  static Future<T?> pushPageDialog<T>(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page, fullscreenDialog: true));

  static Future<T?> pushPageReplacement<T>(BuildContext context, Widget page) =>
      Navigator.pushReplacement<T, Object?>(context, MaterialPageRoute(builder: (BuildContext context) => page));

  static void pushNamedAndRemoveUntil(BuildContext context, String routeName, bool Function(Route route) predicate) =>
      Navigator.pushNamedAndRemoveUntil(context, routeName, predicate);

  static void back(BuildContext context) => Navigator.pop(context);
}
