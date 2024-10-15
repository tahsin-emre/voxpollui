import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class FollowerService extends BaseService {
  factory FollowerService() => _instance;
  FollowerService._();
  static final FollowerService _instance = FollowerService._();

  Future<bool> isFollowing({
    required String localUserId,
    required String targetUserId,
  }) async {
    final response = await db
        .collection(FireStoreCollections.users.name)
        .doc(localUserId)
        .collection(FireStoreCollections.following.name)
        .doc(targetUserId)
        .get();
    if (response.exists) return true;
    return false;
  }

  Future<bool> followUser({
    required String localUserId,
    required String targetUserId,
  }) async {
    try {
      await db
          .collection(FireStoreCollections.users.name)
          .doc(localUserId)
          .collection(FireStoreCollections.following.name)
          .doc(targetUserId)
          .set({'createdAt': Timestamp.now(), 'userId': targetUserId});
      await db
          .collection(FireStoreCollections.users.name)
          .doc(targetUserId)
          .collection(FireStoreCollections.followers.name)
          .doc(localUserId)
          .set({'createdAt': Timestamp.now(), 'userId': localUserId});
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> unfollowUser({
    required String localUserId,
    required String targetUserId,
  }) async {
    try {
      await db
          .collection(FireStoreCollections.users.name)
          .doc(localUserId)
          .collection(FireStoreCollections.following.name)
          .doc(targetUserId)
          .delete();
      await db
          .collection(FireStoreCollections.users.name)
          .doc(targetUserId)
          .collection(FireStoreCollections.followers.name)
          .doc(localUserId)
          .delete();
      return true;
    } on Exception {
      return false;
    }
  }
}
