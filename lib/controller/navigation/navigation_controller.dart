

import 'package:flutter/material.dart';
import 'package:ltr/views/pages/home/homepage.dart';
import 'package:ltr/views/pages/home/mainscreen.dart';

class NavigationController {


  pageRoute(page){
    switch(page) {
      case 1: {
        // MainPage;
        return  MaterialPageRoute(builder: (context) =>  const MainPage());
      }
      case 2: {
        //Game Selection;
        return  MaterialPageRoute(builder: (context) =>  const HomePage());
      }
      default: {
        //statements;
      }
      break;
    }

  }


}