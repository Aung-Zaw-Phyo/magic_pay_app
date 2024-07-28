import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_state.dart';
import 'package:magic_pay_app/features/transfer/presentation/pages/transfer_confirm_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockTransferConfirmBloc
    extends MockBloc<TransferConfirmEvent, TransferConfirmState>
    implements TransferConfirmBloc {}

void main() {
  late MockTransferConfirmBloc mockTransferConfirmBloc;

  setUp(() {
    mockTransferConfirmBloc = MockTransferConfirmBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransferConfirmBloc>(
          create: (context) => mockTransferConfirmBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const transferDataEntity = TransferDataEntity(
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
      when(() => mockTransferConfirmBloc.state)
          .thenReturn(const TransferConfirmLoaded(transferDataEntity));

      // Act
      await widgetTester
          .pumpWidget(makeTestableWidget(const TransferConfirmScreen()));

      // Assert
      expect(find.text(transferDataEntity.fromName), findsOneWidget);
      expect(find.text(transferDataEntity.fromPhone), findsOneWidget);
      expect(find.text(transferDataEntity.toName), findsOneWidget);
      expect(find.text(transferDataEntity.toPhone), findsOneWidget);
      expect(find.text(transferDataEntity.amount.toString()), findsOneWidget);
      expect(find.text(transferDataEntity.description!), findsOneWidget);
    },
  );
}
