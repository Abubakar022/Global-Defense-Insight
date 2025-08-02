import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Shader _createAnimatedGradient(Rect bounds) {
    return LinearGradient(
      colors: const [Colors.blue, Colors.purple, Colors.red],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(_controller.value * 2 * pi),
    ).createShader(bounds);
  }

  Widget _animatedGradientText(String text, double size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => _createAnimatedGradient(bounds),
          child: Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  Widget _buildContactButton(
      {required IconData icon,
      required String label,
      required String url,
      Color baseColor = const Color(0xFF0047AB)}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: baseColor,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 6,
        ),
        onPressed: () => _launchUrl(url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       
    appBar: AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              _animatedGradientText("Contact Us", 36),
              const SizedBox(height: 10),
              const Text(
                "We aim to inform, engage and empower the world by providing timely, impartial, and accurate information from the defense sector.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              _animatedGradientText("Office Location", 22),
              const SizedBox(height: 10),
              const Text(
                "Dubai Media City, Dubai, United Arab Emirates",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              _buildContactButton(
                icon: FontAwesomeIcons.mapLocation,
                label: "View on Google Maps",
                url:
                    "https://www.google.com/maps/place/Al+Sufouh+-+Dubai+Media+City+-+Dubai+-+United+Arab+Emirates/@25.1094911,55.1806012,12.18z",
              ),

              const SizedBox(height: 30),
              _animatedGradientText("Email Address", 22),
              _buildContactButton(
                icon: Icons.email_outlined,
                label: "info@defensetalks.com",
                url: "mailto:info@defensetalks.com",
              ),
              _buildContactButton(
                icon: Icons.email,
                label: "communications@defensetalks.com",
                url: "mailto:communications@defensetalks.com",
              ),

              const SizedBox(height: 30),
              _animatedGradientText("Connect With Us", 22),

             
              _buildContactButton(
                icon: FontAwesomeIcons.linkedin, // LinkedIn alternative icon
                label: "Visit LinkedIn",
                url: "https://www.linkedin.com/company/global-defense-insight/",
                baseColor: Colors.blue.shade700,
              ),
             
              _buildContactButton(
                icon: FontAwesomeIcons.instagram,
                label: "Visit Instagram",
                url: "https://www.instagram.com/defense_talks/",
                baseColor: Colors.purple,
              ),
              _buildContactButton(
                icon: FontAwesomeIcons.facebook,
                label: "Visit Facebook",
                url: "https://www.facebook.com/GlobalDefenseInsight/",
                baseColor: Colors.indigo,
              ),
               _buildContactButton(
                icon: FontAwesomeIcons.threads,
                label: "Visit Threads",
                url: "https://www.threads.com/@defense_talks/",
                baseColor: Color(0xFF1C1C1E),
              ),
               _buildContactButton(
                icon: FontAwesomeIcons.whatsapp,
                label: "Join WhatsApp Channel",
                url:
                    "https://www.whatsapp.com/channel/0029VaH9YL3Fi8xa2DgIfm2w",
                baseColor: Colors.green.shade700,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
