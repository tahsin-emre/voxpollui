import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';

final class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityState());

  final _communityService = CommunityService();

  Future<void> fetchCommunityList() async {
    emit(state.copyWith(isLoading: true));
    final communityList = await _communityService.getCommunities();
    final categoryList = await _communityService.getCommunityCategories();
    emit(
      state.copyWith(
        communityList: communityList,
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
