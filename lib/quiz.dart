import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(home: Quiz()));

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);
  

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Map<String, dynamic>> pokemonData = [
    {"name": "Pikachu", "options": ["Pikachu", "Charmander", "Bulbasaur", "Squirtle"]},
    {"name": "Charmander", "options": ["Charmander", "Pidgey", "Mewtwo", "Geodude"]},
    {"name": "Bulbasaur", "options": ["Bulbasaur", "Eevee", "Clefairy", "Onix"]},
    {"name": "Squirtle", "options": ["Squirtle", "Machop", "Snorlax", "Jigglypuff"]},
    {"name": "Mewtwo", "options": ["Mewtwo", "Gengar", "Machamp", "Articuno"]},
    {"name": "Gengar", "options": ["Gengar", "Jynx", "Kadabra", "Lapras"]},
    {"name": "Eevee", "options": ["Eevee", "Ditto", "Jigglypuff", "Dugtrio"]},
    {"name": "Machamp", "options": ["Machamp", "Dragonite", "Gyarados", "Vileplume"]},
    {"name": "Snorlax", "options": ["Snorlax", "Kangaskhan", "Nidoking", "Rhydon"]},
    {"name": "Gyarados", "options": ["Gyarados", "Aerodactyl", "Kabutops", "Omastar"]},
    {"name": "Aerodactyl", "options": ["Aerodactyl", "Kabuto", "Omanyte", "Kabutops"]},
    {"name": "Kabuto", "options": ["Kabuto", "Omanyte", "Porygon", "Aerodactyl"]},
    {"name": "Omanyte", "options": ["Omanyte", "Kabuto", "Porygon", "Kabutops"]},
    {"name": "Kabutops", "options": ["Kabutops", "Kabuto", "Omanyte", "Porygon"]}

    // Adicione mais Pokémon aqui
  ];

List<int> remainingPokemonIndices = [];
  int currentPokemonIndex = 0;
  bool showResult = false;
  String selectedPokemon = "";
  int correctAnswers = 0;
  int wrongAnswers = 0;

  @override
  void initState() {
    super.initState();
    remainingPokemonIndices = List.generate(pokemonData.length, (index) => index);
    remainingPokemonIndices.shuffle();
    loadNextPokemon();
  }

  void loadNextPokemon() {
    if (remainingPokemonIndices.isEmpty) {
      return;
    }

    currentPokemonIndex = remainingPokemonIndices.removeAt(0);
    showResult = false;
    selectedPokemon = "";

    setState(() {});
  }

  AppBar customAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      automaticallyImplyLeading: true,
    );
  }

  void restartQuiz() {
    correctAnswers = 0;
    wrongAnswers = 0;
    remainingPokemonIndices.clear();
    remainingPokemonIndices.addAll(List.generate(pokemonData.length, (index) => index));
    remainingPokemonIndices.shuffle();
    loadNextPokemon();
  }

  @override
  Widget build(BuildContext context) {
    if (correctAnswers + wrongAnswers >= 10) {
  return Scaffold(
  appBar: AppBar(
    title: Text(
      'Quiz De Pokemon',
      style: TextStyle(fontSize: 20),
    ),
    backgroundColor: Colors.red, // Cor de fundo do AppBar vermelha
    automaticallyImplyLeading: true,
  ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Quiz concluído! Acertos: $correctAnswers, Erros: $wrongAnswers",
                style: TextStyle(fontSize: 24),
  
                ),
              ElevatedButton(
                onPressed: restartQuiz,
                child: Text("Reiniciar Quiz"),
                style: ElevatedButton.styleFrom(
                primary: Colors.red, // Cor vermelha para o botão
                 padding: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final pokemonName = pokemonData[currentPokemonIndex]["name"];
    final options = List<String>.from(pokemonData[currentPokemonIndex]["options"])..shuffle();

    return Scaffold(
  appBar: AppBar(
    title: Text(
      'Quiz De Pokemon',
      style: TextStyle(fontSize: 20),
    ),
    backgroundColor: Colors.red, // Cor de fundo do AppBar vermelha
    automaticallyImplyLeading: true,
  ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!showResult)
              Expanded(
                flex: 1,
                child: Center(
                  child: Image.asset(
                    "assets/images/${pokemonName.toLowerCase()}.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!showResult)
                      Text(
                        "Qual é o nome do Pokémon?",
                        style: TextStyle(fontSize: 24),
                      ),
                    for (int i = 0; i < options.length; i++)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (!showResult) {
                                selectedPokemon = options[i];
                                setState(() {
                                  showResult = true;
                                  if (options[i] == pokemonName) {
                                    correctAnswers++;
                                  } else {
                                    wrongAnswers++;
                                  }
                                });
                              }
                            },
                            child: Text(options[i], style: TextStyle(fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: showResult && options[i] == pokemonName
                                  ? Colors.green
                                  : showResult
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    if (showResult)
                      ElevatedButton(
                        onPressed: loadNextPokemon,
                        child: Text("Próximo", style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "Acertos: $correctAnswers",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Text(
                            "Erros: $wrongAnswers",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}