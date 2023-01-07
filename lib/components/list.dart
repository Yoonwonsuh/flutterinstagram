import 'package:flutter/material.dart';

class MainList extends StatefulWidget {
  MainList({Key? key, this.postList}) : super(key: key);
  var postList;
  var getData2;

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    if (widget.postList.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.postList.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.postList[i]['image'].runtimeType == String
                      ? Image.network(widget.postList[i]['image'].toString())
                      : Image.file(widget.postList[i]['image']),
                  Text('좋아요 ${widget.postList[i]['likes'].toString()}'),
                  Text(widget.postList[i]['date'].toString()),
                  Text(widget.postList[i]['content'].toString()),
                ],
              ),
            );
          });
    } else {
      return Text('로딩중');
    }
  }
}
