//패키지
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/pages/profile.dart';
import 'package:instagram/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import './components/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

//컴포넌트
import './components/list.dart';
import './pages/upload.dart';

//스타일 가져오기//
import './style/style.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Store1(),),
      ChangeNotifierProvider(create: (context) => Store2(),),
    ],
      child: MaterialApp(theme: theme, home: MyApp())));
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
    saveData();
    initNotification(context);
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

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    var map = {'age': 20};
    storage.setString('map', jsonEncode(map));
    var result = storage.getString('map') ?? '없는데요';
    print(jsonDecode(result));
  }

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
      floatingActionButton: FloatingActionButton(onPressed: (){showNotification();},child: Text('알림')),
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
