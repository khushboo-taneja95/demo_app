// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:tres_connect/core/bloc/bloc.dart';
// import 'package:tres_connect/core/networking/urls.dart';
// import 'package:tres_connect/features/main/presentation/healthinsight/bloc/bloc/web_view_bloc.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:tres_connect/features/main/presentation/healthinsight/bloc/healthinsight_bloc.dart';

// class HealthInsightPage extends StatelessWidget {
//   const HealthInsightPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HealthinsightBloc(),
//       child: Scaffold(
//         body: HealthInsightBody(),
//       ),
//     );
//   }
// }

// class HealthInsightBody extends StatelessWidget {
//   HealthInsightBody({super.key});

//   WebViewController? webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WebViewBloc, WebViewState>(
//       builder: (context, state) {
//         if (state is WebViewLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ),
//           );
//         } else if (state is WebViewErrorState) {
//           return Center(
//             child: Text(state.message),
//           );
//         } else {
//           return InAppWebView(
//             initialUrlRequest:
//                 URLRequest(url: Uri.parse(AppUrl.healthInsightUrl)),
//             onLoadStart: (controller, url) {
//               BlocProvider.of<WebViewBloc>(context).add(WebViewLoading());
//             },
//             onLoadStop: (controller, url) {
//               BlocProvider.of<WebViewBloc>(context).add(WebViewLoaded());
//             },
//             onLoadError: (controller, url, code, message) {
//               BlocProvider.of<WebViewBloc>(context)
//                   .add(WebViewError(message: message));
//             },
//           );
//         }
//       },
//     );
//   }
// }
