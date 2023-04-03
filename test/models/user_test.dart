import 'package:design_demo/models/address.dart';
import 'package:design_demo/models/company.dart';
import 'package:design_demo/models/geo.dart';
import 'package:design_demo/models/users.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late User user;

  setUp(() {
    user = const User(
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
    );
  });

  group('USer', () {
    group(
      'Check Empty User',
      () {
        test('empty user', () {
          //ARRANGE
          const expected = User(
              id: 0,
              name: '',
              username: '',
              email: '',
              address: Address.empty(),
              phone: '',
              website: '',
              company: Company.empty());
          //ACT
          const result = User.empty();

          //ASSERT
          expect(result, equals(expected));
        });
      },
    );

    group('fromJson', () {
      test('should return a valid User Object', () {
        // ARRANGE
        const json = {
          'id': 1,
          'name': 'Leanne Graham',
          'username': 'Bret',
          'email': 'Sincere@april.biz',
          'address': {
            'street': 'Kulas Light',
            'suite': 'Apt. 556',
            'city': 'Gwenborough',
            'zipcode': '92998-3874',
            'geo': {'lat': '-37.3159', 'lng': '81.1496'}
          },
          'phone': '1-770-736-8031 x56442',
          'website': 'hildegard.org',
          'company': {
            'name': 'Romaguera-Crona',
            'catchPhrase': 'Multi-layered client-server neural-net',
            'bs': 'harness real-time e-markets',
          }
        };
        final newUser = User.fromJson(json);
        expect(newUser, isA<User>());
        expect(newUser, equals(user));
      });
    });

    group('to json', () {
      test('should be valid map', () {
        final expectedMap = {
          'id': 1,
          'name': 'Leanne Graham',
          'username': 'Bret',
          'email': 'Sincere@april.biz',
          'address': {
            'street': 'Kulas Light',
            'suite': 'Apt. 556',
            'city': 'Gwenborough',
            'zipcode': '92998-3874',
            'geo': {'lat': '-37.3159', 'lng': '81.1496'}
          },
          'phone': '1-770-736-8031 x56442',
          'website': 'hildegard.org',
          'company': {
            'name': 'Romaguera-Crona',
            'catchPhrase': 'Multi-layered client-server neural-net',
            'bs': 'harness real-time e-markets',
          }
        };
        final tomap = user.toJson();
        expect(tomap, isA<Map>());
        expect(tomap, equals(expectedMap));
      });
    });

    group('copyWith', () {
      test(
          'should return a same object if copyWith is called without parameters',
          () {
        final expected = user;
        // ACT
        final newUser = user.copyWith();
        // ASSERT
        expect(newUser, equals(expected));
      });
      test(
        'should return correct object when only id is changed by copyWith',
        () {
          // ARRANGE
          const expected = User(
            id: 2,
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
          );
          // ACT
          final newUser = user.copyWith(id: 2);
          // ASSERT
          expect(newUser, equals(expected));
        },
      );
    });
  });
}
