/* eslint-disable max-len */
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onDocumentCreated, onDocumentDeleted} = require("firebase-functions/v2/firestore");
initializeApp();
const db = getFirestore();


exports.vote = onDocumentCreated("polls/{pollId}/votes/{userId}", async (event) => {
  const pollId = event.params.pollId;
  const optionId = event.data.optionId;
  const pollRef = db.collection("users").doc(pollId);
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
  await pollRef.update({"options": updatedOptions});
});

exports.following = onDocumentCreated("users/{userId}/following/{followingId}", async (event) => {
  const userId = event.params.userId;
  const userRef = db.collection("users").doc(userId);
  const userSnap = await userRef.get();
  const userData = userSnap.data();
  await userRef.update({followingCount: userData.followingCount + 1});
});

exports.followed = onDocumentCreated("users/{userId}/followers/{followingId}", async (event) => {
  const userId = event.params.userId;
  const userRef = db.collection("users").doc(userId);
  const userSnap = await userRef.get();
  const userData = userSnap.data();
  await userRef.update({followersCount: userData.followersCount + 1});
});

exports.unfollowing = onDocumentDeleted("users/{userId}/following/{followingId}", async (event) => {
  const userId = event.params.userId;
  const userRef = db.collection("users").doc(userId);
  const userSnap = await userRef.get();
  const userData = userSnap.data();
  await userRef.update({followingCount: userData.followingCount - 1});
});

exports.unfollowed = onDocumentDeleted("users/{userId}/followers/{followingId}", async (event) => {
  const userId = event.params.userId;
  const userRef = db.collection("users").doc(userId);
  const userSnap = await userRef.get();
  const userData = userSnap.data();
  await userRef.update({followersCount: userData.followersCount - 1});
});

exports.joinCommunty = onDocumentCreated("communities/{communityId}/members/{memberId}", async (event) => {
  const communityId = event.params.communityId;
  const communityRef = db.collection("communities").doc(communityId);
  const communitySnap = await communityRef.get();
  const communityData = communitySnap.data();
  await communityRef.update({"memberCount": communityData.memberCount + 1});
});

exports.leaveCommunty = onDocumentDeleted("communities/{communityId}/members/{memberId}", async (event) => {
  const communityId = event.params.communityId;
  const communityRef = db.collection("communities").doc(communityId);
  const communitySnap = await communityRef.get();
  const communityData = communitySnap.data();
  await communityRef.update({"memberCount": communityData.memberCount - 1});
});
