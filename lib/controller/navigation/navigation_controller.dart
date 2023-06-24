

import 'package:flutter/material.dart';
import 'package:ltr/views/pages/home/homepage.dart';
import 'package:ltr/views/pages/home/mainscreen.dart';
import 'package:ltr/views/pages/user/usercreation.dart';
import 'package:ltr/views/pages/user/userlist.dart';

class NavigationController {


  pageRoute(page){
    switch(page) {
      case 1: {
        // MainPage;
        return  MaterialPageRoute(builder: (context) =>  const MainPage());
      }
      break;
      case 2: {
        //Game Selection;
        return  MaterialPageRoute(builder: (context) =>  const HomePage());
      }
      break;

      break;

      default: {
        //statements;
      }
      break;
    }

  }


}