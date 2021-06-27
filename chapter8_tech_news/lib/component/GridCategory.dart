import 'package:flutter/material.dart';

class GridItem {
  String title;
  IconData icon;
  Function(BuildContext context) getPage;
  MaterialColor color;

  GridItem(this.title, this.icon, this.color, this.getPage);
}

class GridCategory extends StatelessWidget {
  final GridItem _gridItem;

  GridCategory(this._gridItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator
          .of(context)
          .push(MaterialPageRoute(builder: _gridItem.getPage)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey[200])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_gridItem.icon, color: _gridItem.color, size: 36,),
            SizedBox(height: 2),
            Text(_gridItem.title, style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}