import 'package:flutter/material.dart';
import 'package:go_survey/components/titre_btn_plus.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';

class QuestionnaireCreate extends StatefulWidget {
  const QuestionnaireCreate({super.key, required this.title});
  final String title;
  @override
  State<QuestionnaireCreate> createState() => _QuestionnaireCreateState();
}

class _QuestionnaireCreateState extends State<QuestionnaireCreate> {
  // bool valueCheckbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)), body: QuestionCreate());
  }
}

class QuestionCreate extends StatefulWidget {
  const QuestionCreate({super.key});

  @override
  State<QuestionCreate> createState() => _QuestionCreateState();
}

class _QuestionCreateState extends State<QuestionCreate> {
  bool valueCheckbox = false;
  @override
  Widget checkBoxWidget(
          {required TypeOfReponse typeOfReponse,
          required VoidCallback OnClicked}) =>
      ListTile(
        onTap: OnClicked,
        leading: Checkbox(
            value: typeOfReponse.value, onChanged: (value) => OnClicked()),
        title: Text(
          typeOfReponse.titre,
          style: TextStyle(fontSize: 15),
        ),
      );
  final typeofreponse = [
    TypeOfReponse(titre: "Reponse Textuel"),
    TypeOfReponse(titre: "Reponse Numerique"),
    TypeOfReponse(titre: "Modalite [ 1.Oui, 2.Non ]"),
    TypeOfReponse(titre: "Autres modalite")
  ];
  Widget SimpleCheckbox(TypeOfReponse typeofreponse) => checkBoxWidget(
        typeOfReponse: typeofreponse,
        OnClicked: () {
          setState(() {
            final newvalue = !typeofreponse.value;
            typeofreponse.value = newvalue;
          });
        },
      );
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AideCreateQuestionnaire(
                    titre:
                        "Merci d'avoir choisis GoSurvey pour faire vos enquete"),
                AideCreateQuestionnaire(titre: "odk")
              ],
            )),
        createSection(context, typeofreponse),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Expanded createSection(context, typeofresponse) {
    return Expanded(
        child: MediaQuery.removePadding(
      context: context,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 15),
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.green.withOpacity(.3),
                        offset: new Offset(-10, 5),
                        blurRadius: 20,
                        spreadRadius: 4)
                  ]),
              child: Column(
                children: [
                  Text(
                    "Creer une question",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Veuillez taper une question ici"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type de reponse",
                        ),
                        Column(
                          children: [
                            SimpleGroupedCheckbox<int>(
                              controller: GroupController(),
                              itemsTitle: [
                                "Reponse Textuelle",
                                "Reponse Numerique",
                                "Modalites [ 1. Oui, 2. Non]",
                                "Autres modalites"
                              ],
                              values: [1, 2, 4, 5],
                              groupStyle: GroupStyle(
                                  activeColor: Colors.green,
                                  itemTitleStyle: TextStyle(fontSize: 13)),
                              checkFirstElement: true,
                            )
                            // ...typeofresponse.map(SimpleCheckbox).toList(),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 15),
            height: 50,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.green.withOpacity(.3),
                        offset: new Offset(-10, 5),
                        blurRadius: 20,
                        spreadRadius: 4)
                  ]),
              child: Column(
                children: [
                  Text(
                    "Ajouter une section",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class AideCreateQuestionnaire extends StatelessWidget {
  const AideCreateQuestionnaire({super.key, required this.titre, this.img});
  final String titre;
  final String? img;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        // On prend la 80 % de la taille total de l ecran
        color: Colors.white,
        width: size.width * .8,
        margin: EdgeInsets.only(
          left: 10,
          top: 10 / 4,
          bottom: 10 * 2.5,
        ),
        child: Column(
          children: [
            Image.asset(
              img ?? "assets/img/1.jpg",
              height: 100,
              fit: BoxFit.fitWidth,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15 / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.green.withOpacity(.23),
                      )
                    ]),
                child: Expanded(
                  child: Text(
                    titre,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TypeOfReponse {
  String titre;
  bool value;
  TypeOfReponse({
    required this.titre,
    this.value = false,
  });
}