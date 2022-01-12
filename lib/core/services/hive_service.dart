
import 'package:hive/hive.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';

///Helper для локального бд Hive
class HiveService {
  ///Cоздать или получить открытый бокс
  static Future getBox(String name) async {
    Box box;
    if (!Hive.isBoxOpen(name)) {
      box = await Hive.openBox(name);
    } else {
      box = Hive.box(name);
    }
    return box;
  }

  ///Получение список по имени Box
  static Future<List> getOfflineListBox(String name) async {
    var box = await getBox(name);
    var list = box.values.toList();
    return list;
  }

  ///Очистка Box по имени
  static Future<Box> getClearBox(String name) async {
    final box = await getBox(name);
    await box.clear().catchError((val) => print(val));
    return box;
  }

  ///Регистрация при инициализация
  static void register() {
    Hive.registerAdapter<User>(UserAdapter());
  }

}
