import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totem/components/dialog_wrapper.dart';
import 'package:totem/services/text.dart';

class KillAppPopup extends StatelessWidget {
  const KillAppPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PasswordContainerScreen();
  }
}

class PasswordContainerScreen extends StatefulWidget {
  @override
  _PasswordContainerScreenState createState() =>
      _PasswordContainerScreenState();
}

class _PasswordContainerScreenState extends State<PasswordContainerScreen> {
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();

    super.dispose();
  }

  Timer? timer;
  int timerCount = 10;
  bool killTimerCount = false;

  void printTimer(int target) async {
    if (timer == null) {
      setState(() {
        timerCount = target;
      });
      for (var i = target; i >= 0; i--) {
        if (killTimerCount) return;
        if (mounted)
          await Future.delayed(Duration(seconds: 1), () {
            print(i);
            setState(() {
              timerCount = i;
            });
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      child: Column(
        children: [
          Text(
            "Inserisci la tua password",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Logica per gestire la password
              if (_passwordController.text == 'Ciao') {
                printTimer(10);
                setState(() {
                  timer = Timer(Duration(seconds: 10), () {
                    exit(0);
                  });
                });

                /* Future.delayed(
                      Duration(seconds: 10),
                      Platform.isAndroid || Platform.isIOS
                          ? SystemNavigator.pop
                          : exit(0)) */
                ;
              } else {}
            },
            child: Text("Ok"),
          ),
          if (timer != null) ...[
            SizedBox(
              height: 20,
            ),
            Text(
              "L'applicazione si chiuderà in $timerCount secondi",
              style: TextStyle(fontSize: ResponsiveText.medium(context)),
            ),
            ElevatedButton(
                onPressed: () {
                  timer!.cancel();
                  setState(() {
                    timer = null;
                    killTimerCount = true;
                  });
                  Navigator.pop(context);
                },
                child: Text('annulla'))
          ]
        ],
      ),
    );
  }
}
