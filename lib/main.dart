import 'package:warframe_tracker/screens/cycles.dart';
import 'package:warframe_tracker/screens/fisures.dart';

import 'imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warframe Tracker',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true, 
        colorSchemeSeed: Colors.orange
        ),
        darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true, 
        colorSchemeSeed: Colors.orange
        ),
        themeMode: theme,
      home: const NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  Widget page = const FissuresPage();
  Text title = const Text('Void Fissures');

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        page = const FissuresPage();
        title = Text((modeFilter==0) ? 'Void Fissures'
        : (modeFilter==1) ? 'Void Fissures (Steel Path)'
        : (modeFilter==2) ? 'Void Fissures (Star Chart)'
        : 'Void Fissures (Void Storms)');
        break;
      case 1:
        page = const EventPage();
        title = const Text('Events');
        break;
      case 2:
        page = const CyclesPage();
        title = const Text('World Cycles');
        break;
      case 3:
        page = const SettingsPage();
        title = const Text('Settings');
    }
    return Scaffold(
        appBar: AppBar(
          title: title,
        ),
        body: Column(
          children: [
            Expanded(child: page),
            NavigationBar(
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.info_outline), label: 'Fissures'),
                NavigationDestination(
                    icon: Icon(Icons.info_outline), label: 'Events'),
                NavigationDestination(
                    icon: Icon(Icons.info_outline), label: 'Cycles'),
                NavigationDestination(
                    icon: Icon(Icons.settings_outlined), label: 'Settings')
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            )
          ],
        ));
  }
}
