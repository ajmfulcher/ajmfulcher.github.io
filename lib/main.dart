import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

const double containerMaxWidth = 1200;

const header = "andrewfulcher.dev";
const title = "Mobile Architect | Android Nerd";
const body = "Seeing how far you can get down the path of building a website and app from one codebase using Flutter. It's an interesting journey.";

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2, double clampedWidth = containerMaxWidth}) {
    final width = min(MediaQuery.of(context).size.width, clampedWidth);
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

enum ScreenSize {
  small(300),
  normal(400),
  large(600),
  extraLarge(1200);

  final double size;

  const ScreenSize(this.size);
}

ScreenSize getScreenSize(BuildContext context) {
  double deviceWidth = MediaQuery.sizeOf(context).shortestSide;
  if (deviceWidth > ScreenSize.extraLarge.size) return ScreenSize.extraLarge;
  if (deviceWidth > ScreenSize.large.size) return ScreenSize.large;
  if (deviceWidth > ScreenSize.normal.size) return ScreenSize.normal;
  return ScreenSize.small;
}

double getGutterWidth(BuildContext context) {
  switch(getScreenSize(context)) {
    case ScreenSize.small:
      return 20;
    case ScreenSize.normal || ScreenSize.large:
      return 40;
    case ScreenSize.extraLarge:
      return 80;
  }
}

double getHeaderPadding(BuildContext context) {
  switch(getScreenSize(context)) {
    case ScreenSize.small || ScreenSize.normal:
      return 0;
    case ScreenSize.large:
      return 20;
    case ScreenSize.extraLarge:
      return 40;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    double gutter = getGutterWidth(context);
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: containerMaxWidth * 1.7),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              top: 40,
              bottom: 40,
              left: gutter,
              right: gutter
            ),
            child: const Column(
              children: [
                Header(),
                Profile()
              ],
            )
        )
        )
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    double headerPadding = getHeaderPadding(context);
    return Container(
      padding: EdgeInsets.only(top: headerPadding, bottom: headerPadding),
      alignment: Alignment.topLeft,
      constraints: const BoxConstraints(maxWidth: containerMaxWidth),
      child: Text(
        header,
        style: Theme.of(context).textTheme.headlineSmall,
        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context, maxTextScaleFactor: 3)),
      )
    );
  }

}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Container(
      padding: const EdgeInsets.only(top: 80, bottom: 80),
      constraints: const BoxConstraints(maxWidth: containerMaxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context, maxTextScaleFactor: 3)),
          ),
          const SizedBox(height: 40,),
          Container(
            constraints: const BoxConstraints(maxWidth: containerMaxWidth/2),
            child: Text(
              body,
              style: Theme.of(context).textTheme.bodyLarge,
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context, maxTextScaleFactor: 3, clampedWidth: containerMaxWidth/2)),
            ),
          ),
        ],
      )
    );
  }

}
