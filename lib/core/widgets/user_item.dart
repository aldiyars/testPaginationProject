import 'package:flutter/material.dart';
import 'package:test_flutter_app/core/constants/styles.dart';
import 'package:test_flutter_app/core/helpers/date_helper.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/generated/l10n.dart';

import 'cached_image.dart';

///Виджет для отображение данный юзера
class UsetItem extends StatelessWidget {
  final User? user;

  const UsetItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        child: CachedImage(user!.avatar ?? ''),
        height: 50,
        width: 50,
      ),
      title: Text(
        user!.name ?? '',
        style: AppTheme.mainTS.copyWith(fontSize: AppTheme.appTitleFontSize),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${S.current.createdAt}:' +
                  DateHelper.formatFull(
                    user!.createdAt!,
                  ),
              style: AppTheme.mainTS.copyWith(
                fontSize: AppTheme.appSubtitleFontSize,
                color: AppTheme.kDarkGrayColor,
                height: 1.3,
              )),
          Row(
            children: [
              Text('${S.current.status}: '),
              Expanded(
                child: Text(user!.isActive! ? 'Активно' : "Неактивно",
                    style: AppTheme.mainTS.copyWith(
                      fontSize: AppTheme.appSubtitleFontSize,
                      color: user!.isActive! ? AppTheme.kGreenColor : AppTheme.kRedColor,
                      height: 1.3,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
