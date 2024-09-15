import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class FollowerService extends BaseService {
  factory FollowerService() => _instance;
  FollowerService._();
  static final FollowerService _instance = FollowerService._();

  //Get Followers

  Future<void> followUser({
    required String localUserId,
    required String targetUserId,
  }) async {
    await db
        .collection('users')
        .doc(localUserId)
        .collection('following')
        .doc(targetUserId)
        .set({
      'uid': targetUserId,
      'date': Timestamp.now(),
    });
  }

  Future<void> unfollowUser({
    required String localUserId,
    required String targetUserId,
  }) async {
    await db
        .collection('users')
        .doc(localUserId)
        .collection('following')
        .doc(targetUserId)
        .delete();
  }
}
