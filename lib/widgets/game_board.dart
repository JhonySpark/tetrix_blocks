import 'dart:math';

import 'package:blocks_puzzle/common/utils.dart';
import 'package:blocks_puzzle/widgets/block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double margin = 8.0;

class GameBoard extends StatefulWidget {
  _GameBoardState _gameBoardState;

  final BlockPlacedCallback blockPlacedCallback;
  final OutOfBlocksCallback outOfBlocksCallback;
  final RowsClearedCallback rowsClearedCallback;

  GameBoard(
      {this.blockPlacedCallback,
      this.outOfBlocksCallback,
      this.rowsClearedCallback});

  @override
  _GameBoardState createState() {
    _gameBoardState = _GameBoardState();
    return _gameBoardState;
  }

  void onBlockDropped(
      BlockType blockType, Color blockColor, Offset blockPosition) {
    _gameBoardState?.onBlockDropped(blockType, blockColor, blockPosition);
  }

  void setAvailableDraggableBlocks(List<Block> availableDraggableBlocks) {
    _gameBoardState?.computeAvailableBlocks(availableDraggableBlocks);
  }
}

class _GameBoardState extends State<GameBoard> {
  int numOfColumns;
  List<Block> cells = <Block>[];
  List<Color> cellColorsList = <Color>[];
  List<int> cellsToClear = <int>[];
  List<Rect> gridBlockRectangleList;
  int matchedRows = 0;

  void computeAvailableBlocks(List<Block> availableDraggableBlocks) {
    bool outOfBlocks = true;
    for (Block draggableBlock in availableDraggableBlocks) {
      int numOfChildBlocks = getUnitBlocksCount(draggableBlock.blockType);

      List<int> cellsToFill;
      for (Rect gridBlockRectangle in gridBlockRectangleList) {
        cellsToFill = computeFillableGridBlockPositions(numOfChildBlocks,
            draggableBlock.blockType, gridBlockRectangle.topLeft);
        if (numOfChildBlocks <= cellsToFill.length) {
          outOfBlocks = false;
          break;
        }
      }
      if (!outOfBlocks) {
        break;
      }
    }

    if (outOfBlocks && widget.outOfBlocksCallback != null) {
      widget.outOfBlocksCallback(context);
    }
  }

  void onBlockDropped(
      BlockType blockType, Color blockColor, Offset blockPosition) {
    cellsToClear.clear();

    int numOfChildBlocks = getUnitBlocksCount(blockType);

    //Find the grid block positions where the dragged blocks can be placed
    List<int> cellsToFill = computeFillableGridBlockPositions(
        numOfChildBlocks, blockType, blockPosition);

    //Color the blocks with the dragged ones
    if (cellsToFill.length == numOfChildBlocks) {
      for (int index in cellsToFill) {
        cellColorsList[index] = blockColor;
      }

      if (widget.blockPlacedCallback != null) {
        widget.blockPlacedCallback(blockType);
      }
      setState(() {});
      clearFilledRows();
    }
  }

  //Clear the filled lines horizontally and vertically
  void clearFilledRows() {
    findHorizontallyFilledRows();
    findVerticallyFilledRows();
    if (cellsToClear.isNotEmpty) {
      if (widget.rowsClearedCallback != null && matchedRows > 0) {
        widget.rowsClearedCallback(matchedRows);
      }
      matchedRows = 0;
      for (int counter in cellsToClear) {
        cellColorsList[counter] = emptyCellColor;
      }
      cellsToClear.clear();
      setState(() {});
    }
  }

  void findHorizontallyFilledRows() {
    List<int> tempList = <int>[];
    int matchedRow = -1;
    for (int row = 0; row < numOfColumns; row++) {
      tempList.clear();
      matchedRow = row;
      for (int col = 0; col < numOfColumns; col++) {
        if (cellColorsList[col + row * numOfColumns] == emptyCellColor) {
          matchedRow = -1;
          tempList.clear();
          break;
        }
        tempList.add(col + row * numOfColumns);
      }
      if (matchedRow >= 0) {
        matchedRows++;
        cellsToClear.addAll(tempList);
      }
    }
  }

  void findVerticallyFilledRows() {
    List<int> tempList = <int>[];
    int matchedRow = -1;
    for (int row = 0; row < numOfColumns; row++) {
      tempList.clear();
      matchedRow = row;
      for (int col = row;
          col < numOfColumns * numOfColumns;
          col += numOfColumns) {
        if (cellColorsList[col] == emptyCellColor) {
          matchedRow = -1;
          tempList.clear();
          break;
        }
        tempList.add(col);
      }
      if (matchedRow >= 0) {
        matchedRows++;
        cellsToClear.addAll(tempList);
      }
    }
  }

