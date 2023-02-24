import '../../../libraries/views.dart';
import '../../../libraries/models.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: MyPallete.defaultColor.shade500,
  primarySwatch: MyPallete.defaultColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: MyPallete.defaultColor
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      // color: MyPallete.defaultColor.shade600,
      fontWeight: FontWeight.bold,
      fontSize: Get.height * 0.03
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.grey.shade800
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold
    )
  ),
);