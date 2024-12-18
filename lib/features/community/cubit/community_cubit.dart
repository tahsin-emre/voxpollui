import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';

final class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityState());

  final _communityService = CommunityService();

  Future<void> fetchCommunityList(String userId) async {
    emit(state.copyWith(isLoading: true));
    final categoryList = await _communityService.getCommunityCategories();
    final communityList = await _communityService.getCommunities();
    final myCommunityList = await _communityService.getUserCommunities(userId);
    communityList.removeWhere(myCommunityList.contains);
    emit(
      state.copyWith(
        communityList: communityList,
        myCommunityList: myCommunityList,
        categoryList: categoryList,
        isLoading: false,
      ),
    );
  }

  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true));
    final categoryList = await _communityService.getCommunityCategories();
    emit(
      state.copyWith(categoryList: categoryList, isLoading: false),
    );
  }

  Future<bool> createCommunity(CommunityModel community) async {
    return _communityService.createCommunity(community);
  }

  Future<bool> updateCommunity(CommunityModel community) async {
    final response = await _communityService.updateCommunity(community);
    if (!response) return false;
    return true;
  }
}
