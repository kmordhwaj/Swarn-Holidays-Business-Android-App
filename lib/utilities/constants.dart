import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _firestore.collection('users');
final postsRef = _firestore.collection('posts');
final followersRef = _firestore.collection('followers');
final followingRef = _firestore.collection('following');
final feedsRef = _firestore.collection('feeds');
final likesRef = _firestore.collection('likes');
final commentsRef = _firestore.collection('comments');
final activitiesRef = _firestore.collection('activities');
final archivedPostsRef = _firestore.collection('archivedPosts');
final deletedPostsRef = _firestore.collection('deletedPosts');
final chatsRef = _firestore.collection('chats');
final storiesRef = _firestore.collection('stories');
String user = 'userFeed';
String usersFollowers = 'userFollowers';
String userFollowing = 'userFollowing';
String placeHolderImageRef = 'assets/images/user_placeholder.jpg';

final DateFormat timeFormat = DateFormat('E, h:mm a');

String? currentUserId = 'o863cQKLqlht01E1ltPZwn0W8w03';
String? bio;
String? email = 'anamestutiwari@gmail.com';
List<String>? favouriteProducts;
String? firstName = 'Swarn';
String? phone;
String? profileImageUrl;
String? secondName = 'Holidays Team';

enum PostStatus {
  feedPost,
  deletedPost,
  archivedPost,
}

enum SearchFrom { messagesScreen, homeScreen, createStoryScreen, feedScreen }

enum CameraConsumer {
  post,
  story,
}
