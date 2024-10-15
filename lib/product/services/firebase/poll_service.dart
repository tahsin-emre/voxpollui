import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class PollService extends BaseService {
  factory PollService() => _instance;
  PollService._();
  static final PollService _instance = PollService._();

  ///Get Polls For Feed View
  Future<List<PollModel>> getFeedPolls() async {
    ///Implement getPolls via Cloud Functions
    final polls = await db.collection(FireStoreCollections.polls.name).get();
    return polls.docs.map((e) => PollModel.fromJson(e.data(), e.id)).toList();
  }

  ///Get Poll Details
  Future<PollModel?> getPoll(String pollId) async {
    final response =
        await db.collection(FireStoreCollections.polls.name).doc(pollId).get();
    if (!response.exists) return null;
    return PollModel.fromJson(response.data()!, response.id);
  }

  ///Get Polls By User
  Future<List<PollModel>> getPollsByUser(String userId) async {
    final polls = await db
        .collection(FireStoreCollections.polls.name)
        .where('ownerId', isEqualTo: userId)
        .get();
    return polls.docs.map((e) => PollModel.fromJson(e.data(), e.id)).toList();
  }

  ///Get Polls Which User Participated
  Future<List<PollModel>> getPollsParticipated(String userId) async {
    final idListResponse = await db
        .collectionGroup(FireStoreCollections.votes.name)
        .where('userId', isEqualTo: userId)
        .get();
    final idList =
        idListResponse.docs.map((e) => e.reference.parent.parent?.id).toList();
    final pollList = <PollModel>[];
    for (final id in idList) {
      final response =
          await db.collection(FireStoreCollections.polls.name).doc(id).get();
      if (!response.exists) continue;
      final community = PollModel.fromJson(response.data()!, response.id);
      pollList.add(community);
    }
    return pollList;
  }

  ///Create Poll
  Future<String?> createPoll(PollModel poll) async {
    try {
      final pollId = await db
          .collection(FireStoreCollections.polls.name)
          .add(poll.toMap());
      return pollId.id;
    } catch (e) {
      return null;
    }
  }

  ///Get Poll Categories
  Future<List<CategoryModel>> getPollCategories() async {
    final response =
        await db.collection(FireStoreCollections.categories.name).get();
    final categoryList = response.docs
        .map((e) => CategoryModel.fromMap(e.data(), e.id))
        .toList();
    return categoryList;
  }

  ///Check If User Voted
  Future<String?> checkIfUserVoted({
    required String pollId,
    required String userId,
  }) async {
    final vote = await db
        .collection(FireStoreCollections.polls.name)
        .doc(pollId)
        .collection(FireStoreCollections.votes.name)
        .doc(userId)
        .get();
    return vote.data()?['optionId'] as String?;
  }

  ///Vote Poll
  Future<bool> votePoll(String pollId, String userId, String optionId) async {
    try {
      await db
          .collection(FireStoreCollections.polls.name)
          .doc(pollId)
          .collection(FireStoreCollections.votes.name)
          .doc(userId)
          .set({
        'optionId': optionId,
        'createdAt': Timestamp.now(),
        'userId': userId,
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
