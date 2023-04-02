import 'package:bloc_test/bloc_test.dart';
import 'package:design_demo/Repositories/UserRepository.dart';
import 'package:design_demo/UserBloc/user_state.dart';
import 'package:design_demo/UserBloc/users_cubit.dart';
import 'package:design_demo/models/address.dart';
import 'package:design_demo/models/company.dart';
import 'package:design_demo/models/geo.dart';
import 'package:design_demo/models/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_cubit_test.mocks.dart';

class UserRepo extends Mock implements UserRepository {}

class Users extends Mock implements User {}

@GenerateMocks([UserRepo, Users])
void main() {
  const userid = 1;
  const username = 'Leanne Graham';
  const userusername = 'Bret';
  const useremail = 'Sincere@april.biz';
  const useraddress = Address(
      street: 'Kulas Light',
      suite: 'Apt. 556',
      city: 'Gwenborough',
      zipcode: '92998-3874',
      geo: Geo(lat: '-37.3159', lng: '81.1496'));
  const userphone = '1-770-736-8031 x56442';
  const userwebsite = 'hildegard.org';
  const usercompany = Company(
    name: 'Romaguera-Crona',
    catchPhrase: 'Multi-layered client-server neural-net',
    bs: 'harness real-time e-markets',
  );
  late List<MockUsers> users;
  late MockUserRepo userrepo;
  group('Cubit start', () {
    setUpAll(() {
      users = [
        MockUsers(),
        MockUsers()
      ]; //we have to check first from user so add it to list to easily get values
      //we can use users=MockUsers() and get it like users.id but below we have gettin in our original code
      //the value in list<Users> thats why we are using this
      userrepo = MockUserRepo();

      when(users.first.id).thenReturn(
        userid,
      );
      when(users.first.name).thenReturn(
        username,
      );
      when(users.first.username).thenReturn(
        userusername,
      );
      when(users.first.email).thenReturn(
        useremail,
      );
      when(users.first.address).thenReturn(
        useraddress,
      );
      when(users.first.phone).thenReturn(
        userphone,
      );
      when(users.first.website).thenReturn(
        userwebsite,
      );
      when(users.first.company).thenReturn(
        usercompany,
      );
      when(userrepo.getUsers())
          .thenAnswer((realInvocation) => Future.value(users));
    });
    test(
      'initial state is correct',
      () {
        // ARRANGE
        final usersCubit = UsersCubit(userrepo);
        // ASSERT
        expect(usersCubit.state, UsersState.initial());
      },
    );

    group(
      'Get User',
      () {
        blocTest<UsersCubit, UsersState>(
          'emits [loading, failure] when exception is thrown',
          setUp: () {
            when(userrepo.getUsers()).thenThrow(Exception());
          },
          build: () => UsersCubit(userrepo),
          act: (cubit) => cubit.getUsers(),
          expect: () => <UsersState>[
            const UsersState(status: UsersStatus.loading, users: []),
            const UsersState(status: UsersStatus.failure, users: []),
          ],
        );

        blocTest<UsersCubit, UsersState>(
          'emits [loading, success] when getUsers returns users',
          setUp: () {
            when(userrepo.getUsers())
                .thenAnswer((realInvocation) => Future.value(users));
          },
          build: () => UsersCubit(userrepo),
          act: (cubit) => cubit.getUsers(),
          expect: () => [
            const UsersState(status: UsersStatus.loading, users: []),
            isA<UsersState>()
                .having((u) => u.status, 'chck status', UsersStatus.success)
                .having(
                    (u) => u.users,
                    'get users',
                    isA<List<User>>()
                        .having((u) => u, 'match both list', users)
                        .having(
                            (u) => u.first,
                            'get list first user',
                            isA<User>()
                                .having((u) => u.id, 'compare onebyone', userid)
                                .having(
                                    (u) => u.name, 'compare onebyone', username)
                                .having((u) => u.username, 'compare onebyone',
                                    userusername)
                                .having((u) => u.email, 'compare onebyone',
                                    useremail)
                                .having((u) => u.phone, 'compare onebyone',
                                    userphone)
                                .having((u) => u.address, 'compare onebyone',
                                    useraddress)
                                .having((u) => u.company, 'compare onebyone',
                                    usercompany)
                                .having((u) => u.website, 'compare onebyone',
                                    userwebsite))),
          ],
        );

        blocTest(
          'emits nothing when status is not success',
          build: () => UsersCubit(userrepo),
          act: (cubit) => cubit.refreshUsers(),
          expect: () => [],
        );
        blocTest(
          'emits nothing when users is empty',
          seed: () => const UsersState(status: UsersStatus.success, users: []),
          //initialize for comparision
          build: () => UsersCubit(userrepo),
          act: (cubit) => cubit.refreshUsers(),
          expect: () => [],
        );
        blocTest(
          'emits [failure] when exception is thrown',
          setUp: () {
            when(userrepo.getUsers()).thenThrow(Exception('oops'));
          },
          seed: () => UsersState(status: UsersStatus.success, users: users),
          //initialize for comparision
          build: () => UsersCubit(userrepo),
          act: (cubit) => cubit.refreshUsers(),
          //it after call getuser() in his method thatswhy
          expect: () => [
            UsersState(status: UsersStatus.failure, users: users),
          ],
        );
        //gettign error when both comparision on expect

        // blocTest<UsersCubit, UsersState>(
        //   'emits [success] when it is updated',
        //   setUp: () {
        //     when(userrepo.getUsers()).thenAnswer((realInvocation) =>
        //         Future.value(const [User.empty(), User.empty(), User.empty()]));
        //   },

        //   build: () => UsersCubit(userrepo),
        //   seed: () => const UsersState(
        //       status: UsersStatus.success,
        //       users: [User.empty(), User.empty()]), // two data init
        //   act: (cubit) => cubit.refreshUsers(),
        //   //if  id do getuser() then this method start from loading
        //   //which is not ok we have to start with succes and that start succes work on refresh
        //   expect: () => const UsersState(status: UsersStatus.success, users: [
        //     User.empty(),
        //     User.empty(),
        //     User.empty(),
        //   ]),
        // );
      },
    );
  });
}
