import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockUpdatePasswordUseCase mockUpdatePasswordUseCase;
  late UpdatePasswordBloc updatePasswordBloc;

  setUp(() {
    mockUpdatePasswordUseCase = MockUpdatePasswordUseCase();
    updatePasswordBloc = UpdatePasswordBloc(mockUpdatePasswordUseCase);
  });

  const oldPassword = 'password-old';
  const newPassword = 'password-new';

  test('initial state should be initial', () {
    expect(updatePasswordBloc.state, UpdatePasswordInitial());
  });

  group('update password', () {
    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'should emit [UpdatePasswordLoaded] when data is gotten successfully.',
      build: () {
        when(mockUpdatePasswordUseCase.execute(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenAnswer((_) async => const Right(null));
        return updatePasswordBloc;
      },
      act: (bloc) => bloc.add(const UpdatePassword(
          oldPassword: oldPassword, newPassword: newPassword)),
      expect: () => [
        UpdatePasswordLoaded(),
      ],
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'should emit [UpdatePasswordLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(
          mockUpdatePasswordUseCase.execute(
            oldPassword: oldPassword,
            newPassword: newPassword,
          ),
        ).thenAnswer((_) async => const Left(ServerFailure("Server failure.")));
        return updatePasswordBloc;
      },
      act: (bloc) => bloc.add(const UpdatePassword(
          oldPassword: oldPassword, newPassword: newPassword)),
      expect: () => [
        const UpdatePasswordLoadFailed("Server failure."),
      ],
    );
  });
}
