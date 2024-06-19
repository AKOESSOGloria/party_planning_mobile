import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Réservation de Fêtes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectionPage(),
    );
  }
}

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String selectedWidget = 'Instruments de musique';
  List<Accessoire> selectedAccessoires = [];

  void navigateToSelectedPage(String selectedWidget) {
    Widget page;
    switch (selectedWidget) {
      case 'Instruments de musique':
        page = InstrumentsDeMusiqueWidget(onSelect: addSelectedAccessoires);
        break;
      case 'Chaises':
        page = ChaisesWidget(onSelect: addSelectedAccessoires);
        break;
      case 'Tables':
        page = TablesWidget(onSelect: addSelectedAccessoires);
        break;
     
      case 'Places des fêtes':
        page = PartyPlaceWidget(onSelect: addSelectedAccessoires);
        break;
      case 'Menus':
        page = FoodssWidget(onSelect: addSelectedAccessoires);
        break;
    
      default:
        page = InstrumentsDeMusiqueWidget(onSelect: addSelectedAccessoires);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccessoiresPage(selectedWidget: selectedWidget, child: page)),
    );
  }

  void addSelectedAccessoires(List<Accessoire> accessoires) {
    setState(() {
      selectedAccessoires.addAll(accessoires);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vos accessoires ont été ajoutés à la liste')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Réservation de Fêtes'),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Instruments de musique',
                      child: Text('Instruments de musique'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Chaises',
                      child: Text('Chaises'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Tables',
                      child: Text('Tables'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Places des fêtes',
                      child: Text('Places des fêtes'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Menus',
                      child: Text('Menus'),
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedWidget = value;
                      navigateToSelectedPage(value);
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '../assets/images/Plan_de_travail.png',
              fit: BoxFit.cover,
           ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sélectionner les différents accessoires de fête dont vous avez besoin pour mener à bien votre expérience',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccessoiresPage extends StatelessWidget {
  final String selectedWidget;
  final Widget child;

  AccessoiresPage({required this.selectedWidget, required this.child});

  @override

  //-----------3-bouton
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
/*           backgroundColor: Colors.lightBlueAccent,
 */          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Accessoires pour la fête'),
              DropdownButton<String>(
                value: selectedWidget,
                dropdownColor: Colors.lightBlueAccent,
                icon: Icon(Icons.more_vert, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.white, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccessoiresPage(
                          selectedWidget: newValue,
                          child: getSelectedWidget(newValue),
                        ),
                      ),
                    );
                  }
                },
                items: <String>[
                  'Instruments de musique',
                  'Chaises',
                  'Tables',
                  'Places des fêtes',
                  'Menus'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              '../assets/images/Plan_de_travail.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: child,
          ),
        ],
      ),
    );
  }
  //-----------3-bouton

  Widget getSelectedWidget(String widgetName) {
    switch (widgetName) {
      case 'Instruments de musique':
        return InstrumentsDeMusiqueWidget(onSelect: (List<Accessoire> selectedItems) {});
      case 'Chaises':
        return ChaisesWidget(onSelect: (List<Accessoire> selectedItems) {});
      case 'Tables':
        return TablesWidget(onSelect: (List<Accessoire> selectedItems) {});

        //------------------------------------
      case 'Places des fêtes':
        return PartyPlaceWidget(onSelect: (List<Accessoire> selectedItems) {});

      case 'Menus':
        return FoodssWidget(onSelect: (List<Accessoire> selectedItems) {});

        //-----------------------------------
      default:
        return InstrumentsDeMusiqueWidget(onSelect: (List<Accessoire> selectedItems) {});
    }
  }
}

class InstrumentsDeMusiqueWidget extends StatelessWidget {
 

  final Function(List<Accessoire>) onSelect;

  InstrumentsDeMusiqueWidget({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return MyApplicati();
  }
}


class PartyPlaceWidget extends StatelessWidget {
  

  final Function(List<Accessoire>) onSelect;

  PartyPlaceWidget({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return MyApplication();
    
  }
}



class ChaisesWidget extends StatelessWidget {
  

  final Function(List<Accessoire>) onSelect;

  ChaisesWidget({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return MyApplica();
  }
}

class TablesWidget extends StatelessWidget {
 

  final Function(List<Accessoire>) onSelect;

  TablesWidget({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return MyApplicat();
  }
}

class FoodssWidget extends StatelessWidget {
  
final Function(List<Accessoire>) onSelect;

  FoodssWidget({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return MyApplicatio();
  }
}  

class AccessoiresGrid extends StatefulWidget {
  final String titre;
  final List<Accessoire> accessoires;
  final Function(List<Accessoire>) onSelect;

