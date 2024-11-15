import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy_auth/otp_verify.dart';
import 'widgets/button.dart';

class MobileNo extends StatefulWidget {
  final String lang;
  MobileNo({required this.lang});
  @override
  State<MobileNo> createState() => _MobileNoState(lang: lang);
}

class _MobileNoState extends State<MobileNo> {
  TextEditingController mobile_number = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String lang;
  _MobileNoState({required this.lang});

  sendcode() async {
    if (mobile_number.text.isEmpty || mobile_number.text.length != 10) {
      Get.snackbar('Error', 'Invalid mobile number');
      return;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + mobile_number.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle auto verification here if needed
        },
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage = e.message ?? 'An unknown error occurred';
          Get.snackbar('Error Occurred', errorMessage);
        },
        codeSent: (String vid, int? token) {
          Get.to(
            OTPverification(
              mobile_number: mobile_number.text,
              vid: vid,
              lang: lang,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String vid) {
          // Handle timeout here if necessary
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occurred', e.message ?? 'An unknown error occurred');
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(
                    lang == 'English'
                        ? 'Please enter your mobile number'
                        : 'कृपया अपना मोबाइल नंबर दर्ज करें',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: lang == 'English' ? 'Roboto' : 'HindiFonts',
                    ),
                  ),
                  Text(
                    lang == 'English'
                        ? "You'll receive a 6 digit code\nto verify next"
                        : 'आपको 6 अंकों का कोड प्राप्त होगा\nअगला सत्यापन करने के लिए',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: lang == 'English' ? 'Roboto' : 'HindiFonts',
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mobile_number,
                      decoration: InputDecoration(
                        prefix: Text('+91'),
                        prefixIcon: Icon(Icons.phone),
                        labelText: lang == 'English' ? 'Mobile Number' : 'मोबाइल नंबर',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return lang == 'English' ? 'Please enter your mobile number' : 'कृपया अपना मोबाइल नंबर दर्ज करें';
                        }
                        if (value.length != 10) {
                          return lang == 'English' ? 'Mobile number should be 10 digits' : 'मोबाइल नंबर 10 अंक होना चाहिए';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return lang == 'English' ? 'Please enter valid digits only' : 'कृपया केवल मान्य अंक दर्ज करें';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 380,
                      child: Button(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // All validations passed
                            sendcode();

                          }
                        },
                        text: lang == 'English' ? 'CONTINUE' : 'जारी रखें',
                      ),
                    ),
                  ),
                ],
              ),
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
      ..color = Color(0XFF46A6DD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;

    final paint2 = Paint()
      ..color = Color(0xFF0E66AE)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(size.width, size.height * 0.0);
    path1.quadraticBezierTo(
      size.width * 1.0, size.height * 0.1,
      size.width * 0.88, size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.81, size.height * 0.66,
      size.width * 0.73, size.height * 0.54,
    );
    path1.quadraticBezierTo(
      size.width * 0.63, size.height * 0.4,
      size.width * 0.51, size.height * 0.59,
    );
    path1.quadraticBezierTo(
      size.width * 0.38, size.height * 0.7,
      size.width * 0.28, size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.13, size.height * 0.2,
      0, size.height * 0.54,
    );

    final path2 = Path();
    path2.moveTo(size.width, size.height * 0.0);
    path2.quadraticBezierTo(
      size.width * 1.0, size.height * 0.15,
      size.width * 0.87, size.height * 0.5,
    );
    path2.quadraticBezierTo(
      size.width * 0.81, size.height * 0.66,
      size.width * 0.73, size.height * 0.54,
    );
    path2.quadraticBezierTo(
      size.width * 0.63, size.height * 0.4,
      size.width * 0.51, size.height * 0.59,
    );
    path2.quadraticBezierTo(
      size.width * 0.38, size.height * 0.7,
      size.width * 0.28, size.height * 0.5,
    );
    path2.quadraticBezierTo(
      size.width * 0.13, size.height * 0.2,
      0, size.height * 0.54,
    );

    path2.lineTo(0, size.height);
    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
