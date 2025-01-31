
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/service/userService.dart';
import '/userProvider.dart';
import 'package:provider/provider.dart';

import 'bloc/UserBloc.dart';
import 'event/UserEvent.dart';
import 'event/UserState.dart';
import 'models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(LoadUsers());

    return Scaffold(
      appBar: AppBar(title: Text('Select User')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.role),
                  onTap: () {
                    context.read<UserBloc>().add(SelectUser(user));
                    Navigator.pop(context);
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}






