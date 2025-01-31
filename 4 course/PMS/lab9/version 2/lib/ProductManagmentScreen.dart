
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/service/productService.dart';
import '/service/userService.dart';

import 'models/product.dart';

class ProductManagementScreen extends StatefulWidget {
  @override
  _ProductManagementScreenState createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final ProductService productService = ProductService();
  final UserService userService = UserService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = productService.getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = userService.getCurrentUser();
    return Scaffold(
      appBar: AppBar(title: Text('Product Management')),
      body: Column(
        children: [
          if (currentUser?.isAdminOrManager ?? false)
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductEditScreen(productService: productService),
                  ),
                );
                if (result == true) {
                  _loadProducts(); // Reload products when returning from ProductEditScreen
                }
              },
              child: Text('Add Product'),
            ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      trailing: currentUser?.isAdminOrManager ?? false
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductEditScreen(
                                    product: product,
                                    index: index,
                                    productService: productService,
                                  ),
                                ),
                              );
                              if (result == true) {
                                _loadProducts(); // Reload products after editing
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await productService.deleteProduct(index);
                              _loadProducts(); // Reload products after deletion
                            },
                          ),
                        ],
                      )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class ProductEditScreen extends StatelessWidget {
  final ProductService productService;
  final Product? product;
  final int? index;

  ProductEditScreen({this.product, this.index, required this.productService});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (product != null) {
      nameController.text = product!.name;
      descriptionController.text = product!.description;
      priceController.text = product!.price.toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(product != null ? 'Edit Product' : 'Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () async {
                final newProduct = Product(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                  imageUrl: 'assets/images/puma1.png',
                );
                if (product != null && index != null) {
                  await productService.updateProduct(index!, newProduct);
                } else {
                  await productService.addProduct(newProduct);
                }
                Navigator.pop(context, true); // Return true to indicate that products should be reloaded
              },
              child: Text(product != null ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
