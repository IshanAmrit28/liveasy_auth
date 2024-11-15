import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liveasy_auth/widgets/button.dart';
import 'mobile.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English'; // Default language
  String englishText1 = 'Please select your Language';
  String englishText2 = 'You can change the language \nat any time.';
  String hindiText1 = 'कृपया अपनी भाषा का चयन करें';
  String hindiText2 = 'आप किसी भी समय भाषा \nबदल सकते हैं।';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: CustomPaint(
                painter: WavePainter(),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20),
                // Display text based on the selected language
                Text(
                  selectedLanguage == 'English' ? englishText1 : hindiText1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  selectedLanguage == 'English' ? englishText2 : hindiText2,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  width: 257.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    },
                    items: <String>['English', 'हिन्दी']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MobileNo(lang: selectedLanguage)),
                    );
                  },
                  text: selectedLanguage == 'English' ? "NEXT" : "अगला",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Color(0xFF46A6DD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;

    final paint2 = Paint()
      ..color = Color(0xFF2E3B62)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.0);
    path1.quadraticBezierTo(
      size.width * 0.00, size.height * 0.1,
      size.width * 0.12, size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.19, size.height * 0.66,
      size.width * 0.27, size.height * 0.54,
    );
    path1.quadraticBezierTo(
      size.width * 0.37, size.height * 0.4,
      size.width * 0.49, size.height * 0.59,
    );
    path1.quadraticBezierTo(
      size.width * 0.62, size.height * 0.7,
      size.width * 0.72, size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.87, size.height * 0.2,
      size.width * 1, size.height * 0.54,
    );

    final path2 = Path();
    path2.quadraticBezierTo(
      size.width * 0.0, size.height * 0.15,
      size.width * 0.13, size.height * 0.5,
    );
    path2.quadraticBezierTo(
      size.width * 0.19, size.height * 0.66,
      size.width * 0.27, size.height * 0.54,
    );
    path2.quadraticBezierTo(
      size.width * 0.37, size.height * 0.4,
      size.width * 0.49, size.height * 0.59,
    );
    path2.quadraticBezierTo(
      size.width * 0.62, size.height * 0.7,
      size.width * 0.72, size.height * 0.5,
    );
    path2.quadraticBezierTo(
      size.width * 0.87, size.height * 0.2,
      size.width * 1, size.height * 0.54,
    );

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
