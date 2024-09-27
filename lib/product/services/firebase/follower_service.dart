import 'package:voxpollui/product/services/firebase/base_service.dart';
import 'package:voxpollui/product/services/http/http_endpoints.dart';
import 'package:voxpollui/product/services/http/http_service.dart';

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
    final response = await HttpService().sendRequest(
      HttpEndpoints.followuser,
      {'userId': targetUserId, 'followerId': localUserId},
    );
    if (response.body == 'true') return true;
    return false;
  }

  Future<bool> unfollowUser({
    required String localUserId,
    required String targetUserId,
  }) async {
    final response = await HttpService().sendRequest(
      HttpEndpoints.unfollowuser,
      {'userId': targetUserId, 'followerId': localUserId},
    );
    if (response.body == 'true') return true;
    return false;
  }
}
