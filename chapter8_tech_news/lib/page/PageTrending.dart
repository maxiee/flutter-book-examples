import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xpath_parse/xpath_selector.dart';

import 'PageWeb.dart';

const XPATH_ITEM = "//article[@class='Box-row']";
const XPATH_HREF = "//h1[@class='h3 lh-condensed']/a/@href";
const XPATH_DESCRIPTION = "//p[@class='col-9 text-gray my-1 pr-4']//text()";
const XPATH_STARS = "//a[@class='muted-link d-inline-block mr-3']//text()";

class TrendingItem {
  final String projectName;
  final String description;
  final String url;
  final String stars;

  TrendingItem(
      this.projectName,
      this.description,
      this.url,
      this.stars);
}

class PageTrending extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageTrendingState();
  }
}

class _PageTrendingState extends State<PageTrending> {
  List<TrendingItem> _projects = [];

  void openProject(BuildContext context, url) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PageWeb(url)));
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      print("发送请求");
      final response =
          await http.Client().get(
              Uri.parse("https://github.com/trending"));
      if (response.statusCode != 200) {
        return;
      }

      print("解析结果");
      final dom = XPath.source(response.body);

      final items = dom.query(XPATH_ITEM).elements();

      List<TrendingItem> projects = [];
      for (final item in items) {
        final xpathItem = XPath(item);
        final href = xpathItem
            .query(XPATH_HREF)
            .get();
        final description = xpathItem
            .query(XPATH_DESCRIPTION)
            .get();
        final stars = xpathItem
            .query(XPATH_STARS)
            .get();

        print(href);

        projects.add(
            TrendingItem(
                href.substring(1),
                description,
                "https://github.com${href}",
                stars));
      }

      print("更新状态");
      setState(() {
        _projects = projects;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            TrendingItem project = _projects[index];
            return ListTile(
              title: Text(
                project.projectName,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(project.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.yellow[700]),
                  Container(
                      width: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(project.stars),
                      ))
                ],
              ),
              onTap: () => openProject(context, project.url),
            );
          },
          itemCount: _projects.length,
          separatorBuilder: (context, index) => Divider()),
    );
  }
}
