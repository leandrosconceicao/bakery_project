import 'package:bakery/libraries/views.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoadingWarning extends StatelessWidget {
  const LoadingWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      scrollable: true,
      title: Text('Atenção'),
      content: LinearProgressIndicator(),
    );
  }

  static show() {
    Get.dialog(const LoadingWarning(), barrierDismissible: false);
  }
}