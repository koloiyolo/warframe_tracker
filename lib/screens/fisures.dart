import 'package:warframe_tracker/imports.dart';
import 'package:http/http.dart' as http;

class Fissure {
  final String id;
  final String startString;
  final bool active;
  final String node;
  final String missionType;
  final String enemy;
  final String tier;
  final bool isHard;
  final bool isStorm;

  Fissure({
    required this.id,
    required this.startString,
    required this.active,
    required this.node,
    required this.missionType,
    required this.enemy,
    required this.tier,
    required this.isHard,
    required this.isStorm,
  });

  factory Fissure.fromJson(Map<String, dynamic> json) {
    return Fissure(
      id: json['id'],
      startString: json['startString'],
      active: json['active'],
      node: json['node'],
      missionType: json['missionType'],
      enemy: json['enemy'],
      tier: json['tier'],
      isHard: json['isHard'],
      isStorm: json['isStorm'],
    );
  }
}

Future<List<Fissure>> fetchFissures() async {
  var url = 'https://api.warframestat.us/pc/fissures/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final l = jsonResponse as List;
    return l.map((data) => Fissure.fromJson(data)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}

class FissuresPage extends StatefulWidget {
  const FissuresPage({super.key});

  @override
  State<FissuresPage> createState() => _FissuresPageState();
}

class _FissuresPageState extends State<FissuresPage> {
  late Future<List<Fissure>> futureFissure;

  @override
  void initState() {
    super.initState();
    futureFissure = fetchFissures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Fissure>>(
            future: futureFissure,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return listNode(snapshot, index);
                    });
              } else if (snapshot.hasError) {
                Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Column listNode(AsyncSnapshot<dynamic> snapshot, int index) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: buildText(snapshot.data![index].isHard
                  ? 'Tier: ${snapshot.data![index].tier} Relic, Type: ${snapshot.data![index].missionType}, Steel Path'
                  : 'Tier: ${snapshot.data![index].tier} Relic, Type: ${snapshot.data![index].missionType}, Star Chart'),
              children: [
                buildText('Faction: ${snapshot.data![index].enemy}'),
                buildText('Node: ${snapshot.data![index].node}'),
                buildText(
                    'Time left: ${snapshot.data![index].startString.substring(1)}')
              ],
            ),
          ),
        ),
      ],
    );
  }

  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}
