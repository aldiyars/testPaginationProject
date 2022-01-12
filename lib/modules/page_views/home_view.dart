import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_app/core/constants/box_name_store.dart';
import 'package:test_flutter_app/core/constants/styles.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/core/widgets/loader.dart';
import 'package:test_flutter_app/core/widgets/user_item.dart';
import 'package:test_flutter_app/modules/view_models/main_vm.dart';

///Страница список Юзеров
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    ///один раз отправляеть запрос на сервер при открытие этого страница
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await Provider.of<HomeVM>(context, listen: false).getUsers();
        setState(() {
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeVM>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Пагинация"),
        ),

        ///HiveListener слушаеть изменение по BOX-у.
        body: HiveListener(
          box: Hive.box(BoxNameStore.user),
          builder: (userBox) {
            List<User> list = userBox.values.toList().cast<User>();

            ///Елси локальный список юзеров пустой и идеть загрузка, отображаеться виджет загрузка
            ///т.к для пользователья будеть понятно что сейчас происходит
            return list.isEmpty && _loading
                ? const LoaderWidget()
                : RefreshIndicator(
                    onRefresh: () => vm.getUsers().then((value) => setState(() {})),
                    child: list.isNotEmpty

                        ///Если список не пустой, отабражаеть список
                        ? Scrollbar(
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                if (list.length - 1 == index) {
                                  vm.loadMore(true).then((value) => setState(() {}));
                                }
                                return Column(
                                  children: [
                                    Dismissible(
                                      background: Container(
                                        color: AppTheme.kRedColor,
                                      ),
                                      key: Key(list[index].id!),
                                      onDismissed: (onDismissed) async {
                                        await vm.deleteUserFromLocal(index, list[index]);
                                      },
                                      child: UsetItem(
                                        user: list[index],
                                      ),
                                    ),

                                    ///Если по пагинация идет загрузка и этот элемент посленый тогда покажет что загрузка по погнация
                                    if (vm.loadingProgress && list.length - 1 == index) const LoaderWidget()
                                  ],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(
                                  height: 1.sp,
                                  color: AppTheme.kGrayColor,
                                );
                              },
                              itemCount: list.length,
                            ),
                          )
                        : _loading
                            ? const LoaderWidget()

                            ///а если пустой и загрузка прошла, тогда тут сообщим об это
                            : const Center(
                                child: Text('список пустой'),
                              ),
                  );
          },
        )
        // resizeToAvoidBottomPadding: false,
        );
  }
}
