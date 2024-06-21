import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/models/tabs_model.dart';

class TabsNews {
  List<TabNewsModel> getTabNewsList = [];

  Future<void> getTabData(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=3145f4bcfaa445ad89eb03e8e17a0d1c";
    http.Response response = await http.get(Uri.parse(url));
    log(response.body);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          TabNewsModel tabNewsObj = TabNewsModel(
            author: element['author'],
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          getTabNewsList.add(tabNewsObj);
        }
      });
    }
  }
}
