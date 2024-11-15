import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/button.dart';

class ProfileSelectionScreen extends StatefulWidget {
  final String lang; // Add language as a parameter

  ProfileSelectionScreen({super.key, required this.lang});

  @override
  _ProfileSelectionScreenState createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  bool _isShipperSelected = false;
  bool _isTransporterSelected = false;

  @override
  Widget build(BuildContext context) {
    // Conditional text based on selected language
    String profileSelectionText = widget.lang == 'English'
        ? 'Please select your profile'
        : 'कृपया अपनी प्रोफ़ाइल का चयन करें';

    String shipperText = widget.lang == 'English'
        ? 'Shipper'
        : 'शिपर';

    String transporterText = widget.lang == 'English'
        ? 'Transporter'
        : 'परिवहनकर्ता';

    String continueText = widget.lang == 'English'
        ? 'CONTINUE'
        : 'जारी रखें';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lang == 'English' ? 'Profile Selection' : 'प्रोफ़ाइल चयन'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              profileSelectionText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: ProfileOption(
                title: shipperText,
                icon: FontAwesomeIcons.warehouse,
                isSelected: _isShipperSelected,
                onPressed: () {
                  setState(() {
                    _isShipperSelected = true;
                    _isTransporterSelected = false;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 120,
              child: ProfileOption(
                title: transporterText,
                icon: Icons.local_shipping_outlined,
                isSelected: _isTransporterSelected,
                onPressed: () {
                  setState(() {
                    _isTransporterSelected = true;
                    _isShipperSelected = false;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Button(
              onPressed: () {
                if (_isShipperSelected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipperScreen(lang: widget.lang),
                    ),
                  );
                } else if (_isTransporterSelected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransporterScreen(lang: widget.lang),
                    ),
                  );
                }
              },
              text: continueText,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  const ProfileOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade700 : Colors.grey[200],
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 30.0, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShipperScreen extends StatelessWidget {
  final String lang;

  ShipperScreen({required this.lang});

  @override
  Widget build(BuildContext context) {
    String welcomeText = lang == 'English'
        ? 'Welcome to the Shipper Screen!'
        : 'शिपर स्क्रीन में आपका स्वागत है!';

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'English' ? 'Shipper Screen' : 'शिपर स्क्रीन'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color(0xFF152968),
        child: Center(
          child: Text(
            welcomeText,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class TransporterScreen extends StatelessWidget {
  final String lang;

  TransporterScreen({required this.lang});

  @override
  Widget build(BuildContext context) {
    String welcomeText = lang == 'English'
        ? 'Welcome to the Transporter Screen!'
        : 'परिवहनकर्ता स्क्रीन में आपका स्वागत है!';

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'English' ? 'Transporter Screen' : 'परिवहनकर्ता स्क्रीन'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color(0xFF152968),
        child: Center(
          child: Text(
            welcomeText,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
