import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_state.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationsBloc
    extends MockBloc<NotificationsEvent, NotificationsState>
    implements NotificationsBloc {}

void main() {
  late MockNotificationsBloc mockNotificationsBloc;

  setUp(() {
    mockNotificationsBloc = MockNotificationsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => mockNotificationsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testNotifications = [
    NotificationEntity(
      id: '123',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
    NotificationEntity(
      id: '456',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
  ];

  const testNotificationDataEntity = NotificationDataEntity(
    currentPage: 1,
    lastPage: 2,
    notifications: testNotifications,
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationsBloc.state)
          .thenReturn(const NotificationsLoading());

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const NotificationScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is load failed',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationsBloc.state)
          .thenReturn(const NotificationsLoadFailed('Something wrong.'));

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const NotificationScreen()));

      // assert
      expect(find.text('Something wrong.'), findsOneWidget);
    },
  );

  testWidgets(
    'should show notification data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationsBloc.state)
          .thenReturn(const NotificationsLoaded(testNotificationDataEntity));

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const NotificationScreen()));

      // assert
      expect(find.byKey(const Key('notifications')), findsOneWidget);
    },
  );
}
