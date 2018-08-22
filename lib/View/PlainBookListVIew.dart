import 'package:flutter/material.dart';
import '../model/OrderBook.dart';
class PlainBookList extends StatelessWidget{
  List<OrderBook> list;
  PlainBookList(this.list);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(list[index].book.title),
                    flex: 8,
                  ),
                  Expanded(
                    child: Text(list[index].amount.toString() + '本'),
                    flex: 2,
                  ),
                ]
            ),
            Divider(
              height: 4.0,
              color: Colors.grey,
            )
          ],
        );
      },
      itemCount: list == null ? 0 : list.length,
      shrinkWrap: true, // todo comment this out and check the result
      physics: ClampingScrollPhysics(), // todo comment this out and check the result
    );
  }
}
