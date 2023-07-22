import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String myName = '';
  List<Nom> texts = [
    Nom('irin'),
  ];
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'LIST && GRID',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                text: 'List',
              ),
              Tab(
                text: 'Grid',
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(
                  child: ListView.builder(
                      itemCount: texts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Nom text = texts[index];
                        String key = text.nom;
                        return Dismissible(
                          key: Key(key),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            height: 100,
                            child: Card(
                              elevation: 7.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${texts[index].nom}',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              texts.removeAt(index);
                            });
                            texts.last.nom;
                          },
                          background: Container(
                            color: Colors.red,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Suprimé",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                                itemCount: texts.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onLongPress: () {
                                setState(() {
                                  texts.removeAt(index);
                                });
                              },
                              child: Card(
                                elevation: 2.0,
                                child: Center(child: Text("${texts[index].nom}",style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          );
                        }))),
              ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dialog(context);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ajout de nom'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("nom"),
                    ),
                    onChanged: (value) {
                      setState(() {
                        myName = value;
                      });
                      print(myName);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          texts.add(Nom(myName));
                        });
                        print(texts.last.nom);
                        Navigator.pop(context);
                      },
                      child: const Text('sauvegarder'))
                ],
              ),
            ),
          );
        });
  }
}

class Nom {
  String nom;
  Nom(this.nom);
}
