import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voxpollui/product/initialize/models/community/community_category_model.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';
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
    final communityList = response.docs.map(CommunityModel.fromQDS).toList();
    return communityList;
  }

  Future<List<CommunityModel>> getUserCommunities(String userId) async {
    final response = await db
        .collectionGroup(FireStoreCollections.members.name)
        .where(FieldPath.documentId, isEqualTo: userId)
        .get();
    final communityList = response.docs.map(CommunityModel.fromQDS).toList();
    return communityList;
  }

  Future<List<CommunityCategoryModel>> getCommunityCategories() async {
    final response = await db
        .collection(FireStoreCollections.communityCategories.name)
        .get();
    final categoryList =
        response.docs.map(CommunityCategoryModel.fromQDS).toList();
    return categoryList;
  }

  ///Get Communities With Keyword

  ///Get Community By Id
}
