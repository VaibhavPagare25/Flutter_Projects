import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/services/news_data.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ForYouTab extends StatefulWidget {
  const ForYouTab({super.key});

  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab> {
  bool loading = true;
  int activeIndex = 0;
  List<NewsModel> newsList = [];
  List<SliderModel> slider = [];
  @override
  void initState() {
    super.initState();
    getNews();
    getSlider();
  }

  void getNews() async {
    News obj = News();
    await obj.getData();
    newsList = obj.getNews;
    setState(() {
      loading = false;
    });
  }

  void getSlider() async {
    SliderClass obj = SliderClass();
    await obj.getSliderData();
    slider = obj.getSliderlList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          "Breaking News",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "View all",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CarouselSlider.builder(
                    itemCount: slider.length,
                    itemBuilder: (context, index, realIndex) {
                      String? image = slider[index].urlToImage;
                      String? name = slider[index].title;
                      String? newsUrl = slider[index].url;
                      return buildImage(image, name, newsUrl);
                    },
                    options: CarouselOptions(
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      // onPageChanged: (index, reason) {
                      //   setState(() {
                      //     activeIndex = index;
                      //   });
                      // },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // buildIndicator(activeIndex),
                  // const SizedBox(
                  //   height: 30,
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Trending News",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "View all",
                          style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          title: newsList[index].title!,
                          description: newsList[index].description!,
                          imageUrl: newsList[index].urlToImage!,
                          url: newsList[index].url!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildImage(String? image, String? name, String? newsUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsView(newsUrl: newsUrl!),
          ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: image!,
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              name!,
              maxLines: 2,
              style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int activeIndex) {
    return DotsIndicator(
      dotsCount: slider.length,
      position: activeIndex,
    );
  }
}

class BlogTile extends StatelessWidget {
  String title, description, imageUrl, url;
  BlogTile(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.url,
      super.key});

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
        padding: const EdgeInsets.all(10),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.0,
                      child: Text(
                        title,
                        maxLines: 2,
                        style: GoogleFonts.playfairDisplay(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.0,
                      child: Text(
                        description,
                        maxLines: 2,
                        style: GoogleFonts.playfairDisplay(
                          textStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
