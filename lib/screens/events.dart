import 'package:http/http.dart' as http;
import 'package:warframe_tracker/imports.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Future<Arbi> futureArbi;
  late Future<CurrentReward> fReward;

  @override
  void initState() {
    super.initState();
    futureArbi = fetchArbi();
    fReward = fetchCurrentReward();
  }

  @override
  Widget build(BuildContext context) {

    var now = DateTime.now();

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
                        const SizedBox(height: 8),
                        buildText('Time Left: ${59 - now.minute}m ${59 - now.second}s'),
                        const SizedBox(height: 32)
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }),
            const SizedBox(height: 32),
            FutureBuilder(future: fReward,
              builder: ((context, snapshot) {
              if(snapshot.hasData)
              {
                return Padding(padding: EdgeInsets.all(8),
                child: Card(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      buildTitle('Steel Path Honors'),
                      const SizedBox(height: 8),
                      buildTitle(snapshot.data!.name),
                      const SizedBox(height: 16),
                      buildText('Cost: ${snapshot.data!.cost} Steel Essence'),
                      const SizedBox(height: 8),
                      buildText('Time left: ${7 - now.weekday}d ${23 - now.hour}h, ${59-now.minute}m'),
                      const SizedBox(height: 32),
                    ],
                  ),
                ));
              }
               return const Center(child: CircularProgressIndicator());
              
            }))
      ],
    ));
  }

  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}


//arbitrations
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
      node: ((json['node'].compareTo('SolNode450') == 0)
          ? 'Tyana Pass(Mars)'
          : json['node']),
      enemy: ((json['node'].compareTo('SolNode450') == 0)
          ? 'Grenieer, Corpus'
          : json['enemy']),
      type: ((json['node'].compareTo('SolNode450') == 0)
          ? "Mirror Defense"
          : json['type']),
    );
  }
}

//SteelPath reward

class CurrentReward{
  String name;
  int cost;

  CurrentReward({
    required this.name,
    required this.cost});

    factory CurrentReward.fromJson(Map<String, dynamic> json){
      return CurrentReward(name: json['name'], cost: json['cost']);
    }
}

Future<CurrentReward> fetchCurrentReward() async{
  final response = await http.get(Uri.parse('https://api.warframestat.us/pc/steelPath'));
  
  if(response.statusCode == 200){
    var x = jsonDecode(response.body);
    return CurrentReward.fromJson(x['currentReward']);
  }else{
    throw Exception('Failed');
  }
}
