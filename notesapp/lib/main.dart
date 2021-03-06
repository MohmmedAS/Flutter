import 'package:flutter/material.dart';
import '../app_state/app_state.dart';
import '../constants.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';

late AppState appState;

main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// [AppState] handles all the important stuff for firebase, offline sql
  /// storage and the [NotesModel] object in the memory.
  appState = AppState();
  appState.initialization().then((_) => appState.readNotes());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: Builder(
        builder: (BuildContext context) => MaterialApp(
          theme: Provider.of<AppState>(context).isDarkTheme
              ? ThemeData.dark().copyWith(
                  primaryColor: kDarkThemeBackgroundColor,
                )
              : ThemeData.light()
                  .copyWith(primaryColor: kLightThemeBackgroundColor),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
