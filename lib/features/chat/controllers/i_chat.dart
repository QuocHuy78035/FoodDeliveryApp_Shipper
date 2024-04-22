
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IChat{
  Future<void> sendMessage(String receiverId, String message);
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId);
}