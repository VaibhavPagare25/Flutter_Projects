import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  String newsUrl;
  NewsView({required this.newsUrl, super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WebView",
          style: GoogleFonts.playfairDisplay(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
