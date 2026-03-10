import 'package:flutter/material.dart';

class PageTransition {

  static Route slide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;

        const curve = Curves.easeOutCubic;

        final slideTween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        final scaleTween = Tween(begin: 0.96, end: 1.0)
            .chain(CurveTween(curve: curve));

        final fadeTween = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: ScaleTransition(
              scale: animation.drive(scaleTween),
              child: child,
            ),
          ),
        );
      },
    );
  }
}