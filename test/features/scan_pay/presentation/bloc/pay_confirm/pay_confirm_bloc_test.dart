import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockPayConfirmUseCase mockPayConfirmUseCase;
  late PayConfirmBloc payConfirmBloc;

  setUp(() {
    mockPayConfirmUseCase = MockPayConfirmUseCase();
    payConfirmBloc = PayConfirmBloc(mockPayConfirmUseCase);
  });

  const testScanPayRequestEntity = ScanPayRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
  );
  const testScanPayDataEntity = ScanPayDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  test('initial state should be initial', () {
    expect(payConfirmBloc.state, const PayConfirmInitial());
  });

  group('pay confirm bloc', () {
    blocTest<PayConfirmBloc, PayConfirmState>(
      'should emit [PayConfirmLoading, PayConfirmLoaded] when data is gotten successfully.',
      build: () {
        when(mockPayConfirmUseCase.execute(testScanPayRequestEntity))
            .thenAnswer((_) async => const Right(testScanPayDataEntity));
        return payConfirmBloc;
      },
      act: (bloc) => bloc.add(const PayConfirm(testScanPayRequestEntity)),
      expect: () => [
        const PayConfirmLoading(),
        const PayConfirmLoaded(testScanPayDataEntity),
      ],
    );

    blocTest<PayConfirmBloc, PayConfirmState>(
      'should emit [PayConfirmLoading, PayConfirmLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockPayConfirmUseCase.execute(testScanPayRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure("Server failure.")));
        return payConfirmBloc;
      },
      act: (bloc) => bloc.add(const PayConfirm(testScanPayRequestEntity)),
      expect: () => [
        const PayConfirmLoading(),
        const PayConfirmLoadFailed("Server failure."),
      ],
    );
  });
}
