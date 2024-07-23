import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_state.dart';
import 'package:magic_pay_app/features/transaction/presentation/pages/transaction_detail_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionDetailBloc
    extends MockBloc<TransactionDetailEvent, TransactionDetailState>
    implements TransactionDetailBloc {}

void main() {
  late MockTransactionDetailBloc mockTransactionDetailBloc;

  setUp(() {
    mockTransactionDetailBloc = MockTransactionDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TransactionDetailBloc>(
      create: (context) => mockTransactionDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const transactionId = '4549612618172021';
  const testTransactionDetailEntity = TransactionDetailEntity(
    trxId: transactionId,
    refNo: '2165214577780755',
    amount: '3,000.00 MMK',
    type: 1,
    dateTime: '2024-07-22 12:56:57',
    source: 'Mary',
    description: 'Class Fee',
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockTransactionDetailBloc.state)
          .thenReturn(const TransactionDetailLoading());

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const TransactionDetailScreen(transactionId: transactionId),
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
      when(() => mockTransactionDetailBloc.state)
          .thenReturn(const TransactionDetailLoadFailed('Something wrong.'));

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const TransactionDetailScreen(transactionId: transactionId),
        ),
      );

      // assert
      expect(find.text('Something wrong.'), findsOneWidget);
    },
  );

  testWidgets(
    'should show transaction detail data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockTransactionDetailBloc.state).thenReturn(
          const TransactionDetailLoaded(testTransactionDetailEntity));

      // act
      await widgetTester.pumpWidget(
        makeTestableWidget(
          const TransactionDetailScreen(transactionId: transactionId),
        ),
      );

      // assert
      expect(find.byKey(const Key('transaction_detail')), findsOneWidget);
    },
  );
}
