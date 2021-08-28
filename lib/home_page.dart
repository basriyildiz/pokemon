import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late Pokedex pokedex;
  late Future<Pokedex> veri;

  Future<Pokedex> _pokemonlariGetir() async {
    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = _pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data!.pokemon.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                  pokemon: snapshot.data!.pokemon[index]),
                            ));
                          },
                          child: Hero(
                            tag: snapshot.data!.pokemon[index].img,
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "assets/loading.gif",
                                          image: snapshot
                                              .data!.pokemon[index].img),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                          snapshot.data!.pokemon[index].name)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("asd"),
                    );
                  }
                },
              );
            } else {
              return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: snapshot.data!.pokemon.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                  pokemon: snapshot.data!.pokemon[index]),
                            ));
                          },
                          child: Hero(
                            tag: snapshot.data!.pokemon[index].img,
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "assets/loading.gif",
                                          image: snapshot
                                              .data!.pokemon[index].img),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                          snapshot.data!.pokemon[index].name)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("asd"),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
