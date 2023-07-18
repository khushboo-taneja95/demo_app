import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tres_connect/core/networking/urls.dart';

class PrivacyPolicyWebview extends StatelessWidget {
  const PrivacyPolicyWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(AppUrl.privacyPolicy)),
      ),
    );
  }
}
