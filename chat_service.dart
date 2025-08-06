import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // <-- add this import

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    final currentUser = _auth.currentUser;
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.id != currentUser?.uid)
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _auth.currentUser;
    final blockedUsersStream = _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toSet());

    return blockedUsersStream.asyncMap((blockedUserIds) async {
      final allUsersSnapshot = await _firestore.collection('users').get();

      final filteredUsers = allUsersSnapshot.docs
          .where(
            (doc) =>
        doc.id != currentUser.uid && !blockedUserIds.contains(doc.id),
      )
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return filteredUsers;
    });
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in');
    }
    final String senderID = currentUser.uid;
    final String senderEmail = currentUser.email ?? "No Email";
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [senderID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add({
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    final report = {
      'reportedBy': currentUser.uid,
      'reportedUserId': userId,
      'messageId': messageId,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('Reports').add(report);
  }

  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(
        blockUserIds.map(
              (id) => _firestore.collection('users').doc(id).get(),
        ),
      );

      return userDocs
          .where((doc) => doc.exists)
          .map((doc) => doc.data()! as Map<String, dynamic>)
          .toList();
    });
  }
}
