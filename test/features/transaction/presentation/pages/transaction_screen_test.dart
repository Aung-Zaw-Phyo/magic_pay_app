import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_state.dart';
import 'package:magic_pay_app/features/transaction/presentation/pages/transaction_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockTransactionsBloc
    extends MockBloc<TransactionsEvent, TransactionsState>
    implements TransactionsBloc {}

void main() {
  late MockTransactionsBloc mockTransactionsBloc;

  setUp(() {
    mockTransactionsBloc = MockTransactionsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TransactionsBloc>(
      create: (context) => mockTransactionsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testTransactions = [
    TransactionEntity(
      trxId: '123',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
    TransactionEntity(
      trxId: '456',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
  ];

  const testTransactionsDataEntity = TransactionsDataEntity(
    currentPage: 1,
    lastPage: 2,
    transactions: testTransactions,
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      // arrange
      when(() => mockTransactionsBloc.state)
          .thenReturn(const TransactionsLoading());

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const TransactionScreen()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show error message when state is load failed',
    (widgetTester) async {
      // arrange
      when(() => mockTransactionsBloc.state)
          .thenReturn(const TransactionsLoadFailed('Something wrong.'));

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const TransactionScreen()));

      // assert
      expect(find.text('Something wrong.'), findsOneWidget);
    },
  );

  testWidgets(
    'should show transaction data when state is loaded',
    (widgetTester) async {
      // arrange
      when(() => mockTransactionsBloc.state)
          .thenReturn(const TransactionsLoaded(testTransactionsDataEntity));

      // act
      await widgetTester
          .pumpWidget(makeTestableWidget(const TransactionScreen()));

      // assert
      expect(find.byKey(const Key('transactions')), findsOneWidget);
    },
  );
}
