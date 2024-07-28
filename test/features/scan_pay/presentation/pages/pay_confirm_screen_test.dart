import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/pay_confirm_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockPayConfirmBloc extends MockBloc<PayConfirmEvent, PayConfirmState>
    implements PayConfirmBloc {}

void main() {
  late MockPayConfirmBloc mockPayConfirmBloc;

  setUp(() {
    mockPayConfirmBloc = MockPayConfirmBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PayConfirmBloc>(
          create: (context) => mockPayConfirmBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const scanPayDataEntity = ScanPayDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  testWidgets(
    'text fields should exit',
    (widgetTester) async {
      // Arrange
      when(() => mockPayConfirmBloc.state)
          .thenReturn(const PayConfirmLoaded(scanPayDataEntity));

      // Act
      await widgetTester
          .pumpWidget(makeTestableWidget(const PayConfirmScreen()));

      // Assert
      expect(find.text(scanPayDataEntity.fromName), findsOneWidget);
      expect(find.text(scanPayDataEntity.fromPhone), findsOneWidget);
      expect(find.text(scanPayDataEntity.toName), findsOneWidget);
      expect(find.text(scanPayDataEntity.toPhone), findsOneWidget);
      expect(find.text(scanPayDataEntity.amount.toString()), findsOneWidget);
      expect(find.text(scanPayDataEntity.description!), findsOneWidget);
    },
  );
}
