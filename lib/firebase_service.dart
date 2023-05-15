import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_list/user_model.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addFriend(User user) async {
    try {
      await firestore.collection('friends').add({
        'name': user.name,
        'email': user.email,
        'street': user.street,
        'suite': user.suite,
        'id': user.id,
        'city': user.city,
        'zipcode': user.zipcode,
        'long': user.long,
        'lat': user.lat
      });
    } catch (e) {
      print('Error adding friend: $e');
    }
  }

  Future<void> removeFriend(User user) async {
    try {
      await firestore
          .collection('friends')
          .where('name', isEqualTo: user.name)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print('Error removing friend: $e');
    }
  }
}
