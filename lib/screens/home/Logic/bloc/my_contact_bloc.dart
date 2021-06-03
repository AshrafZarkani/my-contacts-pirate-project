
import 'dart:async';

import 'package:my_contacts_pirate/global/api_provider/api_reponse.dart';
import 'package:my_contacts_pirate/screens/home/Logic/model/pirate_response_model.dart';
import 'package:my_contacts_pirate/screens/home/Logic/repro/offer_page_repro.dart';

class MyContactsBloc {
 late MyContactsScreenRepository _homeScreenRepository;
  late StreamController<Response<PirateResponseModel>> _streamListController;

  StreamSink<Response<PirateResponseModel>>? get offersListSink => _streamListController.sink;
  Stream<Response<PirateResponseModel>>? get offersListStream => _streamListController.stream;
  

   MyContactsBloc(int? numOfContacts) {
    _streamListController = StreamController<Response<PirateResponseModel>>.broadcast();
    _homeScreenRepository = MyContactsScreenRepository();
    fetchPiratesList(numOfContacts!);
  }

  fetchPiratesList(int numOfContacts) async {
    if (!_streamListController.isClosed) offersListSink!.add(Response.loading('Getting Offers'));
    try {
      PirateResponseModel pirateResponseModel = await _homeScreenRepository.fetchPirateContacts(numOfContacts);
      print("response from api >>>>>>>> ${pirateResponseModel.data.images}");
      if (!_streamListController.isClosed) offersListSink!.add(Response.completed(pirateResponseModel));
    } catch (e) {
      if (!_streamListController.isClosed) offersListSink!.add(Response.error(e.toString()));
    }
  }


  dispose() {
    _streamListController.close();
  }
}
