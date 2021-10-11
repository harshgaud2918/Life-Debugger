import 'dart:math';

import 'package:life_debugger/data/Location.dart';

import 'ProblemObj.dart';

List<String> names = ['flood', 'pole broke', 'no road', 'dead person'];
String description =
    'LФЯЄԠ ЇPSЏԠ DФLФЯ SЇҐ ДԠԐГ, ҪФЍSԐҪГԐГЦЯ ДDЇPЇSҪЇЍG ԐLЇГ. ҒЏSҪЭ DЇGЙЇSSЇԠ ДЦҪҐФЯ ЙЄQЏԐ ЭЏ PФЯҬД. ԠДЭҪԐЙДS LДҪЇЍЇД ЄҐ ДИҬԐ ДҪ ԠДГҐЇS. DЦЇS ҒԐЯԠЭЙҬЏԠ ЭSГ ДҐ ЍЇSЇ SԐԠPԐЯ, VЄL ҢЭИDЯЭЯЇҬ ԐЯДҐ DЇҪГЦԠ. ҪЯДS VЭL ҒЇЙЇЪЏS ИЇSL. ЇЍ ӉДҪ ҢДБЇҬДSSЄ PLДГЭД DЇҪҐЦԠSГ. ИДԠ SДGЇГҬЇS ҐԐLLЏS QЏЇS ҪФИDЇԠЄЙҬЏԠ ЭGЭSҬДS. DФЙЭҪ LДҪЦS ЇPSЏԠ, ЇДҪЏLЇS ЄҬ ԠДSSД ЇD, ЇԠPԐЯDЇЄҐ PФЯҐГЇГФЯ SԐԠ. VЄSҬЇЬЦLЦԠ ДИГЄ ЇPSЏԠ PЯЇԠЇS ЇИ ӺДЏҪЇБЏS ФЯҪЇ LЏҪҐЦS ԐҐ ЏLҬЯЇҪЄS PФSЦԐЯЄ ҪЦЪЇLЇД ҪЏЯДЭ; PЭLLЭИҐԐSQЦЭ SЏSҪЇPЇҐ GЯДVЇDД ЙЭQЦЄ SЄD VДЯЇЏS. VЄSҬЇБЏLЏԠ ҒДЏҪЇЪЏS ДЏGЦЄ ЭҲ, ЄЦ SФDДLԐS VЭLЇҬ LЦҪҬЏS ЍФИ. SЭD ԠДӼЇԠЦS ЄӺҒЇҪЇҬЏЯ ӺԐLЇS ДГ VЏLPЏГДҐЭ. PЯДԐSЄЍҬ ҪФЙSԐQЏДГ ԠДSSД ЄГ ЏLLДԠҪФЯPЭЯ ҢЭЍDЯЭЯЇГ. ЙДԠ QЏЇS LДҪЏS ԠДLЄSЦДDД, SҪЄLԐЯЇSQЦЭ DЏЇ ЄҐ, PЏLVЇЍДЯ LЇЬԐЯФ. PЯДЭSЭЙҬ ҪЏЯSЦS ЇD ЏЯЙД ДҪ ЭLԐԠԐЙҐЦԠ. ԠДЦЯЇS ЄЦЇSԠФD LДҪЦS VЇҐДЄ PЦЯЏS PЯЭГЇЏԠ, ДГ ҐЄԠPФЯ ЭЯДҐ ДЏҪҐФЯ.';
int maxValid = 100;
int maxInvalid = 100;
int locations = 5;
List<ProblemObj> iniProb() {
  List<ProblemObj> probs = [];
  String url="https://img.stickers.cloud/packs/58c037f4-8700-40bb-97ef-b6a6ee0ff398/png/a8efe763-c280-43d3-a03b-3f49bc41ac57.png";
  final random = new Random();
  for (var i = 0; i <= 5; i++) {

    probs.add(ProblemObj(
      problemId: random.nextInt(100),
      summary: names[random.nextInt(names.length - 1)],
      description: description,
      severity: 0,
      valid: random.nextInt(maxValid),
      invalid: random.nextInt(maxInvalid),
      location: LocationData(state: "OLLA", city: random.nextInt(locations).toString()),
      userId: random.nextInt(10),
      url: url,
    ));
  }
  return probs;
}

