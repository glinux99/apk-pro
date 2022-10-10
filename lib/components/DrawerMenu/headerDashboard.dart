import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/questionnaires_creates.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/oldEnquete.dart';
import 'package:go_survey/components/DrawerMenu/user/userprofile.dart';
import 'package:go_survey/components/bodyDashboard.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/newsurvey.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/colors/colors.dart';
import 'package:go_survey/models/modalites/modalite.dart';
import 'package:go_survey/models/modalites/modalite_service.dart';
import 'package:go_survey/models/recensements/recensement.dart';
import 'package:go_survey/models/recensements/recensement_service.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderDashboard extends StatefulWidget {
  const HeaderDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HeaderDashboard> createState() => _HeaderDashboardState();
}

class _HeaderDashboardState extends State<HeaderDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15 * 2.5),
      height: widget.size.height * .2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 36 + 15,
            ),
            height: widget.size.height * .2 - 27,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Row(
              children: [
                Text(
                  "Go SURVEY",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset("assets/img/ico.png")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.green.withOpacity(.23))
                  ]),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    hintText: "Rechercher",
                    hintStyle: TextStyle(
                      color: Colors.green.withOpacity(.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Menu drawer
class MenuGauche extends StatefulWidget {
  const MenuGauche({super.key});

  @override
  State<MenuGauche> createState() => _MenuGaucheState();
}

bool iconBinary = false;
IconData _themeLightIcon = Icons.wb_sunny;
IconData _themeDarkIcon = Icons.nights_stay;
ThemeData _themeDark = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
);
ThemeData _themeLight =
    ThemeData(primarySwatch: Colors.green, brightness: Brightness.light);

class _MenuGaucheState extends State<MenuGauche> {
  bool profilevieuw = false;
  var _alertController = TextEditingController();
  int _currIndex = 1;
  var _userService = UserService();
  var _recensementService = RecensementService();
  var user;
  late String userName = 'Daniel';
  late String userPhone = '+243 970912428';
  late List<User> userUnique = [];
  getAuthUser() async {
    final prefs = await SharedPreferences.getInstance();
    var result = await _userService.getUserById(prefs.getInt('authId'));
    userName = prefs.getString('userName') ?? 'Daniel';
    userPhone = prefs.getString('userPhone') ?? '+243 970912428';
    result.forEach((userUnik) {
      setState(() {
        var userModel = User();
        userModel.id = userUnik['id'];
        userModel.name = userUnik['name'];
        userModel.email = userUnik['email'];
        userModel.phone = userUnik['phone'];
        userModel.password = userUnik['password'];
        userUnique.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAuthUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    foregroundImage: AssetImage("assets/img/1.jpg"),
                    child: Text(
                      'user',
                    ),
                    radius: 34,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      profilevieuw = !profilevieuw;
                      _currIndex = _currIndex == 0 ? 1 : 0;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userPhone,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) =>
                                    RotationTransition(
                                      turns: child.key == ValueKey('icon1')
                                          ? Tween<double>(begin: 1, end: 0.75)
                                              .animate(anim)
                                          : Tween<double>(begin: 0.75, end: 1)
                                              .animate(anim),
                                      child: FadeTransition(
                                          opacity: anim, child: child),
                                    ),
                                child: _currIndex == 0
                                    ? Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        key: const ValueKey('icon1'))
                                    : Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        key: const ValueKey('icon2'),
                                      )),
                            onPressed: () {
                              setState(() {
                                profilevieuw = !profilevieuw;
                                _currIndex = _currIndex == 0 ? 1 : 0;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (profilevieuw)
            AnimatedPositioned(
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 200),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text('Mon profile'),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonProfile(
                                    userUnique: userUnique[0],
                                  )));
                      // print(user[0].name);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "mainDashboard",
                          )));
            },
          ),
          ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text("Nouvel enquete"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                              RouteLink: 'newEnquete',
                            )));
              }),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text("Enquetes recentes"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "oldEnquete",
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Parametres de l\'application'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "parametreDashboard",
                            titre: "Parametre",
                          )));
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Laissez un avis sur PlayStore"),
            onTap: () {
              // show the dialog
              showDialog(
                  context: context,
                  barrierDismissible:
                      true, // set to false if you want to force a rating
                  builder: (context) => RatingDialog(
                        initialRating: 1.0,
                        // your app's name?
                        title: Text(
                          'Evaluation',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        message: Text(
                          'Appuyez sur une étoile pour définir votre évaluation. Ajoutez plus de description ici si vous le souhaitez.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        // logo de l application
                        image: Image.asset(
                          "assets/img/ico.png",
                          height: 100,
                        ),
                        submitButtonText: 'Envoyer',
                        commentHint: 'Inserer ici votre commmentaire',
                        onCancelled: () => print('annuler'),
                        onSubmitted: (response) {
                          print(
                              'rating: ${response.rating}, comment: ${response.comment}');

                          // TODO: add your own logic
                          if (response.rating < 3.0) {
                            // send their comments to your email or anywhere you wish
                            // ask the user to contact you instead of leaving a bad review
                          } else {
                            _rateAndReviewApp();
                          }
                        },
                      ));
            },
          ),
          ListTile(
              leading: Icon(Icons.library_add_check),
              title: Text("Licences et librairies"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/img/ico.png',
                    height: 30,
                  ),
                  applicationName: 'Go Survey',
                  applicationVersion: '\nV0.0.1',
                  applicationLegalese: '2022 Power by Joviale',
                  children: <Widget>[Text('')],
                );
              }),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Inviter des amis'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('A propos'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireCreate(
                            title: "Creation du questionnaire",
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Deconection'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginSignup()));
            },
          ),
        ],
      ),
    );
  }

  // actual store listing review & rating
  void _rateAndReviewApp() async {
    // refer to: https://pub.dev/packages/in_app_review
    final _inAppReview = InAppReview.instance;

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview.requestReview();
    } else {
      print('open actual store listing');
      // TODO: use your own store ids
      _inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }
}

