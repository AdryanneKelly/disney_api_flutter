import 'package:disney_api_flutter/models/character_model.dart';
import 'package:disney_api_flutter/state/controller_state.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ControllerState();
  bool loading = false;
  List<CharacterModel> characters = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        loading = true;
      });
      final response = await controller.getCharacters();
      setState(() {
        characters.addAll(response);
        loading = false;
      });
    });
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disney API',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        // centerTitle: true,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
          child: Image.network(
              'https://logodownload.org/wp-content/uploads/2020/11/disney-plus-logo-1.png'),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 2, 86, 212),
                      Color.fromARGB(255, 75, 0, 214),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: characters.isEmpty
                    ? const Center(
                        child: Text('Nenhum dado encontrado'),
                      )
                    : ListView.builder(
                        itemCount: characters.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final character = characters[index];
                          return Card(
                            margin: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color.fromARGB(255, 0, 33, 82),
                            child: Column(
                              children: [
                                FadeInImage(
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    placeholder: const NetworkImage(
                                        'https://www.icegif.com/wp-content/uploads/2021/11/icegif-1427.gif'),
                                    image: NetworkImage(
                                      character.imageUrl ??
                                          'https://www.icegif.com/wp-content/uploads/2021/11/icegif-1427.gif',
                                    )),
                                const SizedBox(height: 20),
                                Text(
                                  character.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    _launchUrl(character.sourceUrl);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('Detalhes'),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
    );
  }
}
