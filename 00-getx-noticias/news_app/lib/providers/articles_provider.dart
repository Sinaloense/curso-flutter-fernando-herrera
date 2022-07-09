import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:news_app/models/models.dart';

class ArticlesProvider extends GetConnect {
  @override
  void onInit() {
    debugPrint('ArticlesProivder onInit');
  }

  Future<List<Article>> getArticlesByCategory(String category) async {
    final resp = await get('https://newsapi.org/v2/top-headlines?country=mx&category=business&apiKey=9ea00ae7f3184781aa9f52edb4ebda9b');

    final newsResponse = NewsResponse.fromMap(resp.body);

    return newsResponse.articles;
  }
}