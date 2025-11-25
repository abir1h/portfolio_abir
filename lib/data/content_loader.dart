import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'profile.dart';

class PortfolioContentLoader {
  const PortfolioContentLoader({
    this.assetPath = 'assets/content/portfolio.json',
  });

  final String assetPath;

  Future<PortfolioData> load() async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      final dynamic parsed = jsonDecode(jsonString);
      if (parsed is Map<String, dynamic>) {
        return PortfolioData.fromJson(parsed);
      }
    } catch (_) {
      // Fall back to the embedded profile if parsing fails for any reason.
    }
    return PortfolioData.abir;
  }
}
