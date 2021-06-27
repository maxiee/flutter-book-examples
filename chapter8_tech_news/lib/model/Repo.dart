import 'package:json_annotation/json_annotation.dart';
part 'Repo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Repository {
  final String name;
  final int id;
  final String fullName;
  final UserInformation owner;
  final bool private;
  final bool fork;
  final String url;
  final String description;
  final String cloneUrl;
  final String sshUrl;
  final String gitUrl;
  final String homepage;
  final int size;

  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;

  @JsonKey(name: 'watchers_count')
  final int watchersCount;

  final String language;

  @JsonKey(name: 'forks_count')
  final int forksCount;

  @JsonKey(name: 'subscribers_count')
  final int subscribersCount;

  Repository(
      this.name,
      this.id,
      this.fullName,
      this.owner,
      this.private,
      this.fork,
      this.url,
      this.description,
      this.cloneUrl,
      this.sshUrl,
      this.gitUrl,
      this.homepage,
      this.size,
      this.stargazersCount,
      this.watchersCount,
      this.language,
      this.forksCount,
      this.subscribersCount);


  factory Repository.fromJson(Map<String, dynamic> input) =>
      _$RepositoryFromJson(input);
  Map<String, dynamic> toJson() => _$RepositoryToJson(this);

  @override
  String toString() => '${owner.login}/$name';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserInformation {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;

  UserInformation(
      this.login,
      this.id,
      this.avatarUrl,
      this.htmlUrl);

  factory UserInformation.fromJson(Map<String, dynamic> input) =>
      _$UserInformationFromJson(input);

  Map<String, dynamic> toJson() => _$UserInformationToJson(this);
}