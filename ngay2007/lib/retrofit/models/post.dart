import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'post.g.dart';
part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {

  const factory Post({
    required int id,
    required String title,
    required String body,
    User? author,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
