import 'package:flutter/material.dart';

/// 使用 CustomPainter 实现高亮某个部分的效果
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Hello World'),
                Padding(padding: EdgeInsets.only(left: 16)),
                Icon(Icons.star)
              ],
            ),
          ),
          CustomPaint(
            painter: HighLightPainter(),
          )
        ],
      ),
    );
  }
}

class HighLightPainter extends CustomPainter {
  final _paint = Paint()..color = Colors.black.withOpacity(0.3);

  @override
  void paint(Canvas canvas, Size size) {
    final mediaQueryData =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    // 背景
    final backgroundRect = Rect.fromLTWH(
        0,
        0,
        WidgetsBinding.instance!.window.physicalSize.width,
        WidgetsBinding.instance!.window.physicalSize.height);
    // 高亮
    final highLightRect = Rect.fromLTWH((mediaQueryData.size.width / 2 + 20),
        (mediaQueryData.size.height / 2 - 24), 48, 48);
    final backgroundPath = Path()..addRect(backgroundRect);
    final highLightPath = Path()..addOval(highLightRect);
    final resultPath = Path.combine(
        PathOperation.reverseDifference, highLightPath, backgroundPath);
    canvas.drawPath(resultPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
