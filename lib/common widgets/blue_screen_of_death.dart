import 'package:flutter/material.dart';
import 'package:products/log_in.dart';
import '../const.dart';

class BlueScreenOfDeath extends StatefulWidget {
  const BlueScreenOfDeath({Key? key}) : super(key: key);

  @override
  _BlueScreenOfDeathState createState() => _BlueScreenOfDeathState();
}

class _BlueScreenOfDeathState extends State<BlueScreenOfDeath> {
  TextEditingController urlController = TextEditingController(text: baseUrl2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade900,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Text(
                "Blue Screen Of Death!",
                style: TextStyle(color: Colors.yellow),
              ),
              TextField(
                style: const TextStyle(color: Colors.yellow),
                controller: urlController,
                maxLines: 8,
              ),
              IconButton(onPressed: changeUrl, icon: const Icon(Icons.done)),
              const SizedBox(
                height: 50,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
        ),
      ),
    );
  }

  void changeUrl() {
    print("changeUrl1111 = $baseUrl2");
    baseUrl2 = urlController.text;
    print("changeUrl2222 = $baseUrl2");
  }
}
