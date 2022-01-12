import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_app/core/constants/styles.dart';
import 'package:test_flutter_app/core/widgets/loader.dart';
import 'package:test_flutter_app/core/widgets/user_item.dart';
import 'package:test_flutter_app/modules/view_models/main_vm.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        await Provider.of<HomeVM>(context, listen: false).getUsers(context, true);
        setState(() {
          loading = false;
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
      body: vm.users != null
          ? RefreshIndicator(
              onRefresh: () => vm.getUsers(context, true).then((value) => setState(() {})),
              child: Scrollbar(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    if (vm.users!.length - 1 == index) {
                      vm.loadMore(true).then((value) => setState(() {}));
                    }
                    return Column(
                      children: [
                        Dismissible(
                          background: Container(
                            color: AppTheme.kRedColor,
                          ),
                          key: Key(vm.users![index].id!),
                          onDismissed: (onDismissed) {
                            setState(() {
                              vm.deleteUserFromList(index);
                            });
                          },
                          child: UsetItem(
                            user: vm.users![index],
                          ),
                        ),
                        if (vm.loadingProgress && vm.users!.length - 1 == index) const LoaderWidget()
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1.sp,
                      color: AppTheme.kGrayColor,
                    );
                  },
                  itemCount: vm.users?.length ?? 0,
                ),
              ),
            )
          : loading
              ? const LoaderWidget()
              : const SizedBox(),
      // resizeToAvoidBottomPadding: false,
    );
  }
}
