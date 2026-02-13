import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/colors/color.dart';
import 'package:notepad/models/models.dart';
import 'package:notepad/pages/note_detail_page.dart';

class NoteCard extends StatelessWidget {
  final Models note;
  const NoteCard({super.key, required this.note});
  // Delete confirmation dialog function
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: stoneBrown,
        title: Text(
          "Delete Note",
          style: GoogleFonts.dancingScript(color: levenderMist),
        ),
        content: Text(
          "Are you sure you want to delete this note?",
          style: GoogleFonts.montserrat(color: levenderMist),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.montserrat(color: levenderMist),
            ),
          ),
          TextButton(
            onPressed: () {
              note.delete(); // HiveObject ki wajah se ye direct delete kar dega
              Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: GoogleFonts.montserrat(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _showDeleteDialog(context),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteDetailPage(note: note)),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: stoneBrown,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.dancingScript(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: levenderMist,
              ),
            ),
            SizedBox(height: 5),
            Divider(color: greyOlive, thickness: 1),
            Expanded(
              child: Text(
                note.content.toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: levenderMist,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
