import 'package:flutter/material.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return StylishSkeleton(
      subtitle: "Settings",
      child: Center(child: Text("Settings Page"),),
    );
  }
}
