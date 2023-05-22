import 'package:flutter/material.dart';
import 'package:flutter_project/components/user_tile.dart';
import 'package:flutter_project/routers/app_routers.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/users.dart';

class userList extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final Users users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
            onPressed: () {
            Navigator.of(context).pushNamed(
              AppRouters.USER_FORM);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) =>
            UserTile(users.byIndex(i)),
      ),
    );
  }
}