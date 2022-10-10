import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';

class RubriqueService {
  late CrudOperation _savedataSurvey;
  RubriqueService() {
    _savedataSurvey = CrudOperation();
  }

  saveRubrique(RubriqueModel recensement) async {
    return await _savedataSurvey.insertData(
        "rubriques", recensement.rubriqueMap());
  }

  getAllRubriques() async {
    return await _savedataSurvey.readData('rubriques');
  }

  getRubriqueById(id) async {
    return await _savedataSurvey.readDataById('rubriques', id);
  }
}
