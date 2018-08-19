import 'package:flutter/material.dart';
import '../model/Book.dart';
class BookItem extends StatelessWidget{
  List<Book> list;
  BookItem(this.list);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if(index.isOdd )
            return Divider(height: 4.0,);
          return Row(
              mainAxisSize:MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Image.network(list[index].compressedCover ),
                  flex: 2,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(list[index].title),
                      Text(list[index].author ),
                      Text(list[index].edition ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: Center(child: Text('test num')),
                  flex: 2,
                )
              ]
          );
        },
        itemCount: list.length*2 ,
        shrinkWrap: true, // todo comment this out and check the result
        physics: ClampingScrollPhysics(), // todo comment this out and check the result
      ),
    );
  }
  
}