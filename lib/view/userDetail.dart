import 'package:flutter/material.dart';
import '../models/user.dart';

class userDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: user.avatarUrl.isNotEmpty
                  ? NetworkImage(user.avatarUrl)
                  : null,
              radius: 50,
              child: user.avatarUrl.isEmpty ? Icon(Icons.person, size: 50) : null,
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              user.email,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "${user.age} anos",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
