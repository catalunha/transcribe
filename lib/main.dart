import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/data/service/firebase_service.dart';
import 'app/routes.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  // await GetStorage.init('transcribing');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transcribing',
      theme: appThemeDataDark,
      darkTheme: appThemeDataDark,
      // themeMode: ThemeMode.system,
      getPages: RoutesPages.pageList,
      initialRoute: RoutesPaths.auth,
      // locale: const Locale('pt', 'BR'),
      // translationsKeys: AppTranslations.translations,
    );
  }
}
