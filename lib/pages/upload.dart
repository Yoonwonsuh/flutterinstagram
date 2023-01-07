import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  UploadPage({Key? key, this.userImage, this.setUserContents, this.addMyData}) : super(key: key);
  var userImage;
  var setUserContents;
  var addMyData;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: (){
            addMyData();
          }, icon: Icon(Icons.send))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),
            Text('이미지업로드화면'),
            TextField(onChanged: (text){
              setUserContents(text);
            }),
            TextField(),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ],
        ));
  }
}
