import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusIndicatorWidget extends StatelessWidget {
  final TodoStatus status;

  const StatusIndicatorWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath;
    EdgeInsets padding;

    switch (status) {
      case TodoStatus.toDo:
        assetPath = 'assets/images/vector.svg';
        padding = const EdgeInsets.only(left: 8, top: 6);
        break;
      case TodoStatus.inProgress:
        assetPath = 'assets/images/vector.svg';
        padding = const EdgeInsets.only(left: 8, top: 6);
        break;
      case TodoStatus.inReview:
        assetPath = 'assets/images/vector.svg';
        padding = const EdgeInsets.only(left: 8, top: 6);
        break;
      case TodoStatus.completed:
        assetPath = 'assets/images/vector.svg';
        padding = const EdgeInsets.only(left: 8, top: 6);
        break;
    }

    return Padding(
      padding: padding,
      child: SvgPicture.asset(
        assetPath,
        width: 8,
        height: 12,
      ),
    );
  }
}