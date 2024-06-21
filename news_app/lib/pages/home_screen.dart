import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/tabs/finance.dart';
import 'package:news_app/pages/tabs/for_you.dart';
import 'package:news_app/pages/tabs/political.dart';
import 'package:news_app/pages/tabs/sports.dart';
import 'package:news_app/pages/tabs/tachnology.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Daily News",
            style: GoogleFonts.playfairDisplay(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "ForYou"),
              Tab(text: "Business"),
              Tab(text: "Technology"),
              Tab(text: "Sports"),
              Tab(text: "Science"),
            ],
          ),
        ),
        drawer: const Drawer(
          child: Center(child: Text("Hello there!")),
        ),
        body: const TabBarView(
          children: [
            ForYouTab(),
            FinanceTab(),
            TechnologyTab(),
            SportsTab(),
            PoliticalTab(),
          ],
        ),
      ),
    );
  }
}
