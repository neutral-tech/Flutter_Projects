import 'dart:convert';

import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<NewsModel> news= <NewsModel>[];

  Future<void> getNews() async{
    var url=Uri.parse('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=1dcb8ba6cfa344e98fd508abe207b055');
    var response=await http.get(url);
    var data=jsonDecode(response.body);
    if(data['status']=="ok"){
      data['articles'].forEach((abc){
          if(abc['urlToImage']!=null&&abc['description']!=null){
            NewsModel newsModel=NewsModel(
               title: abc['title'],
              author: abc['author'],
              description: abc['description'],
              url: abc['url'],
              urlToImage: abc['urlToImage'],
              content: abc['content'],
            );
            news.add(newsModel);
          }
      });
    }
    return;
  }

}