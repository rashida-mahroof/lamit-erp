import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SizeWidget extends StatefulWidget {
  final int seconds;
  final String s;

  const SizeWidget(this.seconds, this.s);

  @override
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _sizeAnimation;

  bool reverse = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.seconds))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController!.repeat(reverse: !reverse);
          reverse = !reverse;
        }
      });

    _sizeAnimation =
        Tween<double>(begin: 50.0, end: 100.0).animate(_animationController!);
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation!,
      builder: (context, child) => Container(
        height: 90,
        width: 90,
        child: CachedNetworkImage(
          imageUrl: widget.s.toString(),
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      ),
    );
  }
}
