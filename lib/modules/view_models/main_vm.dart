import 'package:flutter/material.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/core/repos/home_repo.dart';
import 'package:test_flutter_app/modules/view_models/base_vm.dart';

class HomeVM extends ChangeNotifier {
  final HomeRepo? _homeRepo;

  HomeVM(this._homeRepo);

  int _pageNumber = 1;
  final int _limit = 20;
  List<User>? _userList;
  bool _isLoadingProgress = false;
  bool _isLastPage = false;

  int get getPageNumber => _pageNumber;

  bool get loadingProgress => _isLoadingProgress;

  List<User>? get users => _userList;

  set pageNumber(int val) {
    _pageNumber = val;
    notifyListeners();
  }

  void deleteUserFromList(int id) {
    _userList!.removeAt(id);
    notifyListeners();
  }

  Future getUsers(BuildContext context, [bool update = false]) async {
    if (users == null || update) {
      _userList = await _homeRepo!.getUsers(page: _pageNumber, update: update, limit: _limit);
      _pageNumber = 1;
      _isLastPage = false;
      notifyListeners();
    }
  }

  Future loadMore(bool lasItem) async {
    if (!lasItem || _isLoadingProgress || _isLastPage) return;
    _isLoadingProgress = true;
    List<User>? list = await _homeRepo!.getUsers(page: _pageNumber + 1, update: false, limit: _limit);
    _isLastPage = list!.length < _limit;
    _userList!.addAll(list);
    _pageNumber++;
    _isLoadingProgress = false;
    notifyListeners();
  }
}
