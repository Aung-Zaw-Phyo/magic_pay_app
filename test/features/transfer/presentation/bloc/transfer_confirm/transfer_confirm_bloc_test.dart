import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransferConfirmUseCase mockTransferConfirmUseCase;
  late TransferConfirmBloc transferConfirmBloc;

  setUp(() {
    mockTransferConfirmUseCase = MockTransferConfirmUseCase();
    transferConfirmBloc = TransferConfirmBloc(mockTransferConfirmUseCase);
  });

  const testTransferRequestEntity = TransferRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
  );
  const testTransferDataEntity = TransferDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  test('initial state should be loading', () {
    expect(transferConfirmBloc.state, const TransferConfirmInitial());
  });

  group('transfer confirm', () {
    blocTest<TransferConfirmBloc, TransferConfirmState>(
      'should emit [TransferConfirmLoading, TransferConfirmLoaded] when data is gotten successfully.',
      build: () {
        when(mockTransferConfirmUseCase.execute(testTransferRequestEntity))
            .thenAnswer((_) async => const Right(testTransferDataEntity));
        return transferConfirmBloc;
      },
      act: (bloc) => bloc.add(const TransferConfirm(testTransferRequestEntity)),
      expect: () => [
        const TransferConfirmLoading(),
        const TransferConfirmLoaded(testTransferDataEntity),
      ],
    );

    blocTest<TransferConfirmBloc, TransferConfirmState>(
      'should emit [TransferConfirmLoading, TransferConfirmLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockTransferConfirmUseCase.execute(testTransferRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure("Server failure.")));
        return transferConfirmBloc;
      },
      act: (bloc) => bloc.add(const TransferConfirm(testTransferRequestEntity)),
      expect: () => [
        const TransferConfirmLoading(),
        const TransferConfirmLoadFailed("Server failure."),
      ],
    );
  });
}
