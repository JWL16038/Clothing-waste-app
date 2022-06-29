import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;

  SlideRoute({required this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
//asdfdasf
