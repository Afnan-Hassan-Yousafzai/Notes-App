import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notepad/models/models.dart';
import 'package:notepad/pages/notepad_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(ModelsAdapter());

  final box = await Hive.openBox<Models>('notes');
  if (box.isEmpty) {
    // Seed a default note on first launch.
    await box.add(
      Models(
        title: 'About Developer',
        content: 'Afnan Hassan\nI am a passionate Flutter developer with a keen interest in building beautiful and functional mobile applications. This notepad app is one of my projects to help users organize their thoughts and ideas efficiently.\n\nFeel free to reach out to me for collaborations or inquiries!\n\nHappy Note-taking!',
      ),
      
    );
    await box.add(
      Models(
        title: 'Guide to Using the Notepad App',
        content: 'Press the + button to add a new note.\nTap on a note to view or edit it.\n\nLong press on a note to delete it.',
      ),
      
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotepadPage(),
    );
  }
}
