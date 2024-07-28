import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_state.dart';
import 'package:magic_pay_app/features/transfer/presentation/pages/transfer_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockTransferConfirmBloc
    extends MockBloc<TransferConfirmEvent, TransferConfirmState>
    implements TransferConfirmBloc {}

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  late MockTransferConfirmBloc mockTransferConfirmBloc;
  late MockProfileBloc mockProfileBloc;

  setUp(() {
    mockTransferConfirmBloc = MockTransferConfirmBloc();
    mockProfileBloc = MockProfileBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransferConfirmBloc>(
          create: (context) => mockTransferConfirmBloc,
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => mockProfileBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const profileEntity = ProfileEntity(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: '09968548024',
    accountNumber: '1223548799654',
    balance: '3000000',
    profile: 'https://aungzawphyo.com/images/me2.jpg',
    receiveQrValue: '09968548024',
    unreadNotiCount: 0,
  );

  testWidgets(
    'text fields should exit and work',
    (widgetTester) async {
      // Arrange
      when(() => mockTransferConfirmBloc.state)
          .thenReturn(const TransferConfirmInitial());
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoaded(profileEntity));

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const TransferScreen()));

      // Assert
      expect(find.text(profileEntity.name), findsOneWidget);
      expect(find.text(profileEntity.phone), findsOneWidget);

      var textFormFields = find.byType(TextFormField);
      expect(textFormFields, findsNWidgets(3));

      var toPhoneField = find.byKey(const Key('to_phone_field'));
      expect(toPhoneField, findsOneWidget);
      await widgetTester.enterText(toPhoneField, '123455');
      expect(find.text('123455'), findsOneWidget);

      var amountField = find.byKey(const Key('amount_field'));
      expect(amountField, findsOneWidget);
      await widgetTester.enterText(amountField, '3000');
      expect(find.text('3000'), findsOneWidget);

      var descriptionField = find.byKey(const Key('description_field'));
      expect(descriptionField, findsOneWidget);
      await widgetTester.enterText(
          descriptionField, 'This is description text.');
      expect(find.text('This is description text.'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading ',
    (widgetTester) async {
      // arrange
      when(() => mockTransferConfirmBloc.state)
          .thenReturn(const TransferConfirmLoading());
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoaded(profileEntity));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const TransferScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is fail',
    (widgetTester) async {
      // arrange
      when(() => mockTransferConfirmBloc.state)
          .thenReturn(const TransferConfirmLoadFailed('Validation Error!'));
      when(() => mockProfileBloc.state)
          .thenReturn(const ProfileLoaded(profileEntity));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const TransferScreen()));

      // assert
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    },
  );
}
