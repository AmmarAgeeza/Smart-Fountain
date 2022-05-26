
import 'package:flutter/material.dart';

StreamBuilder<double> buildStreamBuilder(Stream<double> stream, String text) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                  overflow:TextOverflow.ellipsis,

                ),
                Text(
                  ' = ${snapshot.data!.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                overflow:TextOverflow.ellipsis,

                ),
              ],
            );
          }
      }
    },
  );
}