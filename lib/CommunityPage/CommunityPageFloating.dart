
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themeData.dart';
import 'CommunityPageCreatePost.dart';

class CommunityPageFloating extends StatelessWidget {
  final Map<String,dynamic> keywords;
  final String type;

  const CommunityPageFloating(
      {Key? key, required this.type, required this.keywords,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "ReadPost" ?
    Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: MainColor.three,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.to(() => CommunityPageCreatePost(keywords:keywords, type: type,));
          },
          icon: const Text("답글"),
    ),)
     :Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: MainColor.three,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.to(() => CommunityPageCreatePost(keywords:keywords, type: type,));
          },
          icon: Image.asset("assets/images/create.png")),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'CommunityPageCreatePost.dart';

@immutable
class CommunityPageFloating extends StatelessWidget {
  final String id;
  final String type;
  final String title;
  const CommunityPageFloating({Key? key, required this.id, required this.type, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Floating(
      distance: 0,
      children: [
        Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: Colors.indigo,
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () { Get.to(() => CommunityPageCreatePost(id: id,type: type,title: title,));},
                icon: Image.asset("assets/images/create.png"))
        ),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {}, //Get.to(()=>const CommunityPageChatList()),
              icon: Image.asset("assets/images/chat.png")),
        ),
      ],
    );
  }
}

@immutable
class Floating extends StatefulWidget {
  const Floating({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _FloatingState createState() => _FloatingState();
}

class _FloatingState extends State<Floating>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildFloatingButton(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingButton() {
    final children = <Widget>[];
    final count = widget.children.length;
    for (var i = 0, angleInDegrees = 90.0, height = 60.0;
    i < count;
    i++, height += 60) {
      children.add(
        _FloatingButton(
          height: height,
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 200),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: _toggle,
            child: const Icon(
              Icons.create,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.height,
  }) : super(key: key);

  final double height;
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: height,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.image,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.indigo,
      elevation: 4.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: image,
        color: Colors.white,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}

*/
