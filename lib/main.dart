

import 'package:warframe_tracker/screens/cycles.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange
      ),
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
  Widget page = Placeholder();
  String title = 'Fissures';

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        page = Placeholder();
        title = 'Fissures';
        break;
      case 1:
        page = const ArbitrationsPage();
        title = 'Arbitrations';
        break;
      case 2:
        page = const CyclesPage();
        title = 'Cycles';
        break;
      case 3:
        page = const SettingsPage();
        title = 'Settings';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Expanded(child: page),
            NavigationBar(
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.abc), label: 'Fissures'),
                NavigationDestination(
                    icon: Icon(Icons.abc), label: 'Arbitration'),
                NavigationDestination(icon: Icon(Icons.abc), label: 'Cycles'),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: 'Settings')
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
