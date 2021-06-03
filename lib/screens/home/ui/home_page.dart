import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:my_contacts_pirate/global/api_provider/api_reponse.dart';
import 'package:my_contacts_pirate/screens/common_widgets/unified_appbar.dart';
import 'package:my_contacts_pirate/screens/home/Logic/bloc/my_contact_bloc.dart';
import 'package:my_contacts_pirate/screens/home/Logic/model/pirate_response_model.dart';
import 'package:sizer/sizer.dart';
import 'widgets/contact_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyContactsBloc _bloc;
  late List<Contact> _contacts = [];
  bool _permissionDenied = false;

  @override
  void initState() {
    _fetchContacts()
        .whenComplete(() => _bloc = MyContactsBloc(_contacts.length));
    super.initState();
  }

  Future _fetchContacts() async {
    //request for user permission
    if (!await FlutterContacts.requestPermission()) {
      setState(() {
        _contacts = [];
        _permissionDenied = true;
      });
      return;
    }
    await _refetchContacts();
    // Listen to DB changes
    FlutterContacts.addListener(() async {
      print('Contacts DB changed, re-fetching contacts');
      await _refetchContacts();
    });
  }

  Future _refetchContacts() async {
    await _loadContacts(true);
  }

  Future _loadContacts(bool withPhotos) async {
    final contacts =
        (await FlutterContacts.getContacts(withThumbnail: true)).toList();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: UnifiedAppBar(
        title: "My Contacts",
      ),
      body: (_permissionDenied == true)
          ? Center(child: Text('Permission denied'))
          : SafeArea(
              child: StreamBuilder<Response<PirateResponseModel>>(
                  stream: _bloc.offersListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          break;
                        case Status.COMPLETED:
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: _contacts.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              height: 12.0.h,
                              width: 100.0.w,
                              child: Card(
                                child: Center(
                                  child: ContactListTile(
                                      contacts: _contacts[index],
                                      images: snapshot
                                          .data!.data.data.images[index]),
                                ),
                              ),
                            ),
                          );
                          break;
                        case Status.ERROR:
                          return Container();
                          break;
                      }
                    }
                    return Container();
                  })),
    );
  }
}


