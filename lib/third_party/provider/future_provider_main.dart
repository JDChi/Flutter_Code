import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// FutureProvider 的用法
///
/// 需要给定 initialData 且不为 null，并且在 create 参数里提供 Future 方法
/// 这里只会执行一次，如果想要再次刷新数据的方式，需要使用其它方法
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  _MyHomePage({Key? key}) : super(key: key);
  final futureModel = FutureModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureProvider<String>(
          initialData: futureModel.data,
          create: (context) => futureModel.updateData(),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.watch<String>()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FutureModel {
  String data = 'data';

  Future<String> updateData() async {
    await Future.delayed(const Duration(seconds: 2));
    data = "hello";
    return data;
  }
}
