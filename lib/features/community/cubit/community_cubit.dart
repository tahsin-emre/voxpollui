import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';

final class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityState());

  final _communityService = CommunityService();

  Future<void> fetchCommunityList(String userId) async {
    emit(state.copyWith(isLoading: true));
    final myCommunityList = await _communityService.getUserCommunities(userId);
    final communityList = await _communityService.getCommunities();
    communityList.removeWhere(myCommunityList.contains);
    final categoryList = await _communityService.getCommunityCategories();
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
}
