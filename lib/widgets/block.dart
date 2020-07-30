import 'package:blocks_puzzle/common/utils.dart';
import 'package:blocks_puzzle/views/shape_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef BlockDroppedCallback = void Function(
    BlockType blockType, Color blockColor, Offset blockPosition);

class Block extends StatefulWidget {
  final Color color;
  final double blockSize;
  final BlockType blockType;
  final BlockDroppedCallback blockDroppedCallback;
  final bool draggable;

  Block(this.blockType, this.color,
      {this.blockDroppedCallback,
        this.draggable = false,
        this.blockSize = blockUnitSize});

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    if (widget.draggable) {
      return Draggable(
        childWhenDragging: Container(),
        child: _createBlock(widget.color, widget.blockType, widget.blockSize),
        feedback: _createBlock(
            widget.color.withOpacity(0.8), widget.blockType, blockUnitSize),
        onDragEnd: _handleDragEnded,
      );
    } else {
      return _createBlock(widget.color, widget.blockType, widget.blockSize);
    }
  }

  void _handleDragEnded(DraggableDetails draggableDetails) {
    if (widget.blockDroppedCallback != null) {
      widget.blockDroppedCallback(
          widget.blockType, widget.color, draggableDetails.offset);
    }
  }

  Widget _createBlock(Color color, BlockType blockType, double blockSize) {
    return Container(
        margin: EdgeInsets.all(1.0),
        width: _getBlockContainerWidth(blockType),
        height: _getBlockContainerHeight(blockType),
        child: CustomPaint(
          painter:
          BlockShaper(shape: blockType, color: color, unitSize: blockSize),
        ));
  }

  double _getBlockContainerWidth(BlockType blockType) {
    double width = widget.blockSize;
    switch (blockType) {
      case BlockType.SINGLE:
      case BlockType.LINE_VERTICAL:
        break;
      case BlockType.DOUBLE:
      case BlockType.SQUARE:
      case BlockType.TYPE_L:
      case BlockType.MIRRORED_L:
        width = width * 2;
        break;
      case BlockType.LINE_HORIZONTAL:
      case BlockType.TYPE_T:
      case BlockType.TYPE_Z:
      case BlockType.TYPE_S:
        width = width * 3;
        break;
    }
    return width;
  }

  double _getBlockContainerHeight(BlockType blockType) {
    double height = widget.blockSize;
    switch (blockType) {
      case BlockType.SINGLE:
      case BlockType.DOUBLE:
      case BlockType.LINE_HORIZONTAL:
        break;
      case BlockType.SQUARE:
      case BlockType.TYPE_Z:
      case BlockType.TYPE_S:
        height = height * 2;
        break;
      case BlockType.LINE_VERTICAL:
      case BlockType.TYPE_T:
      case BlockType.TYPE_L:
      case BlockType.MIRRORED_L:
        height = height * 3;
        break;
    }
    return height;
  }
}

enum BlockType {
  SINGLE,
  DOUBLE,
  LINE_HORIZONTAL,
  LINE_VERTICAL,
  SQUARE,
  TYPE_T,
  TYPE_L,
  MIRRORED_L,
  TYPE_Z,
  TYPE_S
}