  AccessoiresGrid({required this.titre, required this.accessoires, required this.onSelect});

  @override
  _AccessoiresGridState createState() => _AccessoiresGridState();
}

class _AccessoiresGridState extends State<AccessoiresGrid> {
  List<Accessoire> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titre,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: widget.accessoires.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) {
              final accessoire = widget.accessoires[i];
              final isSelected = selectedItems.contains(accessoire);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected ? selectedItems.remove(accessoire) : selectedItems.add(accessoire);
                  });
                },
                child: Card(
                  elevation: 5,
                  color: isSelected ? Colors.blue.withOpacity(0.7) : Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          accessoire.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          accessoire.nom,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Ajouter à la liste?'),
                    content: const Text('Voulez-vous ajouter ces éléments à la liste?'),
                    actions: [
                      TextButton(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          widget.onSelect(selectedItems);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Ajouter à la liste'),
          ),
        ],
      ),
    );
  }
}

class Accessoire {
  final String nom;
  final String imagePath;

  Accessoire(this.nom, this.imagePath);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Accessoire &&
          runtimeType == other.runtimeType &&
          nom == other.nom &&
          imagePath == other.imagePath;

  @override
  int get hashCode => nom.hashCode ^ imagePath.hashCode;
}

class PartyPlace {
  final String name;
  final String description;
  final String imagePath;
  bool isReserved;

  PartyPlace({
    required this.name,
    required this.description,
    required this.imagePath,
    this.isReserved = false,
  });
}


List<PartyPlace> partyPlaces = [
  PartyPlace(
    name: 'Vallée des Grâces',
    description:
        'Au coeur du quartier d\'Avénou à Lomé, à 200 mètres de l\'hôtel Mimba la Licorne, la salle de Réception Vallée de Grâces vous accueille dans un lieu unique, tout confort. Chez nous, tout est pensé pour vous accueillir dans les meilleures conditions afin que vous puissiez profiter du moment',
    imagePath: '../assets/images/VDG.jpg',
  ),
  PartyPlace(
    name: 'Golden Plaza',
    description: 'Découvrez notre sélection exclusive d\'espaces pour vos événements privés.',
    imagePath: '../assets/images/Golden.jpg',
  ),
  PartyPlace(
    name: '2 Février',
    description: 'La salle de fête de l\'Hôtel 2 Février offre un cadre luxueux et élégant pour célébrer vos occasions spéciales dans le cœur de la ville.',
    imagePath: '../assets/images/2f.jpg',
  ),
  PartyPlace(
    name: 'HODA OBA',
    description: 'La salle de fête Hôda Oba offre une ambiance raffinée et contemporaine, idéale pour des événements élégants et mémorables.',
    imagePath: '../assets/images/HODA.jpg',
  ),
];

List<PartyPlace> chaises = [
  PartyPlace(
    name: 'Chaises classiques',
    description:'Découvrez des chaises classiques.',  
    imagePath: '../assets/images/Chaises_one.jpg',
  ),
  PartyPlace(
    name: 'Chaises en bois',
    description: 'Découvrez des chaises en bois pour des célébrations très simples.',
    imagePath: '../assets/images/Chaises_two.jpg',
  ),
  PartyPlace(
    name: 'Chaises basiques',
    description: 'Découvrez des chaises basiques pour des célebrations où il y aura beaucoup d\'invités.',
    imagePath: '../assets/images/Chaises_three.jpg',
  ),
  PartyPlace(
    name: 'Chaises perfectionnées ',
    description: 'Découvrez des chaises bien confaectionnés depuis la France pour des célebrations où il y aura beaucoup d\'invités.',
    imagePath: '../assets/images/Chaises_four.jpg',
  ),
];

List<PartyPlace> tables = [
  PartyPlace(
    name: 'Tables en bois',
    description:
        'Des tables confectionnés avec les bois de la forêt d\'Iraty au Pays Basques.',
    imagePath: '../assets/images/Tables_en_bois.jpg',
  ),
  PartyPlace(
    name: 'Tables de luxe',
    description: 'Découvrez nos tables de luxe commandés depuis l\'Italie.',
    imagePath: '../assets/images/Tables_luxe.jpg',
  ),
  PartyPlace(
    name: 'Tables basiques',
    description: 'Des tables très élégants faîtes par les menusiers de notre cher pays le Togo.',
    imagePath: '../assets/images/Tables_simples.jpg',
  ),
  PartyPlace(
    name: 'Tables traditionnelles',
    description: 'Découvrez des tables traditionnelles pas chères pour toute vos célébrations locales.',
    imagePath: '../assets/images/Tables_tradition.jpg',
  ),
];

