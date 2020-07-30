import 'dart:async';

import 'package:blocks_puzzle/widgets/star_award.dart';
import 'package:flutter/material.dart';

class StarsCollectionAnimation extends StatefulWidget {
  _StarsCollectionAnimationState _starsCollectionAnimationState;
  bool isVisible = false;

  @override
  _StarsCollectionAnimationState createState() {
    _starsCollectionAnimationState = _StarsCollectionAnimationState();
    return _starsCollectionAnimationState;
  }

  void showAnimation() {
    isVisible = true;
    _starsCollectionAnimationState?.startAnimation();
  }

  void updateTargetPosition(Offset position) {
    _starsCollectionAnimationState?.updateTargetPosition(position);
  }
}

class _StarsCollectionAnimationState extends State<StarsCollectionAnimation>
    with TickerProviderStateMixin {
  Animation<Offset> slideAnimation;
  Animation bounceAnimation;
  AnimationController slideAnimationController, bounceAnimationController;

  Offset sourcePosition;
  Offset targetPosition;
  StarAward starAward = StarAward();

  @override
  void initState() {
    super.initState();

    bounceAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    bounceAnimation = CurvedAnimation(
        parent: bounceAnimationController, curve: Curves.bounceInOut);

    bounceAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          slideAnimation = Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-(sourcePosition.dx - targetPosition.dx) / 95,
                      -(sourcePosition.dy - targetPosition.dy) / 95))
              .animate(CurvedAnimation(
                  parent: slideAnimationController,
                  curve: Curves.easeInOutSine));
          slideAnimationController.forward();
        });
      }
    });

    slideAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: slideAnimationController, curve: Curves.easeInOutSine));

    slideAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        starAward?.setVisibility(false);
        slideAnimationController.reverse();
      }
    });
  }

  void getWidgetPositions() {
    setState(() {
      sourcePosition = starAward.getPosition();
      //targetPosition = widget.starsCounter.getPosition();
    });
  }

  void updateTargetPosition(Offset position) {
    targetPosition = position;
  }

  @override
  void dispose() {
    bounceAnimationController.dispose();
    slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: StarTransition(
        animation: bounceAnimation,
        widget: SlideTransition(
          position: slideAnimation,
          child: starAward,
        ),
      ),
    );
  }

  void startAnimation() {
    starAward?.setVisibility(true);
    Timer(Duration(milliseconds: 100), getWidgetPositions);
    setState(() {
      bounceAnimationController.value = 0.0;
      bounceAnimationController.forward();
    });
  }
}

class StarTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget widget;

  StarTransition({this.animation, this.widget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          child: widget,
          builder: (context, child) {
            return Container(
              width: 45.0 + animation.value * 50,
              height: 45.0 + animation.value * 50,
              child: child,
            );
          }),
    );
  }
}
