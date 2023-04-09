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
              buildText('Option'),
              const Expanded(child: SizedBox()),
              ElevatedButton(onPressed: () {}, child: buildText('Toggle')),
            ],
          ),
        ),
        const Center(child: Text('Created by Jakub Kołodziej', style: TextStyle(fontSize: 15))),
        const Center(child: Text('github.com/koloiyolo', style: TextStyle(fontSize: 15)))
      ],
    ));
  }
  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}
