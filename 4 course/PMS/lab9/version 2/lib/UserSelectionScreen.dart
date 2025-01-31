import 'package:flutter/material.dart';
import '/service/userService.dart';
import '/user_provider.dart';
import 'package:provider/provider.dart';
import '/models/user.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Select User')),
      body: FutureBuilder<List<User>>(
        future: userProvider.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading users'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.role),
                  onTap: () async {
                    // Call changeUser asynchronously, but no need to use its result
                    await userProvider.changeUser(user);
                    Navigator.pop(context);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
