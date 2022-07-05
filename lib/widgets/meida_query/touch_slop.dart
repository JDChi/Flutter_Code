import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 通过修改 [MediaQuery] 里的 [DeviceGestureSettings]，来调整不同滑动 Widget 的滑动距离，
/// 参考 [Flutter 小技巧之 ListView 和 PageView 的各种花式嵌套](https://juejin.cn/post/7116267156655833102#heading-0)
///
/// [ListView] 和 [PageView] 这些底层的实现都是 [Scrollable]，进一步的，是通过其里面的 [VerticalDragGestureRecognizer] 和 [HorizontalDragGestureRecognizer] 来处理，
/// 在这些手势里，会有个是否滑动的最小距离判断，（通过重写 [DragGestureRecognizer] 里的 `isFlingGesture` 方法），
/// 在 `isFlingGesture` 方法里，如果没有给属性 `minFlingDistance` 赋值，则会使用 [computeHitSlop] 进行计算，
/// 它会先判断 [DeviceGestureSettings] 里的 touchSlop，没有的话会使用 [kTouchSlop]
/// 因此我们可以通过在这些滑动的 Widget 上嵌套 [MediaQuery] 来修改相应的属性

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

  Widget _myListView() {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
            gestureSettings:
                const DeviceGestureSettings(touchSlop: kTouchSlop)),
        child: ListView.builder(itemBuilder: (context, index) {
          return Container(
            height: 30,
            color: Colors.amber,
            child: Text('$index'),
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
            gestureSettings: const DeviceGestureSettings(touchSlop: 50)),
        child: PageView(
          children: [
            _myListView(),
            _myListView(),
          ],
        ),
      ),
    );
  }
}
