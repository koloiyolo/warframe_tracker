import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warframe_tracker/imports.dart';

Future<Arbi> fetchArbi() async {
  final response =
      await http.get(Uri.parse('https://api.warframestat.us/pc/arbitration'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Arbi.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Arbi {
  final String id;
  final String node;
  final String enemy;
  final String type;

  const Arbi({
    required this.id,
    required this.node,
    required this.enemy,
    required this.type,

  });

  factory Arbi.fromJson(Map<String, dynamic> json) {
    return Arbi(
      id: json['id'],
      node: json['node'],
      enemy: json['enemy'],
      type: json['type'],
    );
  }
}

class ArbitrationsPage extends StatefulWidget {
  const ArbitrationsPage({super.key});

  @override
  State<ArbitrationsPage> createState() => _ArbitrationsPageState();
}

class _ArbitrationsPageState extends State<ArbitrationsPage> {
  late Future<Arbi> futureArbi;

  @override
  void initState() {
    super.initState();
    futureArbi = fetchArbi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        FutureBuilder<Arbi>(
            future: futureArbi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                      const SizedBox(height: 32),
                        buildTitle('Mission type:'),
                        const SizedBox(height: 8),
                        buildTitle(snapshot.data!.type),
                        const SizedBox(height: 16),
                        buildText('Faction: ${snapshot.data!.enemy}'),
                        const SizedBox(height: 8),
                        buildText('Node: ${snapshot.data!.node}'),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ],
    ));
  }

  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}
