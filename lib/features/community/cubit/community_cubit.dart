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

  Future<bool> joinCommunity(String userId, String communityId) async {
    final response = await _communityService.joinCommunity(userId, communityId);
    if (!response) return false;
    await fetchCommunityList(userId);
    return true;
  }

  Future<void> getPolls(String communityId) async {
    emit(state.copyWith(isLoading: true));
    final allPolls = await _communityService.getCommunityPolls(communityId);
    final selectedNewPolls =
        allPolls.where((e) => e.endAt!.isAfter(DateTime.now())).toList();
    final selectedOldPolls =
        allPolls.where((e) => e.endAt!.isBefore(DateTime.now())).toList();
    emit(
      state.copyWith(
        isLoading: false,
        selectedNewPolls: selectedNewPolls,
        selectedOldPolls: selectedOldPolls,
      ),
    );
  }
}
