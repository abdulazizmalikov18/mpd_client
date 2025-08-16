import 'package:flutter/cupertino.dart';
import 'package:mpd_client/features/home/data/models/posts_model.dart';

class PostInheritedNotifier extends InheritedNotifier<PostNotifier> {
  const PostInheritedNotifier({
    super.key,
    required PostNotifier postNotifier,
    required super.child,
  }) : super(notifier: postNotifier);

  static PostInheritedNotifier of(BuildContext context) {
    final PostInheritedNotifier? result = context
        .dependOnInheritedWidgetOfExactType<PostInheritedNotifier>();
    assert(result != null, 'No PostInheritedNotifier found in context');
    return result!;
  }
}

class PostNotifier extends ChangeNotifier {
  final List<Post> _post = [];
  List<Post> get post => _post;
  int selectedMediaIndex = 0;

  set setPost(Post value) {
    _post.add(value);
  }

  void likeUnlike(int index) {
    _post[index].isLiked = !_post[index].isLiked!;
    if (_post[index].isLiked!) {
      _post[index].likesCount = _post[index].likesCount! + 1;
    } else {
      _post[index].likesCount = _post[index].likesCount! - 1;
    }
    notifyListeners();
  }

  void insertComentCount(int index) {
    _post[index].commentCount = _post[index].commentCount! + 1;
    notifyListeners();
  }

  void changedMediaIndex({required int postIndex, required int mediaIndex}) {
    _post[postIndex].selectedIndex = mediaIndex;
    notifyListeners();
  }

  void changeSelectedMediaIndex(int index) {
    selectedMediaIndex = index;
    notifyListeners();
  }
}
