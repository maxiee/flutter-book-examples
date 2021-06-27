import 'package:flutter/material.dart';
import 'package:tech_news/model/Activity.dart';
import 'package:tech_news/page/PageWeb.dart';

class CardEvent extends StatelessWidget {
  final Event event;

  CardEvent(this.event);

  void openProject(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageWeb("https://github.com/${event.repo.name}")));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openProject(context),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(event.actor.avatarUrl)
                  )
              ),
            ),
            SizedBox(width: 12),
            Flexible(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(event.actor.login, style: TextStyle(
                        color: Colors.grey[600]
                    )),
                    SizedBox(width: 12),
                    Text(event.type, style: TextStyle(
                        color: Colors.grey[600]
                    )),
                  ],
                ),
                SizedBox(height: 8),
                Text(event.repo.name, style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[900]
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}