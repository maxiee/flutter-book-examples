import 'dart:convert';

import 'package:tech_news/model/Activity.dart';
import 'package:tech_news/net/GitHub.dart';
import 'package:http/http.dart' as http;

import 'Service.dart';

class ActivityService extends Service {
  ActivityService(GitHub gitHub) : super(gitHub);

  Future<List<Event>> listPublicEvents(int page, int perPage) async {
    http.Response response = await gitHub.request(
        "GET",
        "/events",
        params: {'page': page, 'per_page': perPage});

    final json = jsonDecode(response.body) as List;
    return json.map((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event>> listPersonalEvents(
      String login, int page, int perPage) async {
    http.Response response = await gitHub.request(
        "GET",
        "/users/${login}/received_events",
        params: {'page': page, 'per_page': perPage});

    final json = jsonDecode(response.body) as List;
    return json.map((e) => Event.fromJson(e)).toList();
  }
}
