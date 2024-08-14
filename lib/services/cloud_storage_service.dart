import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  late FirebaseStorage _storage;
  late Reference _baseRef;

  String _profileImages = 'Profile_images';

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot> uploadUserImage(String userId, File _image) async {
    try {
      return await _baseRef.child(_profileImages).child(userId).putFile(_image);
    } catch (e) {
      print(e);
    }
  }
}
