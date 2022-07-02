/// 演示了如何根据条件来导包，import 和 export 同样的用法
///
/// 这里创建了两个相同命名的 MyContainer Widget，在使用的时候，可以 import ‘condition.dart’，由这里来决定根据平台使用哪个实现
///
/// [Creating packages](https://dart.dev/guides/libraries/create-library-packages)
export 'mobile_package.dart' if (dart.library.html) 'web_package.dart';
