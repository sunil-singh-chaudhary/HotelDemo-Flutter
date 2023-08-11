import 'package:bloc_test/bloc_test.dart';
import 'package:design_demo/App.dart';
import 'package:design_demo/Repositories/UserRepository.dart';
import 'package:design_demo/UserBloc/user_state.dart';
import 'package:design_demo/UserBloc/users_cubit.dart';
import 'package:design_demo/UserUI/ErrorView.dart';
import 'package:design_demo/UserUI/UserDetailPage.dart';
import 'package:design_demo/UserUI/UsersLoaded.dart';
import 'package:design_demo/models/address.dart';
import 'package:design_demo/models/company.dart';
import 'package:design_demo/models/geo.dart';
import 'package:design_demo/models/users.dart';
import 'package:design_demo/screen/UsersPage.dart';
import 'package:design_demo/userDetailsBloc/User_detail_cubit.dart';
import 'package:design_demo/userDetailsBloc/user_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserCubit extends MockCubit<UsersState> implements UsersCubit {}

class MockUserDetailCubit extends MockCubit<UserDetailState>
    implements UserDetailCubit {}

void main() {
  late MockUserRepository userRepository;
  late MockUserCubit usersCubit;
  setUpAll(() {
    userRepository = MockUserRepository();
    usersCubit = MockUserCubit();
  });
  tearDown(
    () async {
      await usersCubit.close();
    },
  );

  group('bloc test', () {
    testWidgets(
      'renders UsersEmpty when status is UsersStatus.initial',
      (tester) async {
        when(() => usersCubit.state).thenReturn(UsersState.initial());

        await tester.pumpWidget(
          RepositoryProvider.value(
            value: userRepository,
            child: const MaterialApp(
              home: MyApp(),
            ),
          ),
        );
        expect(find.byType(MyApp), findsOneWidget);
      },
    );
    testWidgets(
      'renders Userview First',
      (tester) async {
        when(() => usersCubit.state).thenReturn(UsersState.initial());

        await tester.pumpWidget(
          BlocProvider<UsersCubit>.value(
            //the thing is BlockProvider have UserCubit bloc <type> important and see below too comment
            value: usersCubit,
            child: const MaterialApp(
              home: UsersView(),
            ),
          ),
        );
        expect(find.byType(UsersView), findsOneWidget);
      },
    );
  });

  group('USerView', () {
    const users = <User>[
      User(
        id: 1,
        name: "Leanne Graham",
        username: "Bret",
        email: "Sincere@april.biz",
        address: Address(
          street: 'Kulas Light',
          suite: 'Apt. 556',
          city: 'Gwenborough',
          zipcode: '92998-3874',
          geo: Geo(lat: '-37.3159', lng: '81.1496'),
        ),
        phone: "1-770-736-8031 x56442",
        website: "hildegard.org",
        company: Company(
          name: 'Romaguera-Crona',
          catchPhrase: 'Multi-layered client-server neural-net',
          bs: 'harness real-time e-markets',
        ),
      ),
      User(
        id: 2,
        name: "Ervin Howell",
        username: "Antonette",
        email: "Shanna@melissa.tv",
        address: Address(
          street: 'Victor Plains',
          suite: 'Suite 879',
          city: 'Wisokyburgh',
          zipcode: '90566-7771',
          geo: Geo(lat: '-43.9509', lng: '-34.4618'),
        ),
        phone: "010-692-6593 x09125",
        website: "anastasia.net",
        company: Company(
          name: 'Deckow-Crist',
          catchPhrase: 'Proactive didactic contingency',
          bs: 'synergize scalable supply-chains',
        ),
      )
    ];

    late UsersCubit usersCubit;
    late MockUserDetailCubit userDetailCubit;

    setUpAll(() {
      usersCubit = MockUserCubit();
      userDetailCubit = MockUserDetailCubit();
    });

    tearDown(() async {
      await usersCubit.close();
    });

    testWidgets(
      'UsersView when data initial refresh failed loading',
      (tester) async {
        when(() => usersCubit.state).thenReturn(UsersState.initial());

        await tester.pumpWidget(
          BlocProvider<UsersCubit>.value(
            //the thing is BlockProvider have UserCubit bloc type important and see below too comment
            value: usersCubit,
            child: const MaterialApp(
              home: UsersView(),
            ),
          ),
        );
        expect(find.byKey(const Key('init')), findsOneWidget);
      },
    );
    testWidgets(
      'UsersView when data  Loading ',
      (tester) async {
        when(() => usersCubit.state).thenReturn(
            const UsersState(users: [], status: UsersStatus.loading));

        await tester.pumpWidget(
          BlocProvider<UsersCubit>.value(
            //the thing is BlockProvider have UserCubit bloc type important and see below too comment
            value: usersCubit,
            child: const MaterialApp(
              home: UsersView(),
            ),
          ),
        );
        expect(find.byKey(const Key('loadingCircle')), findsOneWidget);
      },
    );
    testWidgets(
      'UsersView when data  Success ',
      (tester) async {
        when(() => usersCubit.state).thenReturn(
            const UsersState(users: users, status: UsersStatus.success));

        await tester.pumpWidget(
          BlocProvider<UsersCubit>.value(
            //the thing is BlockProvider have UserCubit bloc type important and see below too comment
            value: usersCubit,
            child: const MaterialApp(
              home: UsersView(),
            ),
          ),
        );
        expect(find.byType(UsersLoaded), findsOneWidget);
      },
    );
    testWidgets(
      'UsersView when data  failure ',
      (tester) async {
        when(() => usersCubit.state).thenReturn(
            const UsersState(users: [], status: UsersStatus.failure));

        await tester.pumpWidget(
          BlocProvider<UsersCubit>.value(
            //the thing is BlockProvider have UserCubit bloc type important and see below too comment
            value: usersCubit,
            child: const MaterialApp(
              home: UsersView(),
            ),
          ),
        );
        expect(find.byType(ErrorView), findsOneWidget);
      },
    );

    testWidgets('TAP ON DETAIL LIST ITEM', (tester) async {
      final MockUserRepository repository = MockUserRepository();

      when(() => repository.getUser(any()))
          .thenAnswer((_) async => const User.empty()); // not needed

      when(() => usersCubit.state).thenReturn(
        const UsersState(status: UsersStatus.success, users: users),
      );
      when(() => userDetailCubit.state).thenReturn(
        const UserDetailState(
            status: UserDetailStatus.initial, user: User.empty()),
      );

      await tester.pumpWidget(
        RepositoryProvider.value(
          value: repository,
          child: BlocProvider<UsersCubit>.value(
            value: usersCubit,
            child: const MaterialApp(
              home: Scaffold(
                body: UsersView(),
              ),
            ),
          ),
        ),
      );
      // expect(find.byType(UsersLoaded), findsOneWidget);

      await tester.tap(find.byKey(Key(users[0].name)));
      //listkey can be different for every child

      await tester.pumpWidget(
        //added this is because the file have this Provider again
        RepositoryProvider.value(
          value: repository,
          child: BlocProvider<UserDetailCubit>.value(
            value: userDetailCubit,
            child: const MaterialApp(
              home: Scaffold(
                body: UserDetailView(),
              ),
            ),
          ),
        ),
      );
      try {
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
      } catch (error) {
        debugPrint('error is---> $error');
      }

      expect(find.byType(UserDetailView),
          findsOneWidget); //not delatlpage but detailview below repo
    });

    testWidgets('triggers refreshUsers on pull to refresh',
        (widgetTester) async {
      when(() => usersCubit.state).thenReturn(const UsersState(
          status: UsersStatus.success, users: users)); //no need check
      when(() => usersCubit.refreshUsers()).thenAnswer(
        (invocation) {
          return Future.value(User.empty());
        },
      );

      await widgetTester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: usersCubit,
            child: const UsersView(),
          ),
        ),
      );
      await widgetTester.fling(
          find.byType(UsersLoaded), const Offset(0, 500), 1000);

      await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

      verify(() => usersCubit.refreshUsers()).called(1);
    });
  });
}

// await tester.pumpWidget(
//         MaterialApp(
//           home: MultiBlocProvider(
//             //always us multiblocprover if use blocprovider not working
//             providers: [BlocProvider<UsersCubit>.value(value: usersCubit)],
//             child: const UsersView(),
//           ),
//         ),
//       );
