import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActivityIndicator extends StatelessWidget {

  String os;  
  ActivityIndicator({
    required this.os,
  });
  @override
  Widget build(BuildContext context) {
    if(os == 'android')
    return CircularProgressIndicator();

    return CupertinoActivityIndicator();
  }
}