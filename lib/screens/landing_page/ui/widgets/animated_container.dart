
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({
    Key? key,
    required bool keyboardVisible,
    required this.randomString,
  }) : _keyboardVisible = keyboardVisible, super(key: key);

  final bool _keyboardVisible;
  final String? randomString;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _keyboardVisible ? 1.0 : 0.0,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Theme.of(context).scaffoldBackgroundColor,
        ),
        margin: EdgeInsets.only(top: 2.0.h),
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        child: Text("$randomString",style: Theme.of(context).textTheme.headline5,),
      ),
      duration: Duration(seconds: 2),
    );
  }
}