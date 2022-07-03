import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

/// Nested 的使用
///
/// Nested 是为了解决多层嵌套的显示问题。一般来说，我们遇到多层嵌套的时候，会出现以下的写法：
///
/// ```dart
/// MyWidget(
///   child: AnotherWidget(
///     child: Again(
///       child: AndAgain(
///         child: Leaf(),
///       )
///     )
///   )
/// )
/// ```
///
/// 但如果使用了 Nested，就可以改成如下：
/// ```dart
/// Nested(
///   children: [
///     MyWidget(),
///     AnotherWidget(),
///     Again(),
///     AndAgain(),
///   ],
///   child: Leaf(),
/// ),
/// ```
///
/// Provider 框架就是借助 Nested 来实现
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

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  /// 为了使用 Nested，我们需要它的 children 实现 SingleChildWidget 接口，
  /// 但一般我们是继承 SingleChildStatelessWidget 或 SingleChildStatefulWidget
  /// 当运行下面这个例子的时候，我们会发现 Nested 下 child 里的 Text 没有显示，因为它没有被挂载到树上
  /// 原因在于 Nested 会将 children 进行翻转遍历，由于 MyContainer1 并没有使用到 child
  /// 而 MyContainer 里的 child 其实是 MyContainer1，所以通过调试我们可以看到，虽然 MyContainer1 里有 Text 的信息，
  /// 但 Text 却因没有被用到，所以不会被 mount 上。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Nested(
          children: const [MyContainer(), MyContainer1()],
          child: const Text('hello'),
        ),
      ),
    );
  }
}

class MyContainer extends SingleChildStatelessWidget {
  const MyContainer({Key? key}) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      color: Colors.yellow,
      child: child,
    );
  }
}

class MyContainer1 extends SingleChildStatelessWidget {
  const MyContainer1({Key? key}) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.blue.withOpacity(0.5),
    );
  }
}
