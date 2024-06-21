import 'package:flutter/material.dart';
import 'package:news_app/pages/tab_screens.dart';

class TechnologyTab extends StatefulWidget {
  const TechnologyTab({super.key});

  @override
  State<TechnologyTab> createState() => _TechnologyTabState();
}

class _TechnologyTabState extends State<TechnologyTab> {
  @override
  Widget build(BuildContext context) {
    return TabScreens(newsName: "technology");
  }
}
