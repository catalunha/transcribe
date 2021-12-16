import 'package:transcribe/app/translation/es_MX/es_mx.dart';

import 'en_US/en_us.dart';
import 'pt_BR/pt_br.dart';

abstract class AppTranslations {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBr,
    'en_US': enUs,
    'es_MX': esMx,
  };
}
