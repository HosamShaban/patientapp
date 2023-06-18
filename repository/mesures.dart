import 'package:patientapp/Model/show_mesures.dart';

import '../web_services/show_mesures.dart';

class MesureService {
  final ShowMesuresWebServices showMesuresWebServices;

  MesureService(this.showMesuresWebServices);

  Future<List<dynamic>> GetAllMesures() async {
    final mesures = await showMesuresWebServices.GetAllMesures();
    return mesures.map((mesure) => ShowMesures.fromjson(mesure)).toList();
  }
}