class AlertGoSurvey extends StatelessWidget {
  const AlertGoSurvey({
    Key? key,
    required this.titre,
    required this.hinText,
    required this.prefId,
    required this.routeLink,
    required TextEditingController alertController,
    required RubriqueService recensementService,
  })  : _alertController = alertController,
        _recensementService = recensementService,
        super(key: key);
  final String titre;
  final String hinText;
  final String prefId;
  final String routeLink;
  final TextEditingController _alertController;
  final RubriqueService _recensementService;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 100,
          height: 200,
          child: OverflowBox(
            maxWidth: 400,
            minHeight: 10,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextButton(
                    child: Text(titre, style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      TextField(
                        controller: _alertController,
                        autofocus: true,
                        onTap: () {},
                        onChanged: (value) {},
                        decoration: InputDecoration(hintText: hinText),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    if (_alertController.text != '') {
                      var recPref = await SharedPreferences.getInstance();
                      var recId = recPref.getInt('authId');
                      var recensement = RubriqueModel();
                      recensement.userId = recId;
                      recensement.description = _alertController.text;
                      var result =
                          await _recensementService.saveRubrique(recensement);
                      recPref.setInt(prefId, result);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionnaireCreate(
                                    title: "Creation du questionnaire",
                                  )));
                      print(recPref.getInt(prefId));
                    } else
                      print('text input not null');
                  },
                  child: Text("Valider"),
                  style: TextButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(145, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.white,
                      backgroundColor: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key, required this.RouteLink});
  final String RouteLink;
  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // activation du scroking dans des petites appareils
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HeaderDashboard(size: size),
            widget.RouteLink == "mainDashboard"
                ? MainDashboard()
                : widget.RouteLink == "oldEnquete"
                    ? OldEnquete()
                    : NewEnquete(),
          ],
        ));
  }
}