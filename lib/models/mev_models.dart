// To parse this JSON data, do
//
//     final mevModels = mevModelsFromJson(jsonString);

import 'dart:convert';

MevModels mevModelsFromJson(String str) => MevModels.fromJson(json.decode(str));

String mevModelsToJson(MevModels data) => json.encode(data.toJson());

class MevModels {
  MevModels({
    this.novosti,
  });

  List<Novosti> novosti;

  factory MevModels.fromJson(Map<String, dynamic> json) => MevModels(
    novosti: List<Novosti>.from(json["novosti"].map((x) => Novosti.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "novosti": List<dynamic>.from(novosti.map((x) => x.toJson())),
  };
}

class Novosti {
  Novosti({
    this.idNovosti,
    this.naslov,
    this.podNaslov,
    this.tekst,
    this.datumNovosti,
    this.datumObjave,
    this.vidljivost,
    this.slika,
    this.tipNovosti,
  });

  String idNovosti;
  String naslov;
  String podNaslov;
  String tekst;
  DateTime datumNovosti;
  DateTime datumObjave;
  String vidljivost;
  String slika;
  String tipNovosti;

  factory Novosti.fromJson(Map<String, dynamic> json) => Novosti(
    idNovosti: json["id_novosti"],
    naslov: json["naslov"],
    podNaslov: json["pod_naslov"],
    tekst: json["tekst"],
    datumNovosti: DateTime.parse(json["datum_novosti"]),
    datumObjave: DateTime.parse(json["datum_objave"]),
    vidljivost: json["vidljivost"],
    slika: json["slika"],
    tipNovosti: json["tip_novosti"],
  );

  Map<String, dynamic> toJson() => {
    "id_novosti": idNovosti,
    "naslov": naslov,
    "pod_naslov": podNaslov,
    "tekst": tekst,
    "datum_novosti": datumNovosti.toIso8601String(),
    "datum_objave": datumObjave.toIso8601String(),
    "vidljivost": vidljivost,
    "slika": slika,
    "tip_novosti": tipNovosti,
  };
}
