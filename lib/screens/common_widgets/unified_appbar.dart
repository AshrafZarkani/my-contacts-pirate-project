import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UnifiedAppBar extends StatelessWidget implements PreferredSizeWidget{
  const UnifiedAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.0.h);
}