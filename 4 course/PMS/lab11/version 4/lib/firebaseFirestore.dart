import 'package:cloud_firestore/cloud_firestore.dart';



class FirestoreService {
  final CollectionReference productsCollection =
  FirebaseFirestore.instance.collection('products');

  Future<void> createProduct(Map<String, dynamic> productData) {
    return productsCollection.add(productData);
  }

  Stream<QuerySnapshot> readProducts() {
    return productsCollection.snapshots();
  }

  Future<void> updateProduct(String id, Map<String, dynamic> productData) {
    return productsCollection.doc(id).update(productData);
  }

  Future<void> deleteProduct(String id) {
    return productsCollection.doc(id).delete();
  }

  Future<void> createOrder(Map<String, dynamic> orderData) {
    return FirebaseFirestore.instance.collection('orders').add(orderData);
  }

  Future<void> toggleFavorite({required String productId, required String userId}) async {
    final docRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc('$userId\_$productId');

    final doc = await docRef.get();
    if (doc.exists) {
      docRef.delete();
    } else {
      docRef.set({
        'userId': userId,
        'productId': productId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<QuerySnapshot> getFavorites(String userId) {
    return FirebaseFirestore.instance
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}