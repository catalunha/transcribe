// import 'package:flutter/material.dart';
// import 'package:themed/themed.dart';

// //Roteiro para esquema de cores do App
// // https://material.io/design/color/the-color-system.html#color-theme-creation

// class ThemeApp {
//   //Color for colorScheme
//   static const primaryDark = ColorRef(Colors.black, id: "primaryDark");
//   static const primary = ColorRef(Colors.black, id: "primary");
//   static const primaryVariant = ColorRef(Colors.white, id: "primaryVariant");
//   static const primaryLight = ColorRef(Colors.white, id: "primaryLight");
//   static const onPrimaryDark = ColorRef(Colors.white, id: "onPrimaryDark");
//   static const onPrimary = ColorRef(Colors.grey, id: "onPrimary");
//   static const onPrimaryLight = ColorRef(Colors.white, id: "onPrimaryLight");
//   static const secondDark = ColorRef(Colors.white, id: "secondDark");
//   static const secondary = ColorRef(Colors.white, id: "secondary");
//   static const secondaryVariant =
//       ColorRef(Colors.white, id: "secondaryVariant");
//   static const secondLight = ColorRef(Colors.white, id: "secondLight");
//   static const onSecondaryDark = ColorRef(Colors.white, id: "onSecondaryDark");
//   static const onSecondary = ColorRef(Colors.white, id: "onSecondary");
//   static const onSecondaryLight =
//       ColorRef(Colors.white, id: "onSecondaryLight");
//   static const backgroundDark = ColorRef(Colors.white, id: "backgroundDark");
//   static const background = ColorRef(Colors.white, id: "background");
//   static const backgroundLight = ColorRef(Colors.white, id: "backgroundLight");
//   static const onBackgroundDark =
//       ColorRef(Colors.white, id: "onBackgroundDark");
//   static const onBackground = ColorRef(Colors.white, id: "onBackground");
//   static const onBackgroundLight =
//       ColorRef(Colors.white, id: "onBackgroundLight");
//   static const surfaceDark = ColorRef(Colors.white, id: "surfaceDark");
//   static const surface = ColorRef(Colors.white, id: "surface");
//   static const surfaceLight = ColorRef(Colors.white, id: "surfaceLight");
//   static const onSurfaceDark = ColorRef(Colors.white, id: "onSurfaceDark");
//   static const onSurface = ColorRef(Colors.white, id: "onSurface");
//   static const onSurfaceLight = ColorRef(Colors.white, id: "onSurfaceLight");
//   static const errorDark = ColorRef(Colors.white, id: "errorDark");
//   static const errorLight = ColorRef(Colors.white, id: "errorLight");
//   static const error = ColorRef(Colors.white, id: "error");
//   static const onError = ColorRef(Colors.white, id: "onError");
//   //Color for colorSchemePlusPlus

//   //Color for Screen
//   // static const scaffoldBackgroundColorColor =
//   //     ColorRef(Colors.white, id: "scaffoldBackgroundColorColor");
//   // static const appBarBackgroundColor =
//   //     ColorRef(Colors.white, id: "appBarBackgroundColor");

//   // //Color for specific WidgetTheme ou WidgetThemeData
//   // static const cardColor = ColorRef(Colors.white, id: "cardColor");

//   // //Color for specific moment
//   // static const backgroundLight = ColorRef(Colors.red, id: 'backgroundLight');
//   // static const surfaceLight =
//   //     ColorRef(Colors.white, id: 'surfaceLight');
//   // static const backgroundLight =
//   //     ColorRef(Colors.white, id: 'backgroundLight');
//   // static const secondary = ColorRef(Colors.white, id: 'secondary');

//   // //Color for especific icon and text
//   // static const icon01Color = ColorRef(Colors.white, id: "icon01Color");
//   // static const icon02Color = ColorRef(Colors.white, id: "icon02Color");
//   // static const text01Color = ColorRef(Colors.white, id: "text01Color");
//   // static const text02Color = ColorRef(Colors.white, id: "text02Color");
// }

// Map<ThemeRef, Object> orange = {
//   //Color for colorScheme
//   ThemeApp.primaryDark: Colors.lime,
//   ThemeApp.primary: Colors.orange,
//   ThemeApp.primaryVariant: Colors.lime,
//   ThemeApp.primaryLight: Colors.lime,
//   ThemeApp.onPrimaryDark: Colors.black,
//   ThemeApp.onPrimary: Colors.black,
//   ThemeApp.onPrimaryLight: Colors.black,
//   ThemeApp.secondDark: Colors.lime,
//   ThemeApp.secondary: Colors.deepOrange,
//   ThemeApp.secondaryVariant: Colors.lime.shade200,
//   ThemeApp.secondLight: Colors.lime.shade200,
//   ThemeApp.onSecondaryDark: Colors.lime,
//   ThemeApp.onSecondary: Colors.black,
//   ThemeApp.onSecondaryLight: Colors.lime,
//   ThemeApp.backgroundDark: Colors.white,
//   ThemeApp.background: Colors.white,
//   ThemeApp.backgroundLight: Colors.grey.shade200,
//   ThemeApp.onBackgroundDark: Colors.black,
//   ThemeApp.onBackground: Colors.black,
//   ThemeApp.onBackgroundLight: Colors.black,
//   ThemeApp.surfaceDark: Colors.white,
//   ThemeApp.surface: Colors.white,
//   ThemeApp.surfaceLight: Colors.orange.shade100,
//   ThemeApp.onSurfaceDark: Colors.black,
//   ThemeApp.onSurface: Colors.black,
//   ThemeApp.onSurfaceLight: Colors.grey.shade600,
//   // ThemeApp.errorDark: Colors.red,
//   ThemeApp.error: Colors.red,
//   ThemeApp.errorLight: Colors.yellow,
//   ThemeApp.onError: Colors.black,
// //   //Color for colorScheme
// //   ThemeApp.primary: Colors.orange,
// //   ThemeApp.onPrimary: Colors.black,
// //   ThemeApp.primaryVariant: Colors.red,
// //   ThemeApp.secondary: Colors.orange,
// //   ThemeApp.onSecondary: Colors.black,
// //   ThemeApp.secondaryVariant: Colors.red,
// //   ThemeApp.background: Colors.red,
// //   ThemeApp.onBackground: Colors.black,
// //   ThemeApp.surface: Colors.red,
// //   ThemeApp.onSurface: Colors.red,
// //   ThemeApp.error: Colors.red,
// //   ThemeApp.onError: Colors.red,
// //   //Color for Screen
// //   ThemeApp.scaffoldBackgroundColorColor: Colors.white,
// //   ThemeApp.appBarBackgroundColor: Colors.orange,
// //   //Color for specific WidgetTheme ou WidgetThemeData
// //   ThemeApp.cardColor: Colors.white,
// //   //Color for specific moment
// //   ThemeApp.backgroundLight: Colors.grey.shade300,
// //   ThemeApp.surfaceLight: Colors.orange.shade100,
// //   ThemeApp.backgroundLight: Colors.yellow,
// //   ThemeApp.secondary: Colors.deepOrange.shade900,
// //   //Color for especific icon and text
// //   ///Descatar icones do addEdit
// //   ThemeApp.icon01Color: Colors.orange,
// //   ThemeApp.icon02Color: Colors.red,
// //   ThemeApp.text01Color: Colors.black,

// //   ///Usado para:
// //   ///1) Destacar campos requeridos
// //   ThemeApp.text02Color: Colors.red,
// };

// class ThemeDataApp {
//   // MaterialColor myColorSwatch = MaterialColorRef(myColorSwatch);
//   ThemeData get changed {
//     ColorScheme colorScheme = ThemeData().colorScheme.copyWith(
//           primary: ThemeApp.primary,
//           onPrimary: ThemeApp.onPrimary,
//           secondary: ThemeApp.secondary,
//           onSecondary: ThemeApp.onSecondary,
//           onBackground: ThemeApp.onBackground,
//           onSurface: ThemeApp.onSurface,
//         );
//     TextTheme textTheme = const TextTheme(
//         // headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
//         // headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
//         // headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//         // headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
//         // headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//         // headline6: TextStyle(
//         //   fontSize: 20.0,
//         // ), //fontFamily: 'Georgia'
//         // subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//         // subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//         // bodyText1: TextStyle(color: Colors.white),
//         // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
//         // button: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
//         // caption: TextStyle(fontSize: 12.0, fontFamily: 'Georgia'),
//         // overline: TextStyle(fontSize: 10.0, fontFamily: 'Georgia'),
//         );

//     /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
//     var themeDataUpdated = ThemeData.from(
//             textTheme: textTheme, colorScheme: colorScheme)
//         // We can also add on some extra properties that ColorScheme seems to miss
//         .copyWith(
//       scaffoldBackgroundColor: ThemeApp.background,
//       appBarTheme: const AppBarTheme(
//         backgroundColor: ThemeApp.primary,
//         foregroundColor: ThemeApp.onPrimary,
//       ),
//       // // elevatedButtonTheme: ElevatedButtonThemeData(
//       // //   style: ElevatedButton.styleFrom(
//       // //       primary: ThemeApp.primary, onPrimary: ThemeApp.onPrimary),
//       // // ),
//       cardTheme: CardTheme(
//         color: ThemeApp.surface,
//         // shadowColor: ThemeApp.appBar,
//       ),
//       // textTheme: TextTheme(
//       //   bodyText1: TextStyle(color: ThemeApp.onBackground),
//       // ),
//       // // scaffoldBackgroundColor: ThemeApp.scaffoldBackgroundColor,
//       // // cardColor: ThemeApp.cardColor,
//       // textButtonTheme: TextButtonThemeData(
//       //     style: ButtonStyle(
//       //         foregroundColor:
//       //             MaterialStateProperty.all<Color>(ThemeApp.onBackground))),
//       // iconTheme: IconThemeData(color: Colors.grey.shade800),
//     );

//     /// Return the themeData which MaterialApp can now use
//     return themeDataUpdated;
//   }
// }

// Map<ThemeRef, Object> dark = {
// //Color for colorScheme
//   ThemeApp.primaryDark: Colors.lime,
//   ThemeApp.primary: Colors.black,
//   ThemeApp.primaryVariant: Colors.lime,
//   ThemeApp.primaryLight: Colors.lime,
//   ThemeApp.onPrimaryDark: Colors.lime,
//   ThemeApp.onPrimary: Colors.white,
//   ThemeApp.onPrimaryLight: Colors.lime,
//   ThemeApp.secondDark: Colors.lime,
//   ThemeApp.secondary: Colors.lime,
//   ThemeApp.secondaryVariant: Colors.lime.shade200,
//   ThemeApp.secondLight: Colors.lime.shade200,
//   ThemeApp.onSecondaryDark: Colors.lime,
//   ThemeApp.onSecondary: Colors.black,
//   ThemeApp.onSecondaryLight: Colors.lime,
//   ThemeApp.backgroundDark: Colors.white,
//   ThemeApp.background: Color(0xff111D27),
//   ThemeApp.backgroundLight: Colors.grey.shade800,
//   ThemeApp.onBackgroundDark: Colors.white,
//   ThemeApp.onBackground: Colors.grey,
//   ThemeApp.onBackgroundLight: Colors.grey,
//   ThemeApp.surfaceDark: Colors.lime,
//   ThemeApp.surface: Color(0xff152d36),
//   ThemeApp.surfaceLight: Colors.grey.shade700,
//   ThemeApp.onSurfaceDark: Colors.black,
//   ThemeApp.onSurface: Colors.white,
//   ThemeApp.onSurfaceLight: Colors.grey,
//   // ThemeApp.errorDark: Colors.red,
//   ThemeApp.error: Colors.red,
//   ThemeApp.errorLight: Colors.yellow,
//   ThemeApp.onError: Colors.black,
//   //Color for Screen
//   // ThemeApp.scaffoldBackgroundColorColor: Color(0xff111D27),
//   // ThemeApp.appBarBackgroundColor: Colors.black,
//   //Color for specific WidgetTheme ou WidgetThemeData
//   // ThemeApp.cardColor: Color(0xff152d36),
//   // //Color for specific moment
//   // ThemeApp.backgroundLight: Colors.grey.shade700,
//   // ThemeApp.surfaceLight: Colors.grey.shade800,
//   // ThemeApp.backgroundLight: Colors.lime,
//   // ThemeApp.secondary: Colors.lime,
//   // //Color for especific icon and text
//   // ThemeApp.icon01Color: Colors.lime,
//   // ThemeApp.icon02Color: Colors.lime,
//   // ThemeApp.text01Color: Colors.lime,
//   // ThemeApp.text02Color: Colors.lime,
// };
