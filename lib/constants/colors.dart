import 'package:mohoro/common.libs.dart';

class AppColors {
  //Design
  final Color brown = const Color(0xFFC96C39);
  final Color darkBrown = const Color(0xFF541611);
  final Color orange = const Color(0xFFF06724);
  final Color red = const Color(0xFFEB3D25);
  final Color yellow = const Color(0xFFFBC22D);
  final Color purple = const Color(0xFF7F255B);
  final Color blue = const Color(0xFF87CEFA);
  final Color green = const Color(0xFF23C741);
  final Color skyblue = const Color(0xFF84E6FC);
  final Color deepPurple =const Color(0xff713ABE);

  // Added
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color caption = const Color(0xFF7D7873);
  final Color body = const Color(0xFF514F4D);
  final Color grey = const Color(0xFF73777B);
  final Color greyStrong = const Color(0xFF272625);
  final Color greyMedium = const Color(0xFF9D9995);
  final Color white = Colors.white;
  final Color black = const Color(0xFF1E1B18);
  final Color blackOut = const Color(0xFF000000);
  final Color darkblue = const Color(0xFF4285F4);
  final Color lightblue = const Color(0xFF00BFFF);
  final Color darkgreen = const Color(0xFF146b47);
  final Color lightpurple = const Color(0xFFB2A4FF);

  final Color error = Colors.red.shade400;

  final bool isDark = false;

  ThemeData themeData() {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light())
        .textTheme
        .apply(fontFamily: 'Causten');
    Color txtColor = white;
    ColorScheme colorScheme = ColorScheme(
      // Decide how you want to apply your own custom theme, to the MaterialApp
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: red,
      primaryContainer: darkgreen,
      secondary: darkgreen,
      secondaryContainer: darkgreen,
      background: offWhite,
      surface: red,
      onBackground: txtColor,
      onSurface: txtColor,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: error,
    );

    AppBarTheme appBarTheme = AppBarTheme(
      backgroundColor: darkgreen,
      titleTextStyle: $styles.text.h3,
    );

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    /// Also add on some extra properties that ColorScheme seems to miss
    var t =
        ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme).copyWith(
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: brown, selectionColor: brown),
      highlightColor: brown,
      primaryColor: red,
      appBarTheme: appBarTheme,
    );

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}
