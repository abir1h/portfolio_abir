import 'package:flutter/material.dart';

import 'data/content_loader.dart';
import 'data/profile.dart';
import 'portfolio_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp(loader: PortfolioContentLoader()));
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, required this.loader});

  final PortfolioContentLoader loader;

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late Future<PortfolioData> _portfolioFuture;

  @override
  void initState() {
    super.initState();
    _portfolioFuture = widget.loader.load().timeout(
      const Duration(seconds: 6),
      onTimeout: () {
        debugPrint('Remote portfolio load timed out, using local fallback.');
        return PortfolioData.abir;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abir Rahman | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FutureBuilder<PortfolioData>(
        future: _portfolioFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Unable to load content. Showing base profile.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final data = snapshot.data ?? PortfolioData.abir;
          return PortfolioPage(data: data);
        },
      ),
    );
  }
}
