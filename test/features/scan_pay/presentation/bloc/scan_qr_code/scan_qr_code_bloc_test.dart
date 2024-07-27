import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockScanQrCodeUseCase mockScanQrCodeUseCase;
  late ScanQrCodeBloc scanQrCodeBloc;

  setUp(() {
    mockScanQrCodeUseCase = MockScanQrCodeUseCase();
    scanQrCodeBloc = ScanQrCodeBloc(mockScanQrCodeUseCase);
  });

  const toPhone = '09968548025';
  const testScanPayFormDataEntity = ScanPayFormDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: toPhone,
  );

  test('initial state should be initial', () {
    expect(scanQrCodeBloc.state, const ScanQrCodeInitial());
  });

  group('scan qr code bloc', () {
    blocTest<ScanQrCodeBloc, ScanQrCodeState>(
      'should emit [ScanQrCodeLoading, ScanQrCodeLoaded] when data is gotten successfully.',
      build: () {
        when(mockScanQrCodeUseCase.execute(toPhone))
            .thenAnswer((_) async => const Right(testScanPayFormDataEntity));
        return scanQrCodeBloc;
      },
      act: (bloc) => bloc.add(const ScanQrCode(toPhone)),
      expect: () => [
        const ScanQrCodeLoading(),
        const ScanQrCodeLoaded(testScanPayFormDataEntity),
      ],
    );

    blocTest<ScanQrCodeBloc, ScanQrCodeState>(
      'should emit [ScanQrCodeLoading, ScanQrCodeLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockScanQrCodeUseCase.execute(toPhone)).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return scanQrCodeBloc;
      },
      act: (bloc) => bloc.add(const ScanQrCode(toPhone)),
      expect: () => [
        const ScanQrCodeLoading(),
        const ScanQrCodeLoadFailed("Server failure."),
      ],
    );
  });
}
