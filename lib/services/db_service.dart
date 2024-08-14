import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static DBService instance = DBService();

  late FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  String _userCollection = 'Users';

  Future<void> createUserInDb(
    String _userId,
    String _name,
    String _email,
  ) async {
    try {
      return await _db.collection(_userCollection).doc(_userId).set({
        'name': _name,
        'email': _email,
        'lastSeen': DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }
}
