import 'package:flutter/material.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
class AboutMeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StylishSkeleton(
        iconButton: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        subtitle: "About Me",
        child: Center(child:Text("Hello there 👋 , I'm Andrei the developer of this app!")),
      ),
    );
  }
}
