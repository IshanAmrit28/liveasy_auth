import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liveasy_auth/profile.dart';
import 'package:pinput/pinput.dart';

import 'widgets/button.dart';

class OTPverification extends StatefulWidget {
  final String mobile_number;
  final String vid;
  final String lang;

  OTPverification({super.key, required this.mobile_number, required this.vid, required this.lang});

  @override
  _OTPverificationState createState() => _OTPverificationState();
}

class _OTPverificationState extends State<OTPverification> {
  var code = '';

  // Texts in different languages
  String englishText1 = 'Please select your Language';
  String englishText2 = 'You can change the language \nat any time.';
  String hindiText1 = 'कृपया अपनी भाषा का चयन करें';
  String hindiText2 = 'आप किसी भी समय भाषा \nबदल सकते हैं।';


  @override
  void initState() {
    super.initState();

  }

  sendcode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + widget.mobile_number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage = e.message ?? 'An unknown error occurred';
          Get.snackbar('Error Occurred', errorMessage);
        },
        codeSent: (String vid, int? token) {
          Get.to(OTPverification(mobile_number: widget.mobile_number, vid: vid, lang: widget.lang));
        },
        codeAutoRetrievalTimeout: (String vid) {},
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'An unknown error occurred';
      Get.snackbar('Error Occurred', errorMessage);
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }

  signIn() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.vid,
        smsCode: code,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(ProfileSelectionScreen(lang: widget.lang,));
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occurred', e.message ?? 'An unknown error occurred');
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }

  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    // Choosing texts based on language selection (English or Hindi)
    String text1 = widget.lang == 'English' ? englishText1 : hindiText1;
    String text2 = widget.lang == 'English' ? englishText2 : hindiText2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Verify Phone',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            Center(
              child: Text(
                'Code is sent to ${widget.mobile_number}',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24.0),
            otpcode(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  widget.lang == 'English' ? "Didn't receive the code?" : "कोड नहीं मिला?",
                  style: TextStyle(fontSize: 14.0),
                ),
                TextButton(
                  onPressed: () {
                    sendcode();
                  },
                  child: Text(widget.lang == 'English' ? 'Request Again' : 'फिर से अनुरोध करें'),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Button(
              onPressed: () {
                if (code.length == 6) {
                  signIn();

                } else {
                  Get.snackbar('Invalid OTP', widget.lang == 'English' ? 'Please enter a valid 6-digit OTP' : 'कृपया एक वैध 6-अंकीय OTP दर्ज करें');
                }
              },
              text: widget.lang == 'English' ? 'VERIFY AND CONTINUE' : 'सत्यापित करें और जारी रखें',
            ),
          ],
        ),
      ),
    );
  }

  Widget otpcode() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {

            setState(() {
              code = value;
            });
          },
        ),
      ),
    );
  }
}
