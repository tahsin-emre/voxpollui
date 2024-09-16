import 'package:voxpollui/product/services/firebase/base_service.dart';

final class FollowerService extends BaseService {
  factory FollowerService() => _instance;
  FollowerService._();
  static final FollowerService _instance = FollowerService._();

  //Get Followers

  Future<void> followUser({
    required String localUserId,
    required String targetUserId,
  }) async {}

  Future<void> unfollowUser({
    required String localUserId,
    required String targetUserId,
  }) async {}
}
