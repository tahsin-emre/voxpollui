import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class CommunityService extends BaseService {
  factory CommunityService() => _instance;
  CommunityService._();
  static final CommunityService _instance = CommunityService._();

  ///Create Community
  Future<bool> createCommunity(CommunityModel community) async {
    try {
      await db
          .collection(FireStoreCollections.communities.name)
          .add(community.toMap());
      return true;
    } on Exception {
      return false;
    }
  }

  ///Join Community

  ///Get Communities
  Future<List<CommunityModel>> getCommunities() async {
    final response =
        await db.collection(FireStoreCollections.communities.name).get();
    final communityList = response.docs
        .map((e) => CommunityModel.fromJson(e.data(), e.id))
        .toList();
    return communityList;
  }

  Future<List<CommunityModel>> getUserCommunities(String userId) async {
    final idListResponse = await db
        .collectionGroup(FireStoreCollections.members.name)
        .where('userId', isEqualTo: userId)
        .get();
    final idList =
        idListResponse.docs.map((e) => e.reference.parent.parent?.id).toList();
    final communityList = <CommunityModel>[];
    for (final id in idList) {
      final response = await db
          .collection(FireStoreCollections.communities.name)
          .doc(id)
          .get();
      if (!response.exists) continue;
      final community = CommunityModel.fromJson(response.data()!, response.id);
      communityList.add(community);
    }
    return communityList;
  }

  Future<List<CategoryModel>> getCommunityCategories() async {
    final response =
        await db.collection(FireStoreCollections.categories.name).get();
    final categoryList = response.docs
        .map((e) => CategoryModel.fromMap(e.data(), e.id))
        .toList();
    return categoryList;
  }

  Future<List<PollModel>> getCommunityPolls(String communityId) async {
    final response = await db
        .collection(FireStoreCollections.polls.name)
        .where(FireStoreFields.ownerId.name, isEqualTo: communityId)
        .get();
    final pollList =
        response.docs.map((e) => PollModel.fromJson(e.data(), e.id)).toList();
    return pollList;
  }
}
