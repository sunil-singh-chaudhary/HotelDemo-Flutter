import 'package:design_demo/Repositories/export_repositories.dart';
import 'package:design_demo/UserBloc/user_state.dart';
import 'package:design_demo/UserBloc/users_cubit.dart';
import 'package:design_demo/models/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepo extends Mock implements UserRepository {}

void main() {
  MockUserRepo userRepo;
  late UsersCubit usersCubit;
  late UserRepository userRepository;
  setUp(() {
    userRepo = MockUserRepo();
    userRepository = MockUserRepo();
    usersCubit = UsersCubit(userRepository);
  });
  tearDown(() async {
    usersCubit.close();
  });
  group('State', () {
    group('stateX', () {
      test('check initial state', () {
        const status = UsersStatus.initial;

        expect(status.isInitial, isTrue);
        expect(status.isLoading, isFalse);
        expect(status.isSuccess, isFalse);
        expect(status.isFailure, isFalse);
      });
    });

    test('check loading state', () {
      const status = UsersStatus.loading;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('check isSuccess state', () {
      const status = UsersStatus.success;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('check failure state', () {
      const status = UsersStatus.failure;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });

    group('', () {
      test('should return the same state when copyWith() have no parameters',
          () {
        final expectState = usersCubit.state;
        final matchState = usersCubit.state.copyWith();

        expect(expectState, equals(matchState));
      });

      test(
          'should return the same state when copywith() have status changed initially',
          () {
        const expected =
            UsersState(status: UsersStatus.initial, users: [User.empty()]);
        // ACT
        final state = usersCubit.state.copyWith(users: [User.empty()]);
        // ASSERT
        expect(state, equals(expected));
      });
    });
    test('should return the same state when copywith() have status changed',
        () {
      const expected = UsersState(status: UsersStatus.loading, users: []);
      // ACT
      final state = usersCubit.state.copyWith(status: UsersStatus.loading);
      // ASSERT
      expect(state, equals(expected));
    });

    test(
        ' should return correct state when all parameters are changed by copyWith',
        () {
      const expected =
          UsersState(status: UsersStatus.success, users: [User.empty()]);
      final result = usersCubit.state
          .copyWith(status: UsersStatus.success, users: [User.empty()]);

      expect(result, equals(expected));
    });
  });
}
