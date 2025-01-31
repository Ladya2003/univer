abstract class DevTools {
  void useIDE();
  void useVersionControl();
}

// Асинхронный метод для получения данных
Future<void> fetchData() async {
  print("Fetching data...");
  await Future.delayed(Duration(seconds: 2));
  print("Data fetched");
}

// Future для получения данных разработчика
Future<String> fetchDeveloperData() {
  return Future.delayed(Duration(seconds: 2), () => 'Vlad, Frontend Developer');
}

// Single subscription stream
// Этот тип потока позволяет подписаться только одному слушателю.
Stream<int> generateNumbers() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// Broadcast stream
// Этот тип потока позволяет многим слушателям подписываться на поток одновременно.
Stream<int> broadcastStreamExample() {
  return Stream<int>.periodic(Duration(seconds: 1), (x) => x).asBroadcastStream();
}
