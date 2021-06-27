// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['login'] as String,
    json['id'] as int,
    json['avatar_url'] as String,
    json['html_url'] as String,
    json['name'] as String,
    json['company'] as String,
    json['blog'] as String,
    json['location'] as String,
    json['email'] as String,
    json['followers'] as int,
    json['following'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'followers': instance.followersCount,
      'following': instance.followingCount,
    };
