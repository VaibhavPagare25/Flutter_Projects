import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/tabs_model.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/services/tabs_catogory.dart';

class TabScreens extends StatefulWidget {
  String newsName;
  TabScreens({required this.newsName, super.key});

  @override
  State<TabScreens> createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  List<TabNewsModel> tabNewsList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getTabNews();
  }

  void getTabNews() async {
    TabsNews tabObj = TabsNews();
    await tabObj.getTabData(widget.newsName.toLowerCase());
    tabNewsList = tabObj.getTabNewsList;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Material(
              elevation: 3,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: tabNewsList.length,
                itemBuilder: (context, index) {
                  return NewsTile(
                    title: tabNewsList[index].title!,
                    description: tabNewsList[index].description!,
                    imageUrl: tabNewsList[index].urlToImage!,
                    url: tabNewsList[index].url!,
                  );
                },
              ),
            ),
    );
  }
}

class NewsTile extends StatelessWidget {
  String title, description, imageUrl, url;
  NewsTile(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsView(newsUrl: url),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  description,
                  maxLines: 3,
                  style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
