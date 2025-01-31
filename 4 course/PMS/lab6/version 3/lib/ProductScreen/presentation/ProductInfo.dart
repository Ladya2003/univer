import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInfo extends StatelessWidget {
  final List<String> images;
  final String description;
  final String textLeft;
  final String textRight;

  const ProductInfo({
    super.key,
    required this.images,
    required this.description,
    required this.textLeft,
    required this.textRight,
  });

  static const platform = MethodChannel('com.example.lab6/channel');

  Future<String> _getDeviceOrientation() async {
    try {
      final String result = await platform.invokeMethod('getOrientation');
      return result;
    } on PlatformException catch (e) {
      return "Не удалось получить ориентацию: '${e.message}'";
    }
  }

  Future<String> _getBatteryLevel() async {
    try {
      final int batteryLevel = await platform.invokeMethod('getBatteryLevel');
      return 'Уровень заряда батареи: $batteryLevel%';
    } on PlatformException catch (e) {
      return "Не удалось получить уровень заряда батареи: '${e.message}'";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(textLeft, style: const TextStyle(fontSize: 20.0)),
                            Text(textRight, style: const TextStyle(fontSize: 20.0)),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Text(description, style: const TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text('CHOOSE THE SIZE',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: 50.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var size in ['41', '42', '43', '44']) ...[
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                      child: Text(size,
                                          style: const TextStyle(fontSize: 16.0))),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () async {
                            String batteryLevel = await _getBatteryLevel();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Уровень заряда батареи'),
                                content: Text(batteryLevel),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String orientation = await _getDeviceOrientation();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Текущая ориентация'),
                                content: Text(orientation),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                          child: const Text('BUY', style: TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
