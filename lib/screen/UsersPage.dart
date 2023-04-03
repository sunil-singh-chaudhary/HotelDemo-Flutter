import 'package:design_demo/UserUI/ErrorView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Repositories/UserRepository.dart';
import '../UserBloc/user_state.dart';
import '../UserBloc/users_cubit.dart';
import '../UserUI/UsersLoaded.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (context) =>
              UsersCubit(context.read<UserRepository>())..getUsers(),
        )
      ],
      child: const UsersView(),
    );
  }
}

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            switch (state.status) {
              case UsersStatus.initial:
                return const Text(key: Key('init'), 'INITIAL STATE');
              case UsersStatus.loading:
                return const CircularProgressIndicator(
                    key: Key('loadingCircle'));
              case UsersStatus.success:
                return UsersLoaded(
                  users: state.users,
                  onRefresh: context.read<UsersCubit>().refreshUsers,
                );
              case UsersStatus.failure:
                return const ErrorView();
            }
          },
        ),
      ),
    );
  }
}
