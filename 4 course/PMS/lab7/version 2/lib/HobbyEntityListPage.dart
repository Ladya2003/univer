import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'HobbyEntityDetailPage.dart';
import 'EditEntityPage.dart';
import 'FileOperationsPage.dart';
import 'model/Entities.dart';

class HobbyEntityListPage extends StatefulWidget {
  @override
  _HobbyEntityListPageState createState() => _HobbyEntityListPageState();
}

class _HobbyEntityListPageState extends State<HobbyEntityListPage> {
  late Future<List<HobbyEntity>> hobbyEntityList;

  @override
  void initState() {
    super.initState();
    _loadHobbyEntityList();
  }

  void _loadHobbyEntityList() {
    hobbyEntityList = DatabaseHelper.instance.readAllEntities();
  }

  void _refreshHobbyEntityList() {
    setState(() {
      _loadHobbyEntityList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hobby Entities'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder<List<HobbyEntity>>(
                    future: hobbyEntityList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return FileOperationsPage(entityList: snapshot.data!);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<HobbyEntity>>(
        future: hobbyEntityList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final entity = snapshot.data![index];
              return ListTile(
                title: Text(entity.name),
                subtitle: Text(entity.description),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HobbyEntityDetailPage(
                      entity: entity,
                      onUpdate: _refreshHobbyEntityList,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditEntityPage(),
            ),
          ).then((_) {
            _refreshHobbyEntityList();
          });
        },
        child: Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
