import 'package:design_demo/Repositories/export_repositories.dart';
import 'package:design_demo/exceptions/repository_exception.dart';
import 'package:design_demo/models/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

Future<void> main() async {
  late MockHttpClient client;
  late UserRepository userrep;

  setUp(() {
    // Register a fallback value for Uri for adding any() below
    registerFallbackValue(Uri());

    client = MockHttpClient();
    userrep = UserRepository(client: client);
  });

  group(
    'Get user List and length check',
    () {
      test('fetch data from api ,compare it response items with response 200',
          () async {
        // ARRANGE
        const fakeBody =
            '[{"id":1,"name":"Leanne Graham","username":"Bret","email":"Sincere@april.biz","address":{"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}},"phone":"1-770-736-8031 x56442","website":"hildegard.org","company":{"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}},{"id":2,"name":"Ervin Howell","username":"Antonette","email":"Shanna@melissa.tv","address":{"street":"Victor Plains","suite":"Suite 879","city":"Wisokyburgh","zipcode":"90566-7771","geo":{"lat":"-43.9509","lng":"-34.4618"}},"phone":"010-692-6593 x09125","website":"anastasia.net","company":{"name":"Deckow-Crist","catchPhrase":"Proactive didactic contingency","bs":"synergize scalable supply-chains"}}]';
        final res = Response(fakeBody, 200);

        when(() => client.get(any())).thenAnswer((_) => Future.value(res));

        // ACT
        final result = await userrep.getUsers();

        // Assert that the result is as expected
        expect(result, isA<List<User>>());
        expect(result.length, 2);
      });

      test(
        'should return List<User> even if response is empty list when status code is 200',
        () async {
          // ARRANGE
          const fakeBody = '[]';
          final fakeResponse = Response(fakeBody, 200);

          when(() => client.get(any()))
              .thenAnswer((_) => Future.value(fakeResponse));

          // ACT
          final result = await userrep.getUsers();
          // ASSERT
          expect(result, isA<List<User>>());
        },
      );

      test(
        'should throw a repositorie excception  when status code is 404',
        () async {
          // ARRANGE
          final fakeResponse = Response('[]', 404);

          when(() => client.get(any()))
              .thenAnswer((_) => Future.value(fakeResponse));

          // ACT
          final result = userrep.getUsers();
          //calling original method not mockmethod

          // ASSERT
          expect(result, throwsA(isA<RepositoryStatusCodeException>()));
        },
      );
      test(
        'should throw a repositorie excception when client throw an exception',
        () async {
          // ARRANGE

          when(() => client.get(any())).thenThrow(Exception());

          // ACT
          final result = userrep.getUsers();
          // ASSERT
          expect(result, throwsA(isA<RepositoryException>()));
        },
      );

      test(
        'Should throw an exception , when user is not found',
        () async {
          final fakeresponse = Response('{}', 404);
          when(() => client.get(any()))
              .thenAnswer((realInvocation) => Future.value(fakeresponse));

          final result = userrep.getUser(100);
          expect(result, throwsA(isA<RepositoryStatusCodeException>()));
        },
      );
    },
  );
}
