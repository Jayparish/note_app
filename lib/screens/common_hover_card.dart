import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class Commonhovercard extends StatefulWidget {
  final Widget? child;

  Commonhovercard({Key? key, this.child}) : super(key: key);

  @override
  State<Commonhovercard> createState() => _CommonhovercardState();
}

class _CommonhovercardState extends State<Commonhovercard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _animation;

  late Animation padding;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 275),
    );
    _animation = Tween(begin: 1.0, end: 2.5).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    padding = Tween(begin: 0.0, end: -25.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (value) {
          setState(() {
            _controller.forward();
          });
        },
        onExit: (value) {
          setState(() {
            _controller.reverse();
          });
        },
        child: Container(
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.hardEdge,
          transform: Matrix4(_animation.value, 0, 0, 0, 0, _animation.value, 0,
              0, 0, 0, 1, 0, padding.value, padding.value, 0, 1),
          child: widget.child,
        ));
  }
}
