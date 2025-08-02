import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class SubmissionGuidelines extends StatefulWidget {
  const SubmissionGuidelines({super.key});

  @override
  State<SubmissionGuidelines> createState() => _SubmissionGuidelinesState();
}

class _SubmissionGuidelinesState extends State<SubmissionGuidelines>
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
            textAlign: TextAlign.left,
          ),
        );
      },
    );
  }

 
    void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'Submissions@defensetalks.com',
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

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
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
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align all left
          children: [
            _animatedGradientText("Submission Guidelines", 32),
            const SizedBox(height: 20),

            const Text(
              "Global Defense Insight seeks original ideas and analyses on topics of International Relations and Security Studies...",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            _animatedGradientText("Submission Requirements", 22),
            const SizedBox(height: 10),

            _bulletPoint("Opinions presented in the paper should be backed by facts."),
            _bulletPoint("The article’s length should lie between 800 and 1500 words."),
            _bulletPoint("Plagiarized content will not be accepted."),
            _bulletPoint("Submit your article in MS Word format."),
            _bulletPoint("Include your author bio and picture in the email."),

            const SizedBox(height: 20),
            _animatedGradientText("Evaluation & Publishing Policy", 22),
            const SizedBox(height: 10),
            const Text(
              "After submission, please allow up to one week (excluding weekends)...",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "Due to high submission volume, only selected pieces will receive confirmation...",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            _animatedGradientText("Exclusivity Clause", 22),
            const SizedBox(height: 10),
            const Text(
              "Due to possible copyright and legal restrictions, all articles submitted must be exclusive to Global Defense Insight.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 30),

            Center(
              child: GestureDetector(
                onTap: _launchEmail,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0047AB),
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
                        "📧 Submit Your Article",
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
    ],
  ),
),

    );
  }
}
