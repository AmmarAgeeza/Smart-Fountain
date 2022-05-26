import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
StreamBuilder<double> buildStreamBuilder3(Stream<double> stream, String text) {
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
            double data = snapshot.data!;

            data > 10
                ? Fluttertoast.showToast(
                msg: "has sustained the effectiveness value",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0)
                : null;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      ' = ${snapshot.data!.toStringAsFixed(0) + ' W'}',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ],
            );
          }
      }
    },
  );
}