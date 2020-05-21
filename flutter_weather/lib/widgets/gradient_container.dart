import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/widgets.dart';
import 'package:meta/meta.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor colour;

  const GradientContainer({
    Key key,
    @required this.child,
    @required this .colour,
  }) : assert(child !=null, colour != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.6, 0.8, 1.0],
          colors: [
            colour[700],
            colour[500],
            colour[300]
          ],
        ),
      ),
      child: child,
      // Will show child view, in this case the combined_weather_temperature
    );
  }
}