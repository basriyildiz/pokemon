// To parse this JSON data, do
//
//     final pokedex = pokedexFromJson(jsonString);

import 'dart:convert';

Pokedex pokedexFromJson(String str) => Pokedex.fromJson(json.decode(str));

String pokedexToJson(Pokedex data) => json.encode(data.toJson());

class Pokedex {
  Pokedex({
    required this.pokemon,
  });

  List<Pokemon> pokemon;

  factory Pokedex.fromJson(Map<String, dynamic> json) => Pokedex(
        pokemon:
            List<Pokemon>.from(json["pokemon"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemon": List<dynamic>.from(pokemon.map((x) => x.toJson())),
      };
}

class Pokemon {
  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  late int id;
  late String num;
  late String name;
  late String img;
  late List<String> type;
  late String height;
  late String weight;
  late String candy;
  late int candyCount;
  late String egg;
  late double spawnChance;
  late double avgSpawns;
  late String spawnTime;
  late List<double> multipliers;
  late List<String> weaknesses;
  late List<Evolution> nextEvolution;
  late List<Evolution> prevEvolution;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        num: json["num"],
        name: json["name"],
        img: json["img"],
        type: List<String>.from(json["type"].map((x) => x)),
        height: json["height"],
        weight: json["weight"],
        candy: json["candy"],
        candyCount: json["candy_count"] == null ? 0 : json["candy_count"],
        egg: json["egg"],
        spawnChance: json["spawn_chance"].toDouble(),
        avgSpawns: json["avg_spawns"].toDouble(),
        spawnTime: json["spawn_time"],
        multipliers: json["multipliers"] == null
            ? List.empty()
            : List<double>.from(json["multipliers"].map((x) => x.toDouble())),
        weaknesses: List<String>.from(json["weaknesses"].map((x) => x)),
        nextEvolution: json["next_evolution"] == null
            ? List.empty()
            : List<Evolution>.from(
                json["next_evolution"].map((x) => Evolution.fromJson(x))),
        prevEvolution: json["prev_evolution"] == null
            ? List.empty()
            : List<Evolution>.from(
                json["prev_evolution"].map((x) => Evolution.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "name": name,
        "img": img,
        "type": List<dynamic>.from(type.map((x) => x)),
        "height": height,
        "weight": weight,
        "candy": candy,
        "candy_count": candyCount == null ? null : candyCount,
        "egg": egg,
        "spawn_chance": spawnChance,
        "avg_spawns": avgSpawns,
        "spawn_time": spawnTime,
        "multipliers": multipliers == null
            ? null
            : List<dynamic>.from(multipliers.map((x) => x)),
        "weaknesses": List<dynamic>.from(weaknesses.map((x) => x)),
        "next_evolution": nextEvolution == null
            ? null
            : List<dynamic>.from(nextEvolution.map((x) => x.toJson())),
        "prev_evolution": prevEvolution == null
            ? null
            : List<dynamic>.from(prevEvolution.map((x) => x.toJson())),
      };
}

class Evolution {
  Evolution({
    required this.num,
    required this.name,
  });

  late String num;
  late String name;

  factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        num: json["num"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "name": name,
      };
}
