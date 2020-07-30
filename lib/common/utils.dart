import 'dart:ui';

import 'package:blocks_puzzle/widgets/block.dart';
import 'package:flutter/material.dart';

const Color screenBgColor = Color(0xFF2B2236);
const Color emptyCellColor = Color(0xFF392933);
const double draggableBlockSize = 30.0;
const double blockUnitSize = 35.0;
const double blockUnitSizeWithPadding = blockUnitSize + 2.0;
const int pointsPerMatchedRow = 10;
const int pointsPerBlockUnitPlaced = 1;

typedef BlockPlacedCallback = void Function(BlockType blockType);
typedef OutOfBlocksCallback = void Function(BuildContext context);
typedef RowsClearedCallback = void Function(int numOfLines);
typedef PlayCallback = void Function();
typedef GameStateCallback = void Function(
    BuildContext context, GameState state);

enum GameState { PLAY, PAUSE }

int getUnitBlocksCount(BlockType blockType) {
  switch (blockType) {
    case BlockType.SINGLE:
      return 1;
    case BlockType.DOUBLE:
      return 2;
    case BlockType.LINE_HORIZONTAL:
    case BlockType.LINE_VERTICAL:
      return 3;
    case BlockType.SQUARE:
    case BlockType.TYPE_L:
    case BlockType.MIRRORED_L:
    case BlockType.TYPE_Z:
    case BlockType.TYPE_S:
      return 4;
    case BlockType.TYPE_T:
      return 4;
    default:
      return 0;
  }
}
