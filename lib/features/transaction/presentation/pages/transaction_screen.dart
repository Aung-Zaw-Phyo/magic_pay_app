import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_state.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    final transactionBloc = BlocProvider.of<TransactionsBloc>(context);
    if (transactionBloc.state.transactionsData == null) {
      transactionBloc.add(const GetTransactions(1));
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        final data = transactionBloc.state.transactionsData;
        if (data != null && data.currentPage < data.lastPage) {
          transactionBloc.add(GetTransactions(data.currentPage + 1));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    BlocProvider.of<TransactionsBloc>(context).add(const TransactionsRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TransactionsLoadFailed) {
            return Center(
              child: Text(state.error!),
            );
          }

          if (state is TransactionsLoaded) {
            return Padding(
              key: const Key('transactions'),
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          state.transactionsData!.transactions.length + 1,
                      itemBuilder: (context, index) {
                        if (index <
                            state.transactionsData!.transactions.length) {
                          final transaction =
                              state.transactionsData!.transactions[index];
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/transaction_detail',
                                  arguments: transaction.trxId,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Trx Id: ${transaction.trxId}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontSize: 17,
                                              ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          transaction.amount,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.red,
                                                fontSize: 17,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      transaction.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.8),
                                          ),
                                    ),
                                    Text(
                                      transaction.dateTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.8),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          if (state.transactionsData!.currentPage ==
                              state.transactionsData!.lastPage) {
                            return const SizedBox();
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          }

          return Container();
        }),
      ),
    );
  }
}
