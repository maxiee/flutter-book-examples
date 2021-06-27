import 'package:json_annotation/json_annotation.dart';
import 'package:tech_news/model/Repo.dart';
import 'package:tech_news/model/User.dart';

part 'Activity.g.dart';

@JsonSerializable()
class Event {
  String id;
  String type;
  Repository repo;
  User actor;
  Map<String, dynamic> payload;

  Event(this.id, this.type, this.repo, this.actor, this.payload);

  factory Event.fromJson(Map<String, dynamic> input) =>
      _$EventFromJson(input);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}