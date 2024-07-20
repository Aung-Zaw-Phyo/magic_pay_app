import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_state.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_detail_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationDetailBloc
    extends MockBloc<NotificationDetailEvent, NotificationDetailState>
    implements NotificationDetailBloc {}

void main() {
  late MockNotificationDetailBloc mockNotificationDetailBloc;

  setUp(() {
    mockNotificationDetailBloc = MockNotificationDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NotificationDetailBloc>(
      create: (context) => mockNotificationDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testNotificationDetailEntity = NotificationDetailEntity(
    title: "Password Updated",
    message: "Your password updated successfully!",
    dateTime: "2024-07-09 02:07:40 PM",
    deepLink: DeepLink(
      target: "profile",
      parameter: null,
    ),
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationDetailBloc.state)
          .thenReturn(const NotificationDetailLoading());

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const NotificationDetailScreen(notificationId: '123'),
        ),
      );

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is load failed',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationDetailBloc.state)
          .thenReturn(const NotificationDetailLoadFailed('Something wrong.'));

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const NotificationDetailScreen(notificationId: '123'),
        ),
      );

      // assert
      expect(find.text('Something wrong.'), findsOneWidget);
    },
  );

  testWidgets(
    'should show notification detail data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockNotificationDetailBloc.state).thenReturn(
          const NotificationDetailLoaded(testNotificationDetailEntity));

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const NotificationDetailScreen(notificationId: '123'),
        ),
      );

      // assert
      expect(find.byKey(const Key('notification_detail')), findsOneWidget);
    },
  );
}
