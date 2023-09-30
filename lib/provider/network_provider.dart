import 'package:flutter_news_reader/data/services/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkProvider
{
  static final networkProvider = Provider<ApiServices>((ref) => ApiServices());
}