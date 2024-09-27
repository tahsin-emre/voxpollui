const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onRequest} = require("firebase-functions/v2/https");
initializeApp();
const db = getFirestore();

exports.votePoll = onRequest(
    async (req, res) => {
      // RequestBody {'userId':string, 'pollId':string, 'optionId':string}
      const pollId = req.body.pollId;
      const userId = req.body.userId;
      const optionId = req.body.optionId;
      const pollRef = db.collection("polls").doc(pollId);
      const voteSnap = await pollRef.collection("votes").doc(userId).get();
      if (voteSnap.exists) {
        res.status(400).send("User already voted");
        return;
      }
      const pollSnap = await pollRef.get();
      const pollData = pollSnap.data();
      const options = pollData.options;
      const updatedOptions = options.map((option) => {
        if (option.id === optionId) {
          return {
            ...option,
            voteCount: option.voteCount + 1,
          };
        }
        return option;
      });
      await pollRef.collection("votes").doc(userId)
          .set(
              {"optionId": optionId,
                "createdAt": new Date(),
                "userId": userId},
          );
      await pollRef.update({options: updatedOptions});
      res.status(200).send(true);
    },
);

exports.followUser = onRequest(
    async (req, res) => {
      // RequestBody {'userId':string, 'followerId':string}
      const followerId = req.body.followerId;
      const userId = req.body.userId;
      const userRef = db.collection("users").doc(userId);
      const followerRef = db.collection("users").doc(followerId);
      const followerCollection = userRef.collection("followers");
      const followingCollection = followerRef.collection("following");
      await followerCollection.doc(followerId).set({"createdAt": new Date()});
      await followingCollection.doc(userId).set({"createdAt": new Date()});
      const userSnap = await userRef.get();
      const userData = userSnap.data();
      const followerSnap = await followerRef.get();
      const followerData = followerSnap.data();
      await userRef
          .update({followersCount: userData.followersCount + 1});
      await followerRef
          .update({followingCount: followerData.followingCount + 1});
      res.status(200).send(true);
    },
);

exports.unfollowUser = onRequest(
    async (req, res) => {
      // RequestBody {'userId':string, 'followerId':string}
      const followerId = req.body.followerId;
      const userId = req.body.userId;
      const userRef = db.collection("users").doc(userId);
      const followerRef = db.collection("users").doc(followerId);
      const followerCollection = userRef.collection("followers");
      const followingCollection = followerRef.collection("following");
      await followerCollection.doc(followerId).delete();
      await followingCollection.doc(userId).delete();
      const userSnap = await userRef.get();
      const userData = userSnap.data();
      const followerSnap = await followerRef.get();
      const followerData = followerSnap.data();
      await userRef
          .update({followersCount: userData.followersCount - 1});
      await followerRef
          .update({followingCount: followerData.followingCount - 1});
      res.status(200).send(true);
    },
);
