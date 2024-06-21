import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class News {
  List<NewsModel> getNews = [];

  Future<void> getData() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-05-21&sortBy=publishedAt&apiKey=3145f4bcfaa445ad89eb03e8e17a0d1c";
    http.Response response = await http.get(Uri.parse(url));
    log(response.body);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel newsObj = NewsModel(
            author: element['author'],
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          getNews.add(newsObj);
        }
      });
    }
  }
}
