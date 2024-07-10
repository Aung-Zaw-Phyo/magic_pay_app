import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:magic_pay_app/features/home/presentation/pages/wallet_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  late MockProfileBloc mockProfileBloc;

  setUp(() {
    mockProfileBloc = MockProfileBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<ProfileBloc>(
      create: (context) => mockProfileBloc,
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
    profile: 'profile-image',
    receiveQrValue: '123456',
    unreadNotiCount: 0,
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockProfileBloc.state).thenReturn(ProfileLoading());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const WalletScreen()));

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
      await widgetTester.pumpWidget(makeTestableWidget(const WalletScreen()));

      // assert
      expect(find.text('Something Wrong!'), findsOneWidget);
    },
  );

  testWidgets(
    'should show wallet data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoaded(profileEntity));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const WalletScreen()));

      // assert
      expect(find.byKey(const Key('wallet_data')), findsOneWidget);
    },
  );
}
