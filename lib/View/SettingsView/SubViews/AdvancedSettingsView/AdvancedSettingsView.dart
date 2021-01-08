import 'package:flutter/material.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';

class AdvancedSettings extends StatelessWidget {
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
        subtitle: "Cloud Backup",
        child: Center(child:Text("Advanced Settings")),
      ),
    );
  }
}
