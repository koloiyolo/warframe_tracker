

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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
