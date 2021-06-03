import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:my_contacts_pirate/screens/home/Logic/model/pirate_response_model.dart';
import 'package:sizer/sizer.dart';
import 'avatar.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    Key? key,
    required Contact contacts,
    required Images images,
  })  : _contacts = contacts,
        _images = images,
        super(key: key);

  final Contact _contacts;
  final Images _images;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: _images.pirate
          ? Colors.green.shade200
          : Theme.of(context).primaryColor,
      leading: _images.pirate
          ? Padding(
        padding: EdgeInsets.only(left: 3.0.w),
        child: CircleAvatar(
          radius: 40,
          child: SvgPicture.network(
            _images.url,
            fit: BoxFit.cover,
            width: 8.0.h,
            height: 8.0.h,
          ),
        ),
      )
          : avatar(_contacts),
      title: Text(_contacts.displayName),
    );
  }
}