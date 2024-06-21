import 'package:flutter/material.dart';
import 'package:news_app/pages/tab_screens.dart';

class FinanceTab extends StatefulWidget {
  const FinanceTab({super.key});

  @override
  State<FinanceTab> createState() => _FinanceTabState();
}

class _FinanceTabState extends State<FinanceTab> {
  @override
  Widget build(BuildContext context) {
    return TabScreens(newsName: "business");
  }
}
