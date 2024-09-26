import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_state.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';

final class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityState());

  final _communityService = CommunityService();

  Future<void> fetchCommunityList() async {
    emit(state.copyWith(isLoading: true));
    final communityList = await _communityService.getCommunities();
    emit(state.copyWith(communityList: communityList, isLoading: false));
  }
}
