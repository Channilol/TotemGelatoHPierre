import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

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
  final CountdownController _controller = CountdownController();
  final _passwordController = TextEditingController();
  bool _isCorrect = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _controller.restart();
    _controller.pause();
    _passwordController.dispose();

    super.dispose();
  }

  // Timer? timer;
  // int timerCount = 10;
  // bool killTimerCount = false;

  // void printTimer(int target) async {
  //   if (timer == null) {
  //     setState(() {
  //       timerCount = target;
  //     });
  //     for (var i = target; i >= 0; i--) {
  //       if (killTimerCount) return;
  //       if (mounted)
  //         await Future.delayed(Duration(seconds: 1), () {
  //           print(i);
  //           setState(() {
  //             timerCount = i;
  //           });
  //         });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Inserisci la tua password",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword)),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Logica per gestire la password
              if (_passwordController.text == '1234') {
                setState(() => _isCorrect = true);
                _controller.start();
              } else {}
            },
            child: Text("Ok"),
          ),
          if (_isCorrect) ...[
            SizedBox(
              height: 20,
            ),
            Countdown(
                interval: const Duration(milliseconds: 10),
                //controller: _controller,
                seconds: 10,
                build: (context, double seconds) => Text(
                      "L'applicazione si chiuderà in ${seconds.toStringAsFixed(0)} secondi",
                      style:
                          TextStyle(fontSize: ResponsiveText.medium(context)),
                    ),
                onFinished: Utils.kill),
            if (_isCorrect)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('annulla'))
          ]
        ],
      ),
    );
  }
}
