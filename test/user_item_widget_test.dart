import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_app/core/helpers/date_helper.dart';
import 'package:test_flutter_app/core/models/entities/user.dart';
import 'package:test_flutter_app/core/widgets/user_item.dart';
import 'package:test_flutter_app/generated/l10n.dart';

import 'utils.dart';

void main() {
  testWidgets(
    'Проверка виджета пользователя',
        (tester) async {
      const userName = 'userName', isActive = true;
      final createdAt = DateTime(2022, 1, 1);
      await tester.pumpWidget(
        testableWidget(
          child: UsetItem(
            user: User(
              name: userName,
              isActive: isActive,
              createdAt: createdAt,
            ),
          ),
        ),
      );
      await tester.pump();
      final statusTitleFinder = find.textContaining(S.current.status);
      final userNameFinder = find.textContaining(userName);
      final statusFinder =
      find.textContaining(isActive ? 'Активно' : 'Неактивно');
      final dateFinder = find.textContaining(DateHelper.formatFull(createdAt));
      expect(statusTitleFinder, findsOneWidget);
      expect(userNameFinder, findsOneWidget);
      expect(statusFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
    },
  );
}