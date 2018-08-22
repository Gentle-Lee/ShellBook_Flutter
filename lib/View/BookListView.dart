import 'package:flutter/material.dart';
import '../model/OrderBook.dart';
class BookListView extends StatelessWidget{
  List<OrderBook> list;
  BookListView(this.list);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisSize:MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Image.network("http://www.beikebook.com"+list[index].book.compressedCover ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(list[index].book.title),
                            Text(list[index].book.author ),
                            Text(list[index].book.edition ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        flex: 6,
                      ),
                      Expanded(
                        child: Center(child: Text(list[index].amount.toString() + '本')),
                        flex: 2,
                      ),
                    ]
                ),
              ),
              Divider(
                height: 4.0,
                color: Colors.grey,
              )
            ],
          );
        },
        itemCount: list == null ? 0 :  list.length,
        shrinkWrap: true, // todo comment this out and check the result
        physics: ClampingScrollPhysics(), // todo comment this out and check the result
      ),
    );
  }
  
}