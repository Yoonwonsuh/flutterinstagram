import 'package:flutter/material.dart';
import 'package:instagram/provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DetailComponent extends StatefulWidget {
  DetailComponent({Key? key, this.postList}) : super(key: key);
  var postList;

  @override
  State<DetailComponent> createState() => _DetailComponentState();
}

class _DetailComponentState extends State<DetailComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.watch<Store1>().name)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                  ),
                  Text('팔로워 ${context.watch<Store1>().follower}명'),
                  ElevatedButton(
                      onPressed: () {
                        context.read<Store1>().AddFollower();
                      },
                      child: Text('팔로우')),
                  ElevatedButton(
                      onPressed: () {
                        context.read<Store1>().getData();
                      },
                      child: Text('사진 가져오기'))
                ],
              ),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (c, i) => Container(
                    color: Colors.grey,
                    child: Image.network(context.watch<Store1>().profileImage[i]),
                  ),
                  childCount: context.watch<Store1>().profileImage.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5)),
          ],
        ));
  }
}
