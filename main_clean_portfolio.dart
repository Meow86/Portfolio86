// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const PortfolioPage());
  }
}

// Упрощённая версия портфолио.
// Добавь в pubspec.yaml:
// dependencies:
//   url_launcher: ^6.3.0

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final intro = GlobalKey();
  final works = GlobalKey();
  final about = GlobalKey();
  final contacts = GlobalKey();

  void go(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [

        // Линия
        Positioned(
          left: 79,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            color: Colors.white,
          ),
        ),

        SingleChildScrollView(
          child: Column(children: [
            _section(intro, "Введение", true, const Text("Меня зовут Эрман Данила.\nЯ работаю Flutter-разработчиком.", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
            _section(works, "Работы", false, const Text("Здесь располагаются карточки проектов.")),
            _section(about, "Обо мне", true, const Text("• ИИ\n• Документация\n• Видео\n\n• BLoC/Cubit и SOLID")),
            _section(contacts, "Контакты", false, const _Contacts()),
          ]),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              const Text("<86>", style: TextStyle(fontSize: 52, color: Color(0xFF6FFFCF), fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(onPressed: ()=>go(intro), child: const Text("Введение")),
              TextButton(onPressed: ()=>go(works), child: const Text("Работы")),
              TextButton(onPressed: ()=>go(about), child: const Text("Обо мне")),
              TextButton(onPressed: ()=>go(contacts), child: const Text("Контакты")),
            ]),
          ),
        )
      ]),
    );
  }

  Widget _section(GlobalKey key, String title, bool gray, Widget child) {
    return Container(
      key: key,
      constraints: const BoxConstraints(minHeight: 800),
      color: gray ? const Color(0xFF181818) : Colors.black,
      padding: const EdgeInsets.fromLTRB(40, 140, 40, 80),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 80,
          child: Column(children: [
            Container(
              width: 18,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            )
          ]),
        ),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          child,
        ]))
      ]),
    );
  }
}

class _Contacts extends StatelessWidget {
  const _Contacts();

  Future<void> open(String url) async => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ElevatedButton(onPressed: ()=>open("https://t.me/username"), child: const Text("Telegram")),
      const SizedBox(height: 12),
      ElevatedButton(onPressed: ()=>open("mailto:test@example.com"), child: const Text("Email")),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () async {
          await Clipboard.setData(const ClipboardData(text: "+79519930769"));
        },
        child: const Text("+79519930769"),
      )
    ]);
  }
}
