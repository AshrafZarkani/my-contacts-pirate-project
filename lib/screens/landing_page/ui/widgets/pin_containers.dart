import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class PinContainers extends StatefulWidget {
  final String randomString;
  const PinContainers(this.randomString, {
    Key? key,
  }) : super(key: key);

  @override
  _PinContainersState createState() => _PinContainersState();
}

class _PinContainersState extends State<PinContainers> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: "")..text = "";
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(5.0.h),
          child: Center(
              child: PinCodeTextField(
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.text,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveColor: Colors.grey
                  ,
              disabledColor: Colors.grey
                  ,
              inactiveFillColor: Colors.grey
                  ,
            ),
            animationDuration: Duration(milliseconds: 300),
            autoDismissKeyboard: true,
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v) {
              if (v == widget.randomString){
              }else {
                FlutterBeep.beep(false);
              }
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context, onChanged: (String value) {
                if (value == widget.randomString){
                  Navigator.pushNamed(context, '/homePage');
                }else {
                }
              },
          )),
        ),

      ],
    );
  }
}
