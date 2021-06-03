import 'package:flutter/material.dart';
import 'package:my_contacts_pirate/global/services/size_config.dart';
import 'package:my_contacts_pirate/global/utils/image_strings.dart';
import 'package:my_contacts_pirate/screens/common_widgets/stateful_wrapper.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StatefulWrapper(
      onInit: () async {
        await new Future.delayed(new Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/pinScreen');

        });
      },
      onDispose: (){},
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Image(
            image: AssetImage(MyImagesStrings.splashScreen),
          ),
        ),
      ),
    );
  }
}
