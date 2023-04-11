import 'package:warframe_tracker/imports.dart';

int modeFilter = 0;
var theme = ThemeMode.system;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              buildText('Fissure mode: '),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (modeFilter < 3) {
                        modeFilter++;
                      } else {
                        modeFilter = 0;
                      }
                    });
                  },
                  child: buildText((modeFilter == 0)
                      ? 'All'
                      : (modeFilter == 1)
                          ? 'Steel Path'
                          : (modeFilter == 2)
                              ? 'Star Chart'
                              : 'Void Storms')),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(children: [
        //     buildText('Theme Switch'),
        //     const Expanded(child: SizedBox()),
        //     ElevatedButton.icon(onPressed: (){
        //       setState(() {
        //           darkMode = !darkMode;
        //           if(darkMode){
        //             theme = ThemeMode.dark;
        //           }else{
        //             theme = ThemeMode.light;
        //           }
        //       });
        //     }, label: buildText(darkMode?'Dark Mode': 'Light Mode' ), icon: darkMode? const Icon(Icons.dark_mode_outlined): const Icon(Icons.light_mode_outlined))

        //   ],),
        // ),
        const Center(
            child: Text('Created by Jakub Kołodziej',
                style: TextStyle(fontSize: 15))),
        const Center(
            child: Text('github.com/koloiyolo', style: TextStyle(fontSize: 15)))
      ],
    ));
  }

  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}
