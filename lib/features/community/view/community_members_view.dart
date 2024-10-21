import 'package:flutter/material.dart';
import 'package:voxpollui/features/profile/widget/user_tile_from_id.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/services/firebase/community_service.dart';

class CommunityMembersView extends StatefulWidget {
  const CommunityMembersView({required this.community, super.key});
  final CommunityModel community;
  @override
  State<CommunityMembersView> createState() => _CommunityMembersViewState();
}

class _CommunityMembersViewState extends State<CommunityMembersView> {
  final List<String> _memberIds = [];
  final CommunityService _communityService = CommunityService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: ListView(
        children: [
          ..._memberIds.map(UserTileFromId.new),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    setState(() => isLoading = true);
    final members =
        await _communityService.getCommunityMemberIds(widget.community.id);
    setState(() {
      _memberIds.addAll(members);
      isLoading = false;
    });
  }
}
