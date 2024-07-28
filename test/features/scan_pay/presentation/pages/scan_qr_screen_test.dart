import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/scan_qr_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockScanQrCodeBloc extends MockBloc<ScanQrCodeEvent, ScanQrCodeState>
    implements ScanQrCodeBloc {}

void main() {
  late MockScanQrCodeBloc mockScanQrCodeBloc;

  setUp(() {
    mockScanQrCodeBloc = MockScanQrCodeBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScanQrCodeBloc>(
          create: (context) => mockScanQrCodeBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should show progress indicator when state is loading ',
    (widgetTester) async {
      // arrange
      when(() => mockScanQrCodeBloc.state)
          .thenReturn(const ScanQrCodeLoading());

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const ScanQrScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is fail',
    (widgetTester) async {
      // arrange
      when(() => mockScanQrCodeBloc.state)
          .thenReturn(const ScanQrCodeLoadFailed('Validation Error!'));

      // act
      await widgetTester.pumpWidget(makeTestableWidget(const ScanQrScreen()));

      // assert
      expect(find.byType(ScaffoldMessenger), findsOneWidget);
    },
  );
}
