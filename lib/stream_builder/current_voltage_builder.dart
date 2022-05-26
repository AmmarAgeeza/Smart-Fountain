import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

StreamBuilder<double> buildStreamBuilder2(Stream<double> stream, String text) {
  return StreamBuilder<double>(
    stream: stream,
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return const Center(child: Text('Some error occurred!'));
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' = ${snapshot.data!.toStringAsFixed(3) + (text == 'Current' ? ' A' : ' V')}',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: (snapshot.data! >= 1 && snapshot.data! < 10)
                      ? snapshot.data! / 10
                      : (snapshot.data! >= 10 && snapshot.data! < 100)
                          ? snapshot.data! / 100
                          : (snapshot.data! >= 100 && snapshot.data! < 1000)
                              ? snapshot.data! / 1000
                              : snapshot.data!,
                  center: Text(text),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                  animateFromLastPercent: true,
                  animation: true,
                  animationDuration: 700,
                ),
              ],
            );
          }
      }
    },
  );
}
