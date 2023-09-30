class Urls {
  Urls._();
  static  const String _apiKey = '1b0c488189474d3a83eca7bab5e2b77b';
  static  const String _apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';
  static  String getNews = _apiUrl+_apiKey;
}