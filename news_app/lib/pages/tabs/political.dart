import 'package:flutter/material.dart';
import 'package:news_app/pages/tab_screens.dart';

class PoliticalTab extends StatefulWidget {
  const PoliticalTab({super.key});

  @override
  State<PoliticalTab> createState() => _PoliticalTabState();
}

class _PoliticalTabState extends State<PoliticalTab> {
  @override
  Widget build(BuildContext context) {
    return TabScreens(newsName: "science");
  }
}
