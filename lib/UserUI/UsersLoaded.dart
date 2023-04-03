import 'package:flutter/material.dart';

import '../models/users.dart';
import 'UserDetailPage.dart';

class UsersLoaded extends StatelessWidget {
  const UsersLoaded({
    super.key,
    required this.users,
    required this.onRefresh,
  });

  final List<User> users;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            key: Key(users[index].name),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserDetailPage(
                    key: Key('detailpage${index}'), userId: user.id),
              ),
            ),
            leading: CircleAvatar(
              child: Text(
                '${user.id}',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.username),
          );
        },
      ),
    );
  }
}
