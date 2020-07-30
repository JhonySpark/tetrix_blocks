import 'package:blocks_puzzle/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

const cornerRadius = Radius.circular(5.0);

class BlockShaper extends CustomPainter {
  final BlockType shape;
  final Color color;
  final double unitSize;
  final double padding;

  const BlockShaper(
      {@required this.shape,
      @required this.color,
      this.unitSize = 16.0,
      this.padding = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    var blockPaint = Paint()..color = color;
    switch (this.shape) {
      case BlockType.SINGLE:
        canvas.drawRRect(
            _createBlockUnit(0.0, 0.0, unitSize, unitSize), blockPaint);
        break;
      case BlockType.DOUBLE:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        break;
      case BlockType.LINE_HORIZONTAL:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block2.right + padding, block1.top, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        break;
      case BlockType.LINE_VERTICAL:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.left, block1.bottom + padding, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block1.left, block2.bottom + padding, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        break;
      case BlockType.SQUARE:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block1.left, block1.bottom + padding, unitSize, unitSize);
        var block4 = _createBlockUnit(
            block3.right + padding, block3.top, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        canvas.drawRRect(block4, blockPaint);
        break;
      case BlockType.TYPE_T:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(block1.right + padding, block1.top, unitSize, unitSize);
        var block3 = _createBlockUnit(block2.right + padding, block2.top, unitSize, unitSize);
        var block4 = _createBlockUnit(block2.left, block2.bottom + padding, unitSize, unitSize);
       /*  var block5 = _createBlockUnit(block2.left, block4.bottom + padding, unitSize, unitSize); */
        
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        canvas.drawRRect(block4, blockPaint);
       /*  canvas.drawRRect(block5, blockPaint); */
        break;
      case BlockType.TYPE_L:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.left, block1.bottom + padding, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block1.left, block2.bottom + padding, unitSize, unitSize);
        var block4 = _createBlockUnit(
            block3.right + padding, block3.top, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        canvas.drawRRect(block4, blockPaint);
        break;
      case BlockType.MIRRORED_L:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        var block4 = _createBlockUnit(
            block2.left, block2.bottom + padding, unitSize, unitSize);
        var block5 = _createBlockUnit(
            block4.left, block4.bottom + padding, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block5, blockPaint);
        canvas.drawRRect(block4, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        break;
      case BlockType.TYPE_Z:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        var block5 = _createBlockUnit(
            block2.right + padding, block2.top, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block1.left, block1.bottom + padding, unitSize, unitSize);
        var block4 = _createBlockUnit(
            block3.right + padding, block3.top, unitSize, unitSize);
        var block6 = _createBlockUnit(
            block4.right + padding, block4.top, unitSize, unitSize);
        canvas.drawRRect(block1, blockPaint);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block5, Paint()
          ..color = Colors.transparent);
        canvas.drawRRect(block3, Paint()
          ..color = Colors.transparent);
        canvas.drawRRect(block4, blockPaint);
        canvas.drawRRect(block6, blockPaint);
        break;
      case BlockType.TYPE_S:
        var block1 = _createBlockUnit(0.0, 0.0, unitSize, unitSize);
        var block2 = _createBlockUnit(
            block1.right + padding, block1.top, unitSize, unitSize);
        var block5 = _createBlockUnit(
            block2.right + padding, block2.top, unitSize, unitSize);
        var block3 = _createBlockUnit(
            block1.left, block1.bottom + padding, unitSize, unitSize);
        var block4 = _createBlockUnit(
            block3.right + padding, block3.top, unitSize, unitSize);
        var block6 = _createBlockUnit(
            block4.right + padding, block4.top, unitSize, unitSize);
        canvas.drawRRect(block1, Paint()
          ..color = Colors.transparent);
        canvas.drawRRect(block2, blockPaint);
        canvas.drawRRect(block5, blockPaint);
        canvas.drawRRect(block3, blockPaint);
        canvas.drawRRect(block4, blockPaint);
        canvas.drawRRect(block6, Paint()
          ..color = Colors.transparent);
        break;
    }
  }

  @override
  bool shouldRepaint(BlockShaper box) {
    return shape != box.shape;
  }

  RRect _createBlockUnit(double left, double top, double width, double height) {
    return RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, width, height), cornerRadius);
  }
}
