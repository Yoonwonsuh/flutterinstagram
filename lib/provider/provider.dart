import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Store1 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  var friend = false;
  var profileImage = [];
  
  getData() async{
    var res = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var res2 = jsonDecode(res.body);
    profileImage = res2;
    notifyListeners();
  }

  AddFollower(){
    if (friend == false) {
      follower++;
      friend=true;
      notifyListeners();
    }
    else {
      follower--;
      friend=false;
      notifyListeners();
    }
  }

  ChangeName() {
    name = 'john Park';
    notifyListeners();
  }
}


class Store2 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  var friend = false;

  AddFollower(){
    if (friend == false) {
      follower++;
      friend=true;
      notifyListeners();
    }
    else {
      follower--;
      friend=false;
      notifyListeners();
    }
  }

  ChangeName() {
    name = 'john Park';
    notifyListeners();
  }
}
