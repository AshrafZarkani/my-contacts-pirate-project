import 'package:flutter/material.dart';
import 'package:my_contacts_pirate/screens/common_widgets/unified_appbar.dart';
import 'package:my_contacts_pirate/screens/landing_page/Logic/pin_screen_logic.dart';
import 'package:my_contacts_pirate/screens/landing_page/ui/widgets/pin_containers.dart';
import 'package:sizer/sizer.dart';
import 'package:my_contacts_pirate/screens/landing_page/ui/widgets/animated_container.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  bool _keyboardVisible = false;
  String? randomString;

  @override
  void initState() {
    randomString = PinScreenLogic().getRandomString(4);
    print("random number generated is >> $randomString");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //check if keyboard is on
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    debugPrint("keyboard $_keyboardVisible");

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: UnifiedAppBar(
          title: "Pin Screen",
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PinContainers(randomString!),
                Padding(
                  padding: EdgeInsets.only(top: 3.0.h),
                  child: Center(
                    child: Text("Please provide the pin code",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
                MyAnimatedContainer(
                    keyboardVisible: _keyboardVisible,
                    randomString: randomString),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
