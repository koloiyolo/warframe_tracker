import 'package:warframe_tracker/imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text('Option'),
              const Expanded(child: SizedBox()),
              ElevatedButton(onPressed: () {}, child: Text('Toggle'))
            ],
          ),
        ),
      ],
    ));
  }
}
