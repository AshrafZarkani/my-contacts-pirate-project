import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

class ContactListLogic with ChangeNotifier {
  static const iOSLocalizedLabels = false;

  late List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  bool _permissionDenied = false;

  bool get permissionDenied=> _permissionDenied;

  Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      _contacts = [];
      _permissionDenied = true;
      notifyListeners();
      return;
    }

    await refetchContacts();

    // Listen to DB changes
    FlutterContacts.addListener(() async {
      print('Contacts DB changed, refecthing contacts');
      await refetchContacts();
    });
  }

  Future refetchContacts() async {
    // First load all contacts without photo
    await loadContacts(false);
    // Next with photo
    await loadContacts(true);
  }

  Future loadContacts(bool withPhotos) async {
    final _cont = withPhotos
        ? (await FlutterContacts.getContacts(withThumbnail: true)).toList()
        : (await FlutterContacts.getContacts()).toList();

    _contacts = _cont;
    print("contact loadContacts ${_contacts.toString()}");

    notifyListeners();
  }

}
