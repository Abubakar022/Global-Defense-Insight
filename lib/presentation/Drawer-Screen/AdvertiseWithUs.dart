import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class AdvertiseWithUs extends StatefulWidget {
  const AdvertiseWithUs({super.key});

  @override
  State<AdvertiseWithUs> createState() => _AdvertiseWithUsState();
}

class _AdvertiseWithUsState extends State<AdvertiseWithUs>
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

  Widget _animatedGradientText(String text, TextStyle style) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => _createAnimatedGradient(bounds),
          child: Text(
            text,
            style: style.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'Advertise@defensetalks.com',
      query: Uri.encodeFull('subject=Advertising Inquiry&body=Hello GDI Team, I\'m interested in advertising...'),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open email client.")),
      );
    }
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
        padding: const EdgeInsets.only(right: 16,bottom: 16,left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
             _animatedGradientText(
              "Advertise With Us",
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Center(
            //   child: _animatedGradientText(
            //     "Advertise With Us",
            //     Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 36, fontWeight: FontWeight.bold),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              "Global Defense Insight is a non-partisan publication focusing on the business of defense, aerospace, and national security.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Advertise with Global Defense Insight → Reach the Global Defense Audience\n",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Global Defense Insight (GDI) is a leading platform for defense, aerospace, and security news, analysis, and insights...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _animatedGradientText(
              "Why Advertise with Us?",
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("1. Targeted Defense Audience", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Our platform is trusted by defense professionals, government officials..."),
            const SizedBox(height: 8),
            const Text("2. Global Reach with Regional Focus", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Connect with audiences across Asia, Middle East, Europe, and beyond."),
            const SizedBox(height: 8),
            const Text("3. Rapidly Growing Platform", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("• Website Traffic: Thousands of monthly visits\n• LinkedIn: 12,000+ followers\n• Newsletters: Targeted subscribers"),
            const SizedBox(height: 8),
            const Text("4. Competitive Edge", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Gain visibility and strategic edge over your competitors."),
            const SizedBox(height: 20),
            _animatedGradientText(
              "Our Advertising Solutions",
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("1. Website Banner Ads\n2. Sponsored Content\n3. Newsletter Promotions\n4. Social Media Promotions\n5. Customized Campaigns",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _animatedGradientText(
              "Who Should Advertise?",
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "• Defense & aerospace manufacturers\n"
              "• Security technology providers\n"
              "• Trade show organizers\n"
              "• Government defense agencies\n"
              "• Defense startups and more...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Partner with Us Today\n"
              "At Global Defense Insight, we are committed to helping your brand stand out.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // 🔵 Gmail Button
            Center(
              child: GestureDetector(
                onTap: _launchEmail,
                child: Container(
                  width: width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0047AB), // Main GDI blue
                        Color(0xFF1E90FF),
                        Color(0xFF66B2FF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "📧 Let’s Discuss Your Goals",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
