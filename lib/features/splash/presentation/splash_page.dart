import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:meme_factory/core/constants/assets.dart';
import 'package:meme_factory/features/memes/presentation/page/meme_list_page.dart';

class SplashPage extends StatefulWidget {
  static const String path = '/splash_page';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      context.push(MemeListPage.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Assets
            .animationsMemesLoading, // Replace with your local Lottie animation file
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      ),
    );
  }
}
