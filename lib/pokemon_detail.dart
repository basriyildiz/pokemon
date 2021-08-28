import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/pokedex.dart';

class PokemonDetail extends StatefulWidget {
  late Pokemon pokemon;

  PokemonDetail({required this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  late PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.deepPurple;
  bool yuklendiMi = false;

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor!.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor!.color;
        yuklendiMi = true;
        debugPrint("Buraya girdi");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      baskinRengiBul();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (yuklendiMi) {
      return Scaffold(
        backgroundColor: baskinRenk.withOpacity(0.98),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.pokemon.name),
          centerTitle: true,
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return dikeyMode(context);
            } else {
              return yatayMode(context);
            }
          },
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(widget.pokemon.name),
          centerTitle: true,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  Stack dikeyMode(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height * 2 / 3,
          left: 10,
          top: MediaQuery.of(context).size.height * .1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 70),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: " + widget.pokemon.height),
                  Text("Weight: " + widget.pokemon.weight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Types: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          children: widget.pokemon.type
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(label: Text(e)),
                                  ))
                              .toList()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.nextEvolution.length != 0
                        ? [
                            Text(
                              "Next Evolution: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: widget.pokemon.nextEvolution
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(label: Text(e.name)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ]
                        : [
                            Text(
                              "Next Evolution: Son Aşama ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.weaknesses.length != 0
                        ? [
                            Text(
                              "Weakness: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: widget.pokemon.weaknesses
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(label: Text(e)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ]
                        : [
                            Expanded(
                              child: Text(
                                "Next Evolution: Son Aşama ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(
                widget.pokemon.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget yatayMode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height * (3 / 4),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Hero(
                tag: widget.pokemon.img,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    widget.pokemon.img,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text("Height: " + widget.pokemon.height),
                        Text("Weight: " + widget.pokemon.weight),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Types: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                          children: widget.pokemon.type
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(label: Text(e)),
                                  ))
                              .toList()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.pokemon.nextEvolution.length != 0
                        ? [
                            Text(
                              "Next Evolution: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: widget.pokemon.nextEvolution
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(label: Text(e.name)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ]
                        : [
                            Text(
                              "Next Evolution: Son Aşama ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.pokemon.weaknesses.length != 0
                        ? [
                            Text(
                              "Weakness: ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: widget.pokemon.weaknesses
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Chip(label: Text(e)),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ]
                        : [
                            Expanded(
                              child: Text(
                                "Next Evolution: Son Aşama ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
