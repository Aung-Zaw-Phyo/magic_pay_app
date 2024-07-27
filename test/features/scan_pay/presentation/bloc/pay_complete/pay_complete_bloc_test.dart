import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockPayCompleteUseCase mockPayCompleteUseCase;
  late PayCompleteBloc payCompleteBloc;

  setUp(() {
    mockPayCompleteUseCase = MockPayCompleteUseCase();
    payCompleteBloc = PayCompleteBloc(mockPayCompleteUseCase);
  });

  const testScanPayRequestEntity = ScanPayRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    password: 'password',
  );
  const trxId = '234234789';

  test('initial state should be initial', () {
    expect(payCompleteBloc.state, const PayCompleteInitial());
  });

  group('pay complete bloc', () {
    blocTest<PayCompleteBloc, PayCompleteState>(
      'should emit [PayCompleteLoading, PayCompleteLoaded] when data is gotten successfully.',
      build: () {
        when(mockPayCompleteUseCase.execute(testScanPayRequestEntity))
            .thenAnswer((_) async => const Right(trxId));
        return payCompleteBloc;
      },
      act: (bloc) => bloc.add(const PayComplete(testScanPayRequestEntity)),
      expect: () => [
        const PayCompleteLoading(),
        const PayCompleteLoaded(trxId),
      ],
    );

    blocTest<PayCompleteBloc, PayCompleteState>(
      'should emit [PayCompleteLoading, PayCompleteLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockPayCompleteUseCase.execute(testScanPayRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure("Server failure.")));
        return payCompleteBloc;
      },
      act: (bloc) => bloc.add(const PayComplete(testScanPayRequestEntity)),
      expect: () => [
        const PayCompleteLoading(),
        const PayCompleteLoadFailed("Server failure."),
      ],
    );
  });
}
