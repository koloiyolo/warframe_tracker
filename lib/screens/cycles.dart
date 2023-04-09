
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:warframe_tracker/imports.dart';

class CyclesPage extends StatefulWidget {
  const CyclesPage({super.key});

  @override
  State<CyclesPage> createState() => _CyclesPageState();
}

class _CyclesPageState extends State<CyclesPage> {
  late Future<Cetus> futureCetus;
  late Future<CambionDrift> futureCambion;
  late Future<Earth> futureEarth;
  late Future<OrbVallis> futureOrbVallis;

  @override
  void initState() {
    super.initState();
    futureCetus = fetchCetus();
    futureCambion = fetchCambionDrift();
    futureEarth = fetchEarth();
    futureOrbVallis = fetchOrbVallis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      const SizedBox(height: 32),
      FutureBuilder<Cetus>(
          future: futureCetus,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildTitle('Cetus'),
                      const SizedBox(height: 8),
                      buildText(snapshot.data!.isDay
                          ? "Current state: Day"
                          : "Current state: Night"),
                      buildText(snapshot.data!.shortString)
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
      FutureBuilder<CambionDrift>(
          future: futureCambion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildTitle('Cambion Drift'),
                      const SizedBox(height: 8),
                      buildText('Current state: ${snapshot.data!.state}'),
                      buildText((snapshot.data!.state.compareTo('fass') == 1)
                          ? '${snapshot.data!.timeLeft} to fass'
                          : '${snapshot.data!.timeLeft} to vome')
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
      FutureBuilder<Earth>(
          future: futureEarth,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildTitle('Earth'),
                      const SizedBox(height: 8),
                      buildText(snapshot.data!.isDay
                          ? 'Current state: Day'
                          : 'Current state: Night'),
                      buildText(snapshot.data!.isDay ? '${snapshot.data!.timeLeft} to Night': '${snapshot.data!.timeLeft} to Day')
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
      FutureBuilder<OrbVallis>(
          future: futureOrbVallis,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      buildTitle('Orb Vallis'),
                      const SizedBox(height: 8),
                      buildText('Current state: ${snapshot.data!.state}'),
                      buildText(snapshot.data!.shortString)
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    ]));
  }

  Center buildText(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
  Center buildTitle(String text) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 25)));
}

//cetus

Future<Cetus> fetchCetus() async {
  var url = 'https://api.warframestat.us/pc/cetusCycle/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Cetus.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

class Cetus {
  final String id;
  final String expiry;
  final String activation;
  final bool isDay;
  final String state;
  final String timeLeft;
  final bool isCetus;
  final String shortString;

  Cetus(
      {required this.id,
      required this.expiry,
      required this.activation,
      required this.isDay,
      required this.state,
      required this.timeLeft,
      required this.isCetus,
      required this.shortString});
  factory Cetus.fromJson(Map<String, dynamic> json) {
    return Cetus(
        id: json['id'],
        expiry: json['expiry'],
        activation: json['activation'],
        isDay: json['isDay'],
        state: json['state'],
        timeLeft: json['timeLeft'],
        isCetus: json['isCetus'],
        shortString: json['shortString']);
  }
}

//CambionDrift
Future<CambionDrift> fetchCambionDrift() async {
  var url = 'https://api.warframestat.us/pc/cambionCycle';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return CambionDrift.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

class CambionDrift {
  final String id;
  final String expiry;
  final String activation;
  final String state;
  final String active;
  final String timeLeft;

  CambionDrift({
    required this.id,
    required this.expiry,
    required this.activation,
    required this.state,
    required this.active,
    required this.timeLeft,
  });
  factory CambionDrift.fromJson(Map<String, dynamic> json) {
    return CambionDrift(
        id: json['id'],
        expiry: json['expiry'],
        activation: json['activation'],
        state: json['state'],
        timeLeft: json['timeLeft'],
        active: json['active']);
  }
}

//earth
Future<Earth> fetchEarth() async {
  var url = 'https://api.warframestat.us/pc/earthCycle/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Earth.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

class Earth {
  final String id;
  final String activation;
  final String expiry;
  final bool isDay;
  final String state;
  final String timeLeft;

  Earth({
    required this.id,
    required this.expiry,
    required this.activation,
    required this.isDay,
    required this.state,
    required this.timeLeft,
  });
  factory Earth.fromJson(Map<String, dynamic> json) {
    return Earth(
        id: json['id'],
        expiry: json['expiry'],
        activation: json['activation'],
        isDay: json['isDay'],
        state: json['state'],
        timeLeft: json['timeLeft']);
  }
}

//OrbVallis
Future<OrbVallis> fetchOrbVallis() async {
  var url = 'https://api.warframestat.us/pc/vallisCycle/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return OrbVallis.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

class OrbVallis {
  final String id;
  final String expiry;
  final String activation;
  final String state;
  final bool isWarm;
  final String timeLeft;
  final String shortString;

  OrbVallis(
      {required this.id,
      required this.expiry,
      required this.activation,
      required this.state,
      required this.isWarm,
      required this.timeLeft,
      required this.shortString});
  factory OrbVallis.fromJson(Map<String, dynamic> json) {
    return OrbVallis(
        id: json['id'],
        expiry: json['expiry'],
        activation: json['activation'],
        state: json['state'],
        timeLeft: json['timeLeft'],
        isWarm: json['isWarm'],
        shortString: json['shortString']);
  }
}
