import 'dart:math';

import 'package:app_listview/widgets/draggable_listview.dart';
import 'package:flutter/material.dart';

class DraggableListener extends StatefulWidget {
  const DraggableListener({super.key});

  @override
  State<DraggableListener> createState() => _DraggableListviewState();
}

class _DraggableListviewState extends State<DraggableListener> {
  final ScrollController _scrollController = ScrollController();
  bool _pointerDown = false;
  double? _pointerYPosition;
  bool _scrolling = false;

  final _pageKey = const PageStorageKey<String>('projects');

  final int _duration = 30;
  final int _scrollAreaSize = 50;
  final double _overDragMax = 20.0;
  final double _overDragCoefficient = 3.0;

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (event) {
        _pointerDown = false;
      },
      onPointerDown: (event) {
        _pointerDown = true;
        _pointerYPosition = event.position.dy;
      },
      onPointerMove: (event) {
        if (_pointerDown) {
          _pointerYPosition = event.position.dy;

          _scrollList();
        }
      },
      child: DraggableListview(
        pageKey: _pageKey,
        scrollController: _scrollController,
      ),
    );
  }

  _scrollList() async {
    if (!_scrolling && _pointerDown && _pointerYPosition != null) {
      double? newOffset;

      var renderObject = context.findRenderObject()! as RenderBox;
      Size size = renderObject.size;

      var topLeftOffset = renderObject.localToGlobal(Offset.zero);

      var bottomRightOffset =
          renderObject.localToGlobal(size.bottomRight(Offset.zero));

      newOffset = _scrollListVertical(topLeftOffset, bottomRightOffset);

      if (newOffset != null) {
        _scrolling = true;
        await _scrollController.animateTo(newOffset,
            duration: Duration(milliseconds: _duration), curve: Curves.linear);
        _scrolling = false;
        if (_pointerDown) _scrollList();
      }
    }
  }

  double? _scrollListVertical(Offset topLeftOffset, Offset bottomRightOffset) {
    double top = topLeftOffset.dy;
    double bottom = bottomRightOffset.dy;
    double? newOffset;

    var pointerYPosition = _pointerYPosition;
    var scrollController = _scrollController;
    if (pointerYPosition != null) {
      if (pointerYPosition < (top + _scrollAreaSize) &&
          scrollController.position.pixels >
              scrollController.position.minScrollExtent) {
        final overDrag =
            max((top + _scrollAreaSize) - pointerYPosition, _overDragMax);
        newOffset = max(scrollController.position.minScrollExtent,
            scrollController.position.pixels - overDrag / _overDragCoefficient);
      } else if (pointerYPosition > (bottom - _scrollAreaSize) &&
          scrollController.position.pixels <
              scrollController.position.maxScrollExtent) {
        final overDrag = max<double>(
            pointerYPosition - (bottom - _scrollAreaSize), _overDragMax);
        newOffset = min(scrollController.position.maxScrollExtent,
            scrollController.position.pixels + overDrag / _overDragCoefficient);
      }
    }

    return newOffset;
  }
}
