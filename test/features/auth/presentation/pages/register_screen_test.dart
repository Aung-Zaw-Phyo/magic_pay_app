import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_state.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_state.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/login_screen.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/register_screen.dart';
import 'package:magic_pay_app/injection_container.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthActionBloc extends MockBloc<AuthActionEvent, AuthActionState>
    implements AuthActionBloc {}

class MockAuthStatusBloc extends MockBloc<AuthStatusEvent, AuthStatusState>
    implements AuthStatusBloc {}

void main() {
  late AuthActionBloc mockAuthActionBloc;
  late AuthStatusBloc mockAuthStatusBloc;

  setUpAll(() {
    setupLocator();

    mockAuthActionBloc = MockAuthActionBloc();
    mockAuthStatusBloc = MockAuthStatusBloc();

    locator.unregister<AuthActionBloc>();
    locator.unregister<AuthStatusBloc>();

    locator.registerFactory<AuthActionBloc>(() => mockAuthActionBloc);
    locator.registerFactory<AuthStatusBloc>(() => mockAuthStatusBloc);
  });

  tearDownAll(() {
    locator.reset();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<AuthStatusBloc>(
      create: (context) => mockAuthStatusBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testResponseData = ResponseData(
    result: true,
    message: 'Successfully registered.',
    data: 'token data',
  );

  testWidgets(
    'text fields should exit and work',
    (widgetTester) async {
      // Arrange
      when(() => mockAuthActionBloc.state).thenReturn(AuthInitial());

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const RegisterScreen()));

      // Assert
      var textFormFields = find.byType(TextFormField);
      expect(textFormFields, findsNWidgets(4));

      var nameField = find.byKey(const Key('name_field'));
      expect(nameField, findsOneWidget);
      await widgetTester.enterText(nameField, 'John');
      expect(find.text('John'), findsOneWidget);

      var emailField = find.byKey(const Key('email_field'));
      expect(emailField, findsOneWidget);
      await widgetTester.enterText(emailField, 'john@gmail.com');
      expect(find.text('john@gmail.com'), findsOneWidget);

      var phoneField = find.byKey(const Key('phone_field'));
      expect(phoneField, findsOneWidget);
      await widgetTester.enterText(phoneField, '123455');
      expect(find.text('123455'), findsOneWidget);

      var passwordField = find.byKey(const Key('password_field'));
      expect(passwordField, findsOneWidget);
      await widgetTester.enterText(passwordField, 'password');
      expect(find.text('password'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading ',
    (widgetTester) async {
      // arrange
      when(() => mockAuthActionBloc.state).thenReturn(AuthLoading());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const RegisterScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is fail',
    (widgetTester) async {
      // arrange
      when(() => mockAuthActionBloc.state)
          .thenReturn(const AuthLoadFailed(message: 'Auth Failed!'));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const RegisterScreen()));

      // assert
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    },
  );

  testWidgets(
    'should show success message when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockAuthActionBloc.state)
          .thenReturn(const AuthLoaded(result: testResponseData));

      when(() => mockAuthStatusBloc.state).thenReturn(Authenticated());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const RegisterScreen()));

      // assert
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    },
  );
}
