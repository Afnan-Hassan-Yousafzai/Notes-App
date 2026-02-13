import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/boxes/boxes.dart';
import 'package:notepad/colors/color.dart';
import 'package:notepad/components/note_card.dart';
import 'package:notepad/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class NotepadPage extends StatefulWidget {
  const NotepadPage({super.key});

  @override
  State<NotepadPage> createState() => _NotepadPageState();
}

class _NotepadPageState extends State<NotepadPage> {
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paleOak,
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, top: 60),
            decoration: BoxDecoration(
              color: stoneBrown,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            child: Text(
              'Notes',
              // style: TextStyle(
              //   color: levenderMist,
              //   fontSize: 24,
              //   fontWeight: FontWeight.bold,
              // ),
              style: GoogleFonts.dancingScript(fontSize: 28, fontWeight: FontWeight.bold, color: levenderMist)
            ),
          ),

          Expanded(
            child: ValueListenableBuilder<Box<Models>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var notes = box.values.toList().cast<Models>();

                if (notes.isEmpty) {
                  return Center(
                    child: Text(
                      "No notes yet!",
                      style: TextStyle(color: stoneBrown),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items in a row
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.85, // Isse card ki height adjust hogi
                    ),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteCard(note: note);
                    },
                    itemCount: notes.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _openNoteEditor(context);
        },

        backgroundColor: stoneBrown,
        foregroundColor: levenderMist,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openNoteEditor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true, // Isse close icon automatically mil jata hai
        builder: (context) => Scaffold(
          backgroundColor: paleOak,
          body: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                decoration: BoxDecoration(
                  color: stoneBrown,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: levenderMist, size: 28),
                    ),
                    Text(
                      'Add Note',
                      style: GoogleFonts.dancingScript(fontSize: 28, fontWeight: FontWeight.bold, color: levenderMist)
                    ),
                    IconButton(
                      onPressed: () {
                        final data = Models(
                          title: titleController.text,
                          content: discriptionController.text,
                        );
                        final box = Boxes.getData();
                        if (data.title.isNotEmpty || data.content.isNotEmpty) {
                          box.add(data);

                          data.save();
                        }
                        titleController.clear();
                        discriptionController.clear();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check, color: levenderMist, size: 28),
                    ),
                  ],
                ),
              ),
              // Title Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  style: GoogleFonts.dancingScript(fontSize: 22, fontWeight: FontWeight.bold, color: stoneBrown),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: stoneBrown,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(thickness: 1, color: stoneBrown),
              // Description Field (The "Page" area)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: discriptionController,
                    maxLines: null, // Unlimited lines
                    expands: true, // Pure screen cover karega
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: stoneBrown,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Start typing your note...',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: stoneBrown,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
