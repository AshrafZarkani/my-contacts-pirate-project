
import 'package:my_contacts_pirate/global/api/api_strings.dart';
import 'package:my_contacts_pirate/global/api_provider/api_provider.dart';
import 'package:my_contacts_pirate/screens/home/Logic/model/pirate_response_model.dart';

class MyContactsScreenRepository {
  final String _url = MyApiStrings.requestPirate;
  ApiProvider _apiProvider = ApiProvider();

  Future<PirateResponseModel> fetchPirateContacts(int numOfContacts) async {
    final response = await _apiProvider.post(_url ,numOfContacts);
    return  PirateResponseModel.fromJson(response);
  }

}
