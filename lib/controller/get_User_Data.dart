import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String Uid) async {
    final QuerySnapshot<Object?> userData = await firebaseFirestore
        .collection('users')
        .where('uId', isEqualTo: Uid)
        .get(); 

    return userData.docs;
  }
}