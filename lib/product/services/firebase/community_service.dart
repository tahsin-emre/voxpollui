import 'package:voxpollui/product/initialize/models/community/community_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class CommunityService extends BaseService {
  factory CommunityService() => _instance;
  CommunityService._();
  static final CommunityService _instance = CommunityService._();

  ///Join Community

  ///Get Communities
  Future<List<CommunityModel>> getCommunities() async {
    final response = await db.collection('communities').get();
    final communityList = response.docs.map(CommunityModel.fromQDS).toList();
    return communityList;
  }

  ///Get Communities With Keyword

  ///Get Community By Id
}
