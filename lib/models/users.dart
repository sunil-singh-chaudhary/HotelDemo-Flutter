import 'package:equatable/equatable.dart';

import 'address.dart';
import 'company.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });
  // User empty({
  //   int? id,
  //   String? name,
  //   String? username,
  //   String? email,
  //   Address? address,
  //   String? phone,
  //   String? website,
  //   Company? company,
  // }) =>
  //     const User(
  //       id: 0,
  //       name: '',
  //       username: '',
  //       email: '',
  //       address: Address.empty(),
  //       phone: '',
  //       website: '',
  //       company: Company.empty(),
  //     );
  const User.empty()
      : id = 0,
        name = '',
        username = '',
        email = '',
        address = const Address.empty(),
        phone = '',
        website = '',
        company = const Company.empty();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        address: Address.fromJson(json['address']),
        phone: json['phone'],
        website: json['website'],
        company: Company.fromJson(json['company']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson()
      };

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      username,
      email,
      address,
      phone,
      website,
      company,
    ];
  }
}
