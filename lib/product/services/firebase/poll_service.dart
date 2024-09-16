import 'package:voxpollui/product/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class PollService extends BaseService {
  factory PollService() => _instance;
  PollService._();
  static final PollService _instance = PollService._();

  ///Get Polls For Feed View
  Future<List<PollModel>> getPolls() async {
    ///Implement getPolls via Cloud Functions
    final polls = await db.collection('polls').get();
    return polls.docs.map(PollModel.fromQDS).toList();
  }

  ///Create Poll
  Future<String?> createPoll(PollModel poll) async {
    try {
      final pollId = await db.collection('polls').add(poll.toMap());
      return pollId.id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkIfUserVoted(String pollId) async {
    final poll = await db.collection('polls').doc(pollId).get();
    final votes = poll.data()!['votes'] as Map<String, dynamic>?;
    return votes?.containsKey(auth.currentUser!.uid) ?? false;
  }

  ///Vote Poll

  ///Get Polls
}