  List<int> computeFillableGridBlockPositions(
      int numOfChildBlocks, BlockType blockType, Offset droppedBlockPosition) {
    Rect gridBlockRectangle;
    List<int> cellsToFill = <int>[];
    List<Rect> droppedBlockRects =
        getDroppedBlocks(blockType, droppedBlockPosition);

    for (Rect droppedBlockRect in droppedBlockRects) {
      double maxIntersection = 0.0;
      int matchedIndex = -1;
      if (cellsToFill.length == numOfChildBlocks) {
        break;
      }
      for (int col = 0; col < gridBlockRectangleList.length; col++) {
        gridBlockRectangle = gridBlockRectangleList[col];

        if (droppedBlockRect.overlaps(gridBlockRectangle)) {
          Rect intersect = droppedBlockRect.intersect(gridBlockRectangle);
          double overlapArea = intersect.width * intersect.height;
          if (maxIntersection == 0.0 || overlapArea >= maxIntersection) {
            matchedIndex = col;
          }
          maxIntersection = max(overlapArea, maxIntersection);
        }
      }
      if (matchedIndex >= 0 &&
          cellColorsList[matchedIndex] == emptyCellColor &&
          !cellsToFill.contains(matchedIndex)) {
        cellsToFill.add(matchedIndex);
      }
    }
    return cellsToFill;
  }

  @override
  Widget build(BuildContext context) {
    computeCells();
    return _createGrid();
  }

  Widget _createGrid() {
    return Container(
        width: numOfColumns * blockUnitSizeWithPadding,
        height: numOfColumns * blockUnitSizeWithPadding,
        margin: EdgeInsets.all(margin),
        child: Table(
          children: _createGridCells(),
        ));
  }

  void computeCells() {
    if (numOfColumns == null) {
      double maxDimen = min(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height);
      numOfColumns = (maxDimen - margin * 4) ~/ blockUnitSizeWithPadding;
      for (int i = 0; i < numOfColumns * numOfColumns; i++) {
        cellColorsList.add(emptyCellColor);
      }
    }
    cells.clear();
    for (int row = 0; row < numOfColumns * numOfColumns; row++) {
      cells.add(Block(BlockType.SINGLE, cellColorsList[row]));
    }

    gridBlockRectangleList = <Rect>[];
    for (int col = 0; col < cells.length; col++) {
      gridBlockRectangleList.add(Rect.fromLTWH(
          col % numOfColumns * blockUnitSizeWithPadding,
          col ~/ numOfColumns * blockUnitSizeWithPadding,
          blockUnitSize,
          blockUnitSize));
    }
  }

  List<TableRow> _createGridCells() {
    List<TableRow> rows = <TableRow>[];
    for (int row = 0; row < numOfColumns; row++) {
      rows.add(TableRow(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getRow(row),
        ),
      ]));
    }
    return rows;
  }

  List<Widget> getRow(int rowIdx) {
    List<Widget> row = <Widget>[];
    for (int col = 0; col < numOfColumns; col++) {
      row.add(cells[rowIdx * numOfColumns + col]);
    }
    return row;
  }

  List<Rect> getDroppedBlocks(
      BlockType blockType, Offset droppedBlockPosition) {
    List<Rect> droppedBlocks = <Rect>[];
    RenderBox getBox = context.findRenderObject();
    droppedBlockPosition =
        getBox.globalToLocal(droppedBlockPosition) - Offset(margin, margin);
    switch (blockType) {
      case BlockType.SINGLE:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        break;
      case BlockType.DOUBLE:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.LINE_HORIZONTAL:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + 2 * blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.LINE_VERTICAL:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + 2 * blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.SQUARE:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.TYPE_T:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + 2 * blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        /*  droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + 2 * blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize)); */
        break;
      case BlockType.TYPE_L:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + 2 * blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + 2 * blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.MIRRORED_L:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + 2 * blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.TYPE_Z:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + 2 * blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
      case BlockType.TYPE_S:
        droppedBlocks.add(Rect.fromLTWH(droppedBlockPosition.dx + blockUnitSize,
            droppedBlockPosition.dy, blockUnitSize, blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + 2 * blockUnitSizeWithPadding,
            droppedBlockPosition.dy,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        droppedBlocks.add(Rect.fromLTWH(
            droppedBlockPosition.dx + blockUnitSizeWithPadding,
            droppedBlockPosition.dy + blockUnitSizeWithPadding,
            blockUnitSize,
            blockUnitSize));
        break;
    }
    return droppedBlocks;
  }
}
