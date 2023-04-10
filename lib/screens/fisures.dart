import 'package:warframe_tracker/imports.dart';
import 'package:http/http.dart' as http;

class Fissure {
  final String id;
  final String eta;

  final String node;
  final String missionType;
  final String enemy;
  final String tier;
  final bool isHard;
  final bool isStorm;

  Fissure({
    required this.id,
    required this.eta,
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
      eta: json['eta'],
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
                List<Fissure> starChart = [];
                List<Fissure> steelPath = [];
                List<Fissure> voidStorm = [];
                for (int i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].isHard) {
                    steelPath.add(Fissure(
                        id: snapshot.data![i].id,
                        eta: snapshot.data![i].eta,
                        node: snapshot.data![i].node,
                        missionType: snapshot.data![i].missionType,
                        enemy: snapshot.data![i].enemy,
                        tier: snapshot.data![i].tier,
                        isHard: snapshot.data![i].isHard,
                        isStorm: snapshot.data![i].isStorm));
                  } else if (snapshot.data![i].isStorm) {
                    voidStorm.add(Fissure(
                        id: snapshot.data![i].id,
                        eta: snapshot.data![i].eta,
                        node: snapshot.data![i].node,
                        missionType: snapshot.data![i].missionType,
                        enemy: snapshot.data![i].enemy,
                        tier: snapshot.data![i].tier,
                        isHard: snapshot.data![i].isHard,
                        isStorm: snapshot.data![i].isStorm));
                  } else {
                    starChart.add(Fissure(
                        id: snapshot.data![i].id,
                        eta: snapshot.data![i].eta,
                        node: snapshot.data![i].node,
                        missionType: snapshot.data![i].missionType,
                        enemy: snapshot.data![i].enemy,
                        tier: snapshot.data![i].tier,
                        isHard: snapshot.data![i].isHard,
                        isStorm: snapshot.data![i].isStorm));
                  }
                }
                if (modeToggle == 0) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return listNode(snapshot.data!, index);
                      });
                } else if (modeToggle == 1) {
                  return ListView.builder(
                      itemCount: steelPath.length,
                      itemBuilder: (context, index) {
                        return listNode(steelPath, index);
                      });
                } else if (modeToggle == 2) {
                  return ListView.builder(
                      itemCount: starChart.length,
                      itemBuilder: (context, index) {
                        return listNode(starChart, index);
                      });
                } else {
                  return ListView.builder(
                      itemCount: voidStorm.length,
                      itemBuilder: (context, index) {
                        return listNode(voidStorm, index);
                      });
                }
              } else if (snapshot.hasError) {
                Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Column listNode(List<Fissure> f, int index) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: buildText(f[index].isHard
                  ? 'Tier: ${f[index].tier} Relic, Type: ${f[index].missionType}, Steel Path'
                  : f[index].isStorm
                      ? 'Tier: ${f[index].tier} Relic, Type: ${f[index].missionType}, Void Storm'
                      : 'Tier: ${f[index].tier} Relic, Type: ${f[index].missionType}, Star Chart'),
              children: [
                buildText('Faction: ${f[index].enemy}'),
                buildText('Node: ${f[index].node}'),
                buildText('Time left: ${f[index].eta}')
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
