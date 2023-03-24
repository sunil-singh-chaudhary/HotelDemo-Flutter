import 'package:design_demo/UserBloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repositories/UserRepository.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.userRepository) : super(UsersState.initial());

  final UserRepository userRepository;

  Future<void> getUsers() async {
    emit(state.copyWith(status: UsersStatus.loading));

    await _getUsers();
  }

  Future<void> refreshUsers() async {
    if (!state.status.isSuccess || state.users.isEmpty) {
      return;
    }

    await _getUsers();
  }

  Future<void> _getUsers() async {
    try {
      final users = await userRepository.getUsers();

      emit(state.copyWith(
        status: UsersStatus.success,
        users: users,
      ));
    } on Exception {
      emit(state.copyWith(status: UsersStatus.failure));
    }
  }
}
