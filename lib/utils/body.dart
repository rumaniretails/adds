import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/utils/adoptify_loader.dart';
import 'package:templering/utils/color.dart';

class Body extends StatelessWidget {
  final Widget child;
  final RxBool isLoading;

  const Body({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Obx(() => LoaderWidget(color: adoptifyPrimaryColor)
              .center()
              .visible(isLoading.value)),
        ],
      ),
    );
  }
}
