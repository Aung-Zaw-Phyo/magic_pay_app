import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransferCompleteUseCase mockTransferCompleteUseCase;
  late TransferCompleteBloc transferCompleteBloc;

  setUp(() {
    mockTransferCompleteUseCase = MockTransferCompleteUseCase();
    transferCompleteBloc = TransferCompleteBloc(mockTransferCompleteUseCase);
  });

  const testTransferRequestEntity = TransferRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    password: 'password',
  );
  const transactionId = '234234789';

  test('initial state should be loading', () {
    expect(transferCompleteBloc.state, const TransferCompleteInitial());
  });

  group('transfer complete', () {
    blocTest<TransferCompleteBloc, TransferCompleteState>(
      'should emit [TransferCompleteLoading, TransferCompleteLoaded] when data is gotten successfully.',
      build: () {
        when(mockTransferCompleteUseCase.execute(testTransferRequestEntity))
            .thenAnswer((_) async => const Right(transactionId));
        return transferCompleteBloc;
      },
      act: (bloc) =>
          bloc.add(const TransferComplete(testTransferRequestEntity)),
      expect: () => [
        const TransferCompleteLoading(),
        const TransferCompleteLoaded(transactionId),
      ],
    );

    blocTest<TransferCompleteBloc, TransferCompleteState>(
      'should emit [TransferCompleteLoading, TransferCompleteLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockTransferCompleteUseCase.execute(testTransferRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure("Server failure.")));
        return transferCompleteBloc;
      },
      act: (bloc) =>
          bloc.add(const TransferComplete(testTransferRequestEntity)),
      expect: () => [
        const TransferCompleteLoading(),
        const TransferCompleteLoadFailed("Server failure."),
      ],
    );
  });
}
