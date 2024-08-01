import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:totem/components/keyboard_delete.dart';
import 'package:totem/components/keyboard_key.dart';
import 'package:totem/providers/password_provider.dart';
import 'package:totem/services/text.dart';
import 'package:totem/services/utils.dart';

class KillAppPopup extends StatelessWidget {
  const KillAppPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PasswordContainerScreen();
  }
}

class PasswordContainerScreen extends ConsumerStatefulWidget {
  @override
  _PasswordContainerScreenState createState() =>
      _PasswordContainerScreenState();
}

class _PasswordContainerScreenState
    extends ConsumerState<PasswordContainerScreen> {
  final CountdownController _controller = CountdownController();
  final _passwordController = TextEditingController();
  bool _isCorrect = false;
  bool _obscurePassword = true;
  bool _wrongPassword = false;
  bool _isKeyboardOn = false;

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
    var passString = ref.watch(passwordProvider);

    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Inserisci la tua password",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          // TextFormField(
          //   keyboardType: TextInputType.number,
          //   controller: _passwordController,
          //   obscureText: _obscurePassword,
          //   decoration: InputDecoration(
          //     labelText: "Password",
          //     border: OutlineInputBorder(),
          //     suffixIcon: IconButton(
          //         icon: Icon(
          //           _obscurePassword ? Icons.visibility : Icons.visibility_off,
          //         ),
          //         onPressed: () =>
          //             setState(() => _obscurePassword = !_obscurePassword)),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isKeyboardOn = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text('${passString}'),
            ),
          ),
          _isKeyboardOn ? SizedBox(height: 16.0) : SizedBox(),
          _isKeyboardOn
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyboardKey(keyNum: 1),
                        KeyboardKey(keyNum: 2),
                        KeyboardKey(keyNum: 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyboardKey(keyNum: 4),
                        KeyboardKey(keyNum: 5),
                        KeyboardKey(keyNum: 6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KeyboardKey(keyNum: 7),
                        KeyboardKey(keyNum: 8),
                        KeyboardKey(keyNum: 9),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KeyboardDelete(),
                      ],
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Logica per gestire la password
              if (passString == '1234') {
                setState(() {
                  _wrongPassword = false;
                  _isCorrect = true;
                  _isKeyboardOn = false;
                });
              } else {
                setState(() {
                  _wrongPassword = true;
                });
              }
            },
            child: Text("Ok"),
          ),
          _wrongPassword ? Text('PASSWORD SBAGLIATA') : SizedBox(),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('annulla'),
            ),
          ],
        ],
      ),
    );
  }
}
