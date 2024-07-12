import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_state.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:magic_pay_app/features/home/presentation/pages/account_screen.dart';
import 'package:magic_pay_app/injection_container.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class MockAuthActionBloc extends MockBloc<AuthActionEvent, AuthActionState>
    implements AuthActionBloc {}

void main() {
  late MockProfileBloc mockProfileBloc;
  late AuthActionBloc mockAuthActionBloc;

  setUpAll(() {
    setupLocator();

    mockProfileBloc = MockProfileBloc();
    mockAuthActionBloc = MockAuthActionBloc();
    HttpOverrides.global = null;

    locator.unregister<AuthActionBloc>();

    locator.registerFactory<AuthActionBloc>(() => mockAuthActionBloc);
  });

  tearDownAll(() {
    locator.reset();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(create: (_) => mockProfileBloc),
        BlocProvider<AuthActionBloc>(create: (_) => mockAuthActionBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  const profileEntity = ProfileEntity(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: '123456',
    accountNumber: '1223548799654',
    balance: '3000000',
    profile: 'https://aungzawphyo.com/images/me2.jpg',
    receiveQrValue: '123456',
    unreadNotiCount: 0,
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockProfileBloc.state).thenReturn(ProfileLoading());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const AccountScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is load failed',
    (widgetTester) async {
      // arrange
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoadFailed("Something Wrong!"));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const AccountScreen()));

      // assert
      expect(find.text('Something Wrong!'), findsOneWidget);
    },
  );

  testWidgets(
    'should show account data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoaded(profileEntity));
      when(() => mockAuthActionBloc.state).thenReturn(AuthInitial());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const AccountScreen()));

      // assert
      expect(find.byKey(const Key('account_data')), findsOneWidget);
    },
  );
}
