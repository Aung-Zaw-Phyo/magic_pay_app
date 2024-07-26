import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_state.dart';
import 'package:magic_pay_app/features/transaction/presentation/pages/widgets/detail_info.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String transactionId;
  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  State<TransactionDetailScreen> createState() =>
      TransactionDetailScreenState();
}

class TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<TransactionDetailBloc>(context)
        .add(GetTransactionDetail(widget.transactionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/transaction');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaction Detail'),
        ),
        body: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
          builder: (context, state) {
            if (state is TransactionDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is TransactionDetailLoadFailed) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is TransactionDetailLoaded) {
              final transaction = state.transaction;
              return Center(
                key: const Key('transaction_detail'),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/accept.png'),
                          width: 100,
                        ),
                        const SizedBox(height: 28),
                        Text(
                          transaction.amount,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 163, 17, 7),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        DetailInfo(label: 'Trx Id', value: transaction.trxId),
                        const SizedBox(height: 16),
                        DetailInfo(
                            label: 'Reference Number',
                            value: transaction.refNo),
                        const SizedBox(height: 16),
                        DetailInfo(
                            label: 'Type',
                            value:
                                transaction.type == 1 ? 'Income' : 'Expense'),
                        const SizedBox(height: 16),
                        DetailInfo(label: 'Amount', value: transaction.amount),
                        const SizedBox(height: 16),
                        DetailInfo(
                            label: 'Date and Time',
                            value: transaction.dateTime),
                        const SizedBox(height: 16),
                        DetailInfo(
                            label: transaction.type == 1 ? 'From' : 'To',
                            value: transaction.source),
                        const SizedBox(height: 16),
                        DetailInfo(
                          label: 'Description',
                          value: transaction.description ?? '',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
