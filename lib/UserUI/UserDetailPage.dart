import 'package:design_demo/UserUI/user_detail_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Repositories/UserRepository.dart';
import '../userDetailsBloc/User_detail_cubit.dart';
import '../userDetailsBloc/user_detail_state.dart';
import 'UserDetailLoaded.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDetailCubit(context.read<UserRepository>())..getUser(userId),
      child: const UserDetailView(),
    );
  }
}

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Center(
        child: BlocBuilder<UserDetailCubit, UserDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case UserDetailStatus.initial:
                return const Text('empty initial');
              case UserDetailStatus.loading:
                return const CircularProgressIndicator();
              case UserDetailStatus.success:
                return UserDetailLoaded(user: state.user);
              case UserDetailStatus.failure:
                return const UserDetailError();
            }
          },
        ),
      ),
    );
  }
}
