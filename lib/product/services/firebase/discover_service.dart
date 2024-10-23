import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class DiscoverService extends BaseService {
  factory DiscoverService() => _instance;
  DiscoverService._();
  static final DiscoverService _instance = DiscoverService._();

  Future<List<UserModel>> getUsers(String keyword) async {
    try {
      final responseName = await db
          .collection(FireStoreCollections.users.name)
          .where(FireStoreFields.name.name, isGreaterThanOrEqualTo: keyword)
          .where(FireStoreFields.name.name, isLessThan: '${keyword}z')
          .limit(5)
          .get();
      final responseUsername = await db
          .collection(FireStoreCollections.users.name)
          .where(
            FireStoreFields.userName.name,
            isGreaterThanOrEqualTo: keyword.toLowerCase(),
          )
          .where(FireStoreFields.userName.name, isLessThan: '${keyword}z')
          .limit(5)
          .get();
      final snapshots = {...responseName.docs, ...responseUsername.docs};
      return snapshots.map((e) => UserModel.fromJson(e.data(), e.id)).toList();
    } on Exception {
      return [];
    }
  }

  Future<List<CommunityModel>> getCommunities(String keyword) async {
    try {
      final responseName = await db
          .collection(FireStoreCollections.communities.name)
          .where(FireStoreFields.name.name, isGreaterThanOrEqualTo: keyword)
          .where(FireStoreFields.name.name, isLessThan: '${keyword}z')
          .limit(5)
          .get();
      final responseUsername = await db
          .collection(FireStoreCollections.communities.name)
          .where(
            FireStoreFields.userName.name,
            isGreaterThanOrEqualTo: keyword.toLowerCase(),
          )
          .where(FireStoreFields.userName.name, isLessThan: '${keyword}z')
          .limit(5)
          .get();
      final snapshots = {...responseName.docs, ...responseUsername.docs};
      return snapshots
          .map((e) => CommunityModel.fromJson(e.data(), e.id))
          .toList();
    } on Exception {
      return [];
    }
  }

  Future<List<PollModel>> getPolls(String keyword) async {
    try {
      final response = await db
          .collection(FireStoreCollections.polls.name)
          .where(FireStoreFields.title.name, isGreaterThanOrEqualTo: keyword)
          .where(FireStoreFields.title.name, isLessThan: '${keyword}z')
          .limit(5)
          .get();
      return response.docs
          .map((e) => PollModel.fromJson(e.data(), e.id))
          .toList();
    } on Exception {
      return [];
    }
  }
}
