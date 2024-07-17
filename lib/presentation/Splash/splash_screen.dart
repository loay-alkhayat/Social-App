import 'package:flutter/material.dart';

import '../../../Shared/resources/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}
