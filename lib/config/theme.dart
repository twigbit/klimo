part of '../main.dart';

//TODO replace custom app colors in favor of color scheme ?

const ColorScheme _customColorScheme = ColorScheme(
  primary: Palette.primary,
  secondary: Palette.secondary,
  surface: Palette.surface,
  background: Palette.surface,
  error: Palette.error,
  onPrimary: Palette.white,
  onSecondary: Palette.black,
  onSurface: Palette.black,
  onError: Palette.error,
  onBackground: Palette.black,
  brightness: Brightness.light,
);

ThemeData _baseTheme = ThemeData(
  colorScheme: _customColorScheme,
  // TODO see if we want migrate to Material 3
  useMaterial3: false,
  brightness: Brightness.light,
);

ThemeData _theme = _baseTheme.copyWith(
  textTheme: _textTheme,
  unselectedWidgetColor: Palette.primary,
  scaffoldBackgroundColor: Colors.grey[30],
  appBarTheme: AppBarTheme(
    color: Colors.white,
    foregroundColor: Palette.black,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    centerTitle: false,
    titleTextStyle: _textTheme.headlineLarge,
    elevation: 1,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    elevation: 1,
    selectedIconTheme: const IconThemeData(
      size: 22,
      color: Palette.primary,
    ),
    unselectedIconTheme: const IconThemeData(
      color: Palette.greySecondary,
      size: 18,
    ),
    selectedLabelStyle: _textTheme.labelSmall,
    selectedItemColor: Palette.primary,
    unselectedItemColor: Palette.greySecondary,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: _textTheme.labelLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2.0,
      minimumSize: const Size(130, 40),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: _textTheme.labelLarge,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  )),
  sliderTheme: SliderThemeData(
      inactiveTrackColor: Palette.greySecondary,
      trackHeight: 1.0,
      overlayShape: SliderComponentShape.noOverlay),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: _textTheme.bodyMedium?.copyWith(color: Palette.grey),
    fillColor: Colors.grey[200],
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      sizeConstraints: BoxConstraints.expand(width: 40, height: 40),
      extendedPadding: EdgeInsets.all(0),
      smallSizeConstraints: BoxConstraints.expand(width: 32, height: 32),
      backgroundColor: Palette.primary,
      elevation: 2.0),
  dialogTheme: DialogTheme(
    titleTextStyle: _textTheme.headlineMedium,
    contentTextStyle: _textTheme.bodyMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
        border: Border(
      bottom: BorderSide(color: Palette.primary, width: 1.0),
    )),
    labelColor: Palette.primary,
    unselectedLabelColor: Palette.greySecondary,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    elevation: 1.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

TextTheme _textTheme = GoogleFonts.poppinsTextTheme(
  _baseTheme.textTheme.copyWith(
    displayLarge: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: const TextStyle(),
    titleMedium: const TextStyle(),
    titleSmall: const TextStyle(),
    bodyLarge: const TextStyle(
      fontSize: 16,
    ),
    bodyMedium: const TextStyle(
      fontSize: 15,
    ),
    bodySmall: const TextStyle(
      fontSize: 13,
    ),
    labelLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: const TextStyle(),
    labelSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ),
).apply(
  bodyColor: _baseTheme.colorScheme.onBackground,
  displayColor: _baseTheme.colorScheme.onBackground,
);
