import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '/HomeScreen/presentation/CategoryBlock.dart';
import '/UserSelectionScreen.dart';
import '/service/favoriteService.dart';
import '/service/userService.dart';
import 'HomeScreen/presentation/BottomSheet.dart';

import 'models/favoriteItem.dart';
import 'models/product.dart';
import 'models/user.dart';
import '/favorites_provider.dart';
import '/user_provider.dart';
import 'favoriteScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(FavoriteItemAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox<Product>('products');
  await Hive.openBox<FavoriteItem>('favorites');
  await Hive.openBox<int>('current_user');

  await initializeData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(UserService())),
        ChangeNotifierProvider(create: (_) => FavoritesProvider(FavoriteService())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    if (!userProvider.isInitialized) {
      userProvider.loadCurrentUser();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              favoritesProvider.loadFavorites(userProvider.currentUser?.id);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserSelectionScreen()),
            ),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.currentUser != null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Center(child: Text('Welcome, ${userProvider.currentUser!.name}')),
                  SizedBox(height: 15.0),
                  CategoryBlock(),
                  SizedBox(height: 20.0),
                  Expanded(child: BottomSheetBlock()),
                ],
              ),
            );
          }
          return Center(child: Text("Please select a user"));
        },
      ),
    );
  }
}

Future<void> initializeData() async {
  final userBox = Hive.box<User>('users');
  final productBox = Hive.box<Product>('products');
  final favoriteBox = Hive.box<FavoriteItem>('favorites');
  final currentUserBox = Hive.box<int>('current_user');

  if (userBox.isEmpty) {
    userBox.addAll([
      User(id: 1, name: 'Admin User', role: 'admin'),
      User(id: 2, name: 'Manager User', role: 'manager'),
      User(id: 3, name: 'Regular User', role: 'user'),
    ]);
  }

  if (productBox.isEmpty) {
    productBox.addAll([
      Product(name: 'Product 1', description: 'Description for Product 1', price: 99.99, imageUrl: 'assets/images/puma1.png'),
      Product(name: 'Product 2', description: 'Description for Product 2', price: 149.99, imageUrl: 'assets/images/puma2.png'),
      Product(name: 'Product 3', description: 'Description for Product 3', price: 199.99, imageUrl: 'assets/images/puma3.png'),
    ]);
  }

  if (currentUserBox.isEmpty) {
    final defaultUser = userBox.values.firstWhere((user) => user.role == 'user');
    await currentUserBox.put('currentUserId', defaultUser.id);
  }

  if (favoriteBox.isEmpty) {
    favoriteBox.add(FavoriteItem(userId: 1, productId: 1));
  }
}
