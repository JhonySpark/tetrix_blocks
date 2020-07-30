import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class StarAward extends StatefulWidget {
  _StarAwardState _starAwardState;

  Offset getPosition() {
    return _starAwardState?.getPosition();
  }

  void refresh() {
    _starAwardState?.refresh();
  }

  void setVisibility(bool visibility) {
    _starAwardState?.setVisibility(visibility);
  }

  @override
  _StarAwardState createState() {
    _starAwardState = _StarAwardState();
    return _starAwardState;
  }
}

class _StarAwardState extends State<StarAward> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SvgPicture.asset(
        'assets/images/ic_glittering_star.svg',
      ),
    );
  }

  Offset getPosition() {
    RenderBox renderbox = context.findRenderObject();
    return renderbox.localToGlobal(Offset.zero);
  }

  void refresh() {
    setState(() {});
  }

  void setVisibility(bool visibility) {
    isVisible = visibility;
    setState(() {});
  }
}
