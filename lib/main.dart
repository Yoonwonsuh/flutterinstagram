//패키지
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

//컴포넌트
import './components/list.dart';
import './pages/upload.dart';

//스타일 가져오기//
import './style/style.dart';

void main() {
  runApp(MaterialApp(theme: theme, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      postList = result2;
    });
  }

  int tab = 0;
  var postList = [];
  var userImage;
  var userContent;

  setUserContents(a) {
    setState(() {
      userContent = a;
    });
  }

  addData(a) {
    setState(() {
      postList.add(a);
    });
  }

  addMyData() {
    var myData = {
      'id': postList.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John Kim'
    };
    setState(() {
      postList.add(myData);
    });
  }

  tapOn(i) {
    setState(() {
      tab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UploadPage(
                          userImage: userImage,
                          setUserContents: setUserContents,
                          addMyData: addMyData)));
            },
            icon: Icon(Icons.add_box_outlined),
            iconSize: 30,
          ),
        ],
      ),
      body: [MainList(postList: postList), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          tapOn(i);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: '샵'),
        ],
      ),
    );
  }
}
