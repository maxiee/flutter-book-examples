// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) {
  return Repository(
    json['name'] as String,
    json['id'] as int,
    json['full_name'] as String,
    json['owner'] == null
        ? null
        : UserInformation.fromJson(json['owner'] as Map<String, dynamic>),
    json['private'] as bool,
    json['fork'] as bool,
    json['url'] as String,
    json['description'] as String,
    json['clone_url'] as String,
    json['ssh_url'] as String,
    json['git_url'] as String,
    json['homepage'] as String,
    json['size'] as int,
    json['stargazers_count'] as int,
    json['watchers_count'] as int,
    json['language'] as String,
    json['forks_count'] as int,
    json['subscribers_count'] as int,
  );
}

Map<String, dynamic> _$RepositoryToJson(Repository instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'private': instance.private,
      'fork': instance.fork,
      'url': instance.url,
      'description': instance.description,
      'clone_url': instance.cloneUrl,
      'ssh_url': instance.sshUrl,
      'git_url': instance.gitUrl,
      'homepage': instance.homepage,
      'size': instance.size,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'subscribers_count': instance.subscribersCount,
    };

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) {
  return UserInformation(
    json['login'] as String,
    json['id'] as int,
    json['avatar_url'] as String,
    json['html_url'] as String,
  );
}

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
    };
