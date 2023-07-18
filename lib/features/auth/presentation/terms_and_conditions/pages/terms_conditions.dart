import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tres_connect/core/networking/urls.dart';

class TermsAndConditionWebview extends StatelessWidget {
  const TermsAndConditionWebview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Services'),
      ),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse(AppUrl.Terms_And_Condition_URL)),
      ),
    );
  }
}
