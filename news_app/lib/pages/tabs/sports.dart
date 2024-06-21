import 'package:flutter/material.dart';
import 'package:news_app/pages/tab_screens.dart';

class SportsTab extends StatefulWidget {
  const SportsTab({super.key});

  @override
  State<SportsTab> createState() => _SportsTabState();
}

class _SportsTabState extends State<SportsTab> {
  @override
  Widget build(BuildContext context) {
    return TabScreens(newsName: "sports");
  }
}
