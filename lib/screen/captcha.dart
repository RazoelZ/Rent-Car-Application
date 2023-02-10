import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class pagege extends StatefulWidget {
  const pagege({super.key});

  @override
  State<pagege> createState() => _pagegeState();
}

class _pagegeState extends State<pagege> {
  @override
  Widget build(BuildContext context) {
    return WebViewPlus(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: ((controllerPlus) {
        controllerPlus.loadUrl("assets/webpage/index.html");
      }),
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'Captcha',
            onMessageReceived: (JavascriptMessage message) {
              print(message.message);
            }),
      ]),
    );
  }
}
