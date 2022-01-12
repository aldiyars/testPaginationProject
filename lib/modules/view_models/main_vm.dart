import 'package:flutter/material.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/core/repos/home_repo.dart';

///ViewModel для главного экрана, все глабалные переменные храниться здесь после hive до закрытие главного экрана
class HomeVM extends ChangeNotifier {
  final HomeRepo? _homeRepo;

  HomeVM(this._homeRepo);

  ///Количество одном страница в пагинация
  final int _limit = 20;
  List<User>? _userList;

  ///Загрузка идет по пагинация ли нет
  bool _isLoadingProgress = false;

  ///Последный страница по пагинация ли нет
  bool _isLastPage = false;

  ///номер страница по пагинция
  int _pageNumber = 1;

  ///Getters
  int get getPageNumber => _pageNumber;

  bool get loadingProgress => _isLoadingProgress;

  List<User>? get users => _userList;

  ///Setters
  set pageNumber(int val) {
    _pageNumber = val;
    notifyListeners();
  }

  ///Удаление по id из лист и удаление объект из Hive
  Future<void> deleteUserFromLocal(int id, User user) async {
    _userList!.removeAt(id);
    await user.delete();
    notifyListeners();
  }

  ///Получение список Юзеров
  Future getUsers() async {
    _userList = await _fetchDate(true);
    _pageNumber = 1;
    _isLastPage = false;
    notifyListeners();
  }

  ///Пагинация, работаеть когда скрол в конце список.
  Future loadMore(bool isLastItem) async {
    if (!isLastItem || _isLoadingProgress || _isLastPage) return;
    _isLoadingProgress = true;
    List<User>? result = await _fetchDate(false);

    ///провер
    _isLastPage = result!.length < _limit;
    _userList!.addAll(result);
    _pageNumber++;
    _isLoadingProgress = false;
    notifyListeners();
  }

  ///Загрузка данный из сервер и синхронизация с Hive
  Future<List<User>?> _fetchDate(bool update) async {
    try {
      List<User>? response = await _homeRepo!.getUsers(page: _pageNumber + 1, update: update, limit: _limit);
      return response;
    } catch (e) {
      _isLoadingProgress = false;
    }
  }
}
