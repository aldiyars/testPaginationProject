import 'package:hive/hive.dart';
import 'package:test_flutter_app/core/constants/box_name_store.dart';
import 'package:test_flutter_app/core/http/api_provider.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/core/services/hive_service.dart';

import 'base_repo.dart';

///Репозитория для главного страница, который сделаеть запрос по параметр и сохраняеть в hive через HiveService
class HomeRepo extends BaseRepo {
  HomeRepo({ApiProvider? httpClient}) : super(httpClient: httpClient);

  Future<List<User>?> getUsers({required int page, required int limit, required bool update}) async {
    ///Проверка интернет
    final bool conn = await checkConnection();

    ///если update = true тогда первый страница загружиться, а есле false тогда по пагинация
    final String url = urlV1Part('/user?' + ('page=${update ? 1 : page}&limit=$limit'));
    print(url);

    ///Если нет интернет, тогда все ОК, верну список из локлный БД
    if (!conn) {
      final List list = await HiveService.getOfflineListBox(BoxNameStore.user);
      return list.cast<User>();
    }
    final List response = await httpClient!.getList(url);
    final Box box = await HiveService.getBox(BoxNameStore.user);

    ///Если есть инернет, проверью, это запрос для получение список юзеров или пагинация
    ///если запрос для получение список юзеров, тогда clear сделаю
    if (update) {
      await box.clear();
    }

    ///и все новый данный добавлю в Hive
    await box.addAll(response.map((e) => User.fromMap(e)).toList());

    ///Верню список, который был в последный запросе
    return response.map((e) => User.fromMap(e)).toList();
  }
}
