import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_app/core/repos/home_repo.dart';
import 'package:test_flutter_app/core/http/api_provider.dart';
import 'package:test_flutter_app/modules/page_views/home_view.dart';
import 'package:test_flutter_app/modules/view_models/main_vm.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  @override
  Widget build(BuildContext context) {
    ///Создаю Home view model и передаю нужные параметры при открие страница
    return Provider<HomeVM>(
      dispose: (context, vm) => vm.dispose(),
      create: (context) => HomeVM(HomeRepo(httpClient: ApiProvider())),
      child: HomeView(),
    );
  }
}
