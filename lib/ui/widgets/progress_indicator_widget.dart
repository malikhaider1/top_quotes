import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class KProgressIndicator extends StatelessWidget {
  const KProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 35.0,
      color: Theme.of(context).colorScheme.primary,
      duration: const Duration(milliseconds: 1200),
    );
  }
}
