import 'package:tech_news/net/ActivityService.dart';
import 'package:tech_news/net/GitHub.dart';

class GitHubServices {
  static GitHub _gitHub;

  static ActivityService activityService;

  static void init(GitHub gitHub) {
    _gitHub = gitHub;
    activityService = ActivityService(_gitHub);
  }
}