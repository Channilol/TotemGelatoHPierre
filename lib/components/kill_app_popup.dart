import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totem/components/dialog_wrapper.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DialogWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                    Timer(
                        Duration(seconds: 10),
                        Platform.isAndroid || Platform.isIOS
                            ? SystemNavigator.pop
                            : exit(0));
                  } else {}
                },
                child: Text("Ok"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