List<PartyPlace> instruments = [
  PartyPlace(
    name: 'Musique avec des instruments africains ',
    description:
        'Ecouter de la musique africaine avec les instruments africains comme au bon vieux temps .',
    imagePath: '../assets/images/Instruments_1.jpg',
  ),
  PartyPlace(
    name: 'Musique Electro ',
    description: 'Les tendances d\'aujourd\'hui .',
    imagePath: '../assets/images/Instruments_2.jpg',
  ),
  PartyPlace(
    name: 'Musique Rock and Roll',
    description: 'Du rock and roll pour tous les amoureux de l\'art gothique.',
    imagePath: '../assets/images/Instruments_3.jpg',
  ),
  PartyPlace(
    name: 'Musique française',
    description: 'Découvrer les artistes français comme Patrick Bruel, Coeur de Pirate interpreter leur musique.',
    imagePath: '../assets/images/Instruments_4.jpg',
  ),
];

List<PartyPlace> foods = [
  PartyPlace(
    name: 'Plat d\'entrée',
    description:
        'Découvrez nos mini-pizzas fait par le chef Antoine Pereira qui a suivi des études.',
    imagePath: '../assets/images/Food_1.jpg',
  ),
  PartyPlace(
    name: 'Gâteau de mariage ',
    description: 'Découvrez nos gâteaux de mariages au goût unique fait par le restaurant le Phénicien.',
    imagePath: '../assets/images/Food_2.jpg',
  ),
  PartyPlace(
    name: 'Plat de résistance',
    description: 'Découvrez nos frites tres croquantes et très délicieuses faites par la cheffe Clarisse.',
    imagePath: '../assets/images/Food_3.jpg',
  ),
  PartyPlace(
    name: 'Desserts',
    description: 'Découvrez les meilleures pancakes de la maison le Festival des Glaces.',
    imagePath: '../assets/images/Food_4.jpg',
  ),
];


class MyApplica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Font.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chaises.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailsScreen(chaises[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              chaises[index].imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chaises[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  chaises[index].description,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!chaises[index].isReserved) {
                                          chaises[index].isReserved = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Les chaises "${chaises[index].name}" a été réservé.'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Réserver'),
                                    ),
                                    const SizedBox(width: 8),
                                    Visibility(
                                      visible: chaises[index].isReserved,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          chaises[index].isReserved = false;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Réservation annulée pour "${chaises[index].name}".'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text('Annuler'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );   
  }
}

class MyApplicat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Font.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tables.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailsScreen(tables[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              tables[index].imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tables[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tables[index].description,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!tables[index].isReserved) {
                                          tables[index].isReserved = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Les tables "${tables[index].name}" a été réservé.'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Réserver'),
                                    ),
                                    const SizedBox(width: 8),
                                    Visibility(
                                      visible: tables[index].isReserved,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          tables[index].isReserved = false;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Réservation annulée pour "${tables[index].name}".'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text('Annuler'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );   
  }
}


class MyApplicati extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Font.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: instruments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailsScreen(instruments[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              instruments[index].imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  instruments[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  instruments[index].description,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!instruments[index].isReserved) {
                                          instruments[index].isReserved = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Le lieu "${instruments[index].name}" a été réservé.'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Réserver'),
                                    ),
                                    const SizedBox(width: 8),
                                    Visibility(
                                      visible: instruments[index].isReserved,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          instruments[index].isReserved = false;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Réservation annulée pour "${instruments[index].name}".'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text('Annuler'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );   
  }
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Font.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: partyPlaces.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailsScreen(partyPlaces[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              partyPlaces[index].imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  partyPlaces[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  partyPlaces[index].description,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!partyPlaces[index].isReserved) {
                                          partyPlaces[index].isReserved = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Le lieu "${partyPlaces[index].name}" a été réservé.'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Réserver'),
                                    ),
                                    const SizedBox(width: 8),
                                    Visibility(
                                      visible: partyPlaces[index].isReserved,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          partyPlaces[index].isReserved = false;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Réservation annulée pour "${partyPlaces[index].name}".'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text('Annuler'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );   
  }
}


class PlaceDetailsScreen extends StatelessWidget {
  final PartyPlace place;

  PlaceDetailsScreen(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              place.imagePath,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                place.description,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApplicatio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Font.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetailsScreen(foods[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              foods[index].imagePath,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  foods[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  foods[index].description,
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!foods[index].isReserved) {
                                          foods[index].isReserved = true;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Le menu "${foods[index].name}" a été réservé.'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text('Réserver'),
                                    ),
                                    SizedBox(width: 8),
                                    Visibility(
                                      visible: foods[index].isReserved,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          foods[index].isReserved = false;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Réservation annulée pour "${foods[index].name}".'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Text('Annuler'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );   
  }
}