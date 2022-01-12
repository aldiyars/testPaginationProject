import 'package:test_flutter_app/core/http/api_provider.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';

import 'base_repo.dart';

class HomeRepo extends BaseRepo {
  HomeRepo({ApiProvider? httpClient}) : super(httpClient: httpClient);

  Future<List<User>?> getUsers({required int page, required int limit, required bool update}) async {
    var conn = await checkConnection();
    final String url = urlV1Part('/user?' + ('page=${update ? 1 : page}&limit=$limit'));
    print(url);
    if (!conn) {
      // var list = await HiveService.getOfflineListBox(BoxNameStore.getAuthors);
      // return list.cast<Author>();
    }
    final List response = await httpClient!.getList(url);
    return response.map((e) => User.fromMap(e)).toList();
  }
}
