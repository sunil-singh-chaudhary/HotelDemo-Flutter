import 'package:bloc/bloc.dart';
import 'package:design_demo/userDetailsBloc/user_detail_state.dart';
import 'package:equatable/equatable.dart';

import '../Repositories/UserRepository.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(UserRepository userRepository)
      : _userRepository = userRepository,
        super(UserDetailState.initial());

  final UserRepository _userRepository;

  Future<void> getUser(int userId) async {
    emit(state.copyWith(status: UserDetailStatus.loading));

    try {
      final user = await _userRepository.getUser(userId);

      emit(state.copyWith(
        status: UserDetailStatus.success,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(status: UserDetailStatus.failure));
    }
  }
}
