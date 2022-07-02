import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 自定义实现一个 TextInputFormatter，
///
/// 官方有提供 FilteringTextInputFormatter 用于允许和禁止输入某些字符
/// 还有 LengthLimitingTextInputFormatter 用于限制字符长度
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
      body: Center(
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [_RangeInputFormatter(start: 0, end: 99)],
        ),
      ),
    );
  }
}

/// 输入范围限制的 TextInputFormatter
class _RangeInputFormatter extends TextInputFormatter {
  final int start;
  final int end;

  _RangeInputFormatter({this.start = 0, this.end = 0});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newNum = int.tryParse(newValue.text);
    if (newNum != null) {
      if (newNum >= start && newNum <= end) {
        return newValue;
      } else {
        return oldValue;
      }
    }
    return newValue;
  }
}
