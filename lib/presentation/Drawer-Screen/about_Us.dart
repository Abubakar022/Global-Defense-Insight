import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // Infinite animation
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
      transform: GradientRotation(_controller.value * 6.28), // 360 degrees
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
            style:
                style.copyWith(color: Colors.white), // Required for ShaderMask
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    appBar: AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0,right: 16,left: 16),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gspace.spaceVertical(0),
                _animatedGradientText(
                  "About Us",
                  textTheme.headlineLarge!.copyWith(fontSize: 40),
                ),
                Gspace.spaceVertical(10),
                Text(
                  "Global Defense Insight is a non-partisan publication focusing on the business of defense, aerospace, and national security",
                  style: textTheme.headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Gspace.spaceVertical(20),
                _animatedGradientText(
                  "What We Do",
                  textTheme.headlineLarge!.copyWith(fontSize: 40),
                ),
                Gspace.spaceVertical(10),
                Text(
                  "Global Defense Insight is a non-partisan publication focusing on the business of defense, aerospace, and national security. We aim to inform, engage and empower the world by providing timely, impartial, and accurate information from the defense sector",
                  style: textTheme.headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Gspace.spaceVertical(5),
                Text(
                  "Moreover, the company aims to provide innovative and effective integrated brand marketing and public relations solutions that help our clients grow their businesses and realize their marketing goals. We highly value our audiences and clients, considering them to be at the heart of everything we do",
                  style: textTheme.headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Gspace.spaceVertical(5),
                Text(
                  "Owing to this regard, we consider creativity and accountability our core values. Our audience ranges from government officials, military personnel, and industry professionals to academicians",
                  style: textTheme.headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Gspace.spaceVertical(5),
                Container(
                  width: double.infinity,
                  height: height * 0.29,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade200, // Optional background
                  ),
                  clipBehavior: Clip.hardEdge, // Needed for rounded corners
                  child: Image.asset(
                    "assets/images/vector.jpeg",
                    fit: BoxFit.cover, // 👈 keeps aspect ratio, no distortion
                  ),
                ),
                 Gspace.spaceVertical(20),
                _animatedGradientText(
                  "Read well, be smart...",
                  textTheme.headlineLarge!.copyWith(fontSize: 25),
                ),
                Gspace.spaceVertical(10),
                Text(
                  "Unlock the power of knowledge with our curated selection of insightful reads. Enhance your intellect and stay informed with Read Well, Be Smart",
                  style: textTheme.headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
