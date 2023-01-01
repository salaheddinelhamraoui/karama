import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app_theme.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 60,
          ),
        ),
      ),
    );
  }
}
