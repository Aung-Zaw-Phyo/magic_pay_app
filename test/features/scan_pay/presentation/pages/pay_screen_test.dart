import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/pay_form_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockScanQrCodeBloc extends MockBloc<ScanQrCodeEvent, ScanQrCodeState>
    implements ScanQrCodeBloc {}

class MockPayConfirmBloc extends MockBloc<PayConfirmEvent, PayConfirmState>
    implements PayConfirmBloc {}

void main() {
  late MockScanQrCodeBloc mockScanQrCodeBloc;
  late MockPayConfirmBloc mockPayConfirmBloc;

  setUp(() {
    mockScanQrCodeBloc = MockScanQrCodeBloc();
    mockPayConfirmBloc = MockPayConfirmBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScanQrCodeBloc>(
          create: (context) => mockScanQrCodeBloc,
        ),
        BlocProvider<PayConfirmBloc>(
          create: (context) => mockPayConfirmBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const scanPayFormDataEntity = ScanPayFormDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '012345',
    toName: 'Mary',
    toPhone: '123456',
  );

  testWidgets(
    'text fields should exit and work',
    (widgetTester) async {
      // Arrange
      when(() => mockPayConfirmBloc.state)
          .thenReturn(const PayConfirmInitial());
      when(() => mockScanQrCodeBloc.state)
          .thenReturn(const ScanQrCodeLoaded(scanPayFormDataEntity));

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const PayFormScreen()));

      // Assert
      expect(find.text(scanPayFormDataEntity.fromName), findsOneWidget);
      expect(find.text(scanPayFormDataEntity.fromPhone), findsOneWidget);
      expect(find.text(scanPayFormDataEntity.toName), findsOneWidget);
      expect(find.text(scanPayFormDataEntity.toPhone), findsOneWidget);

      var textFormFields = find.byType(TextFormField);
      expect(textFormFields, findsNWidgets(2));

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
      when(() => mockScanQrCodeBloc.state)
          .thenReturn(const ScanQrCodeLoaded(scanPayFormDataEntity));
      when(() => mockPayConfirmBloc.state)
          .thenReturn(const PayConfirmLoading());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const PayFormScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is fail',
    (widgetTester) async {
      // arrange
      when(() => mockScanQrCodeBloc.state)
          .thenReturn(const ScanQrCodeLoaded(scanPayFormDataEntity));
      when(() => mockPayConfirmBloc.state)
          .thenReturn(const PayConfirmLoadFailed('Validation Error!'));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const PayFormScreen()));

      // assert
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    },
  );
}
