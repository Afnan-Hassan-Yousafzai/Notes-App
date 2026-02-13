import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad/colors/color.dart';
import 'package:notepad/models/models.dart';

class NoteDetailPage extends StatefulWidget {
  final Models note;

  const NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    widget.note.title = _titleController.text;
    widget.note.content = _contentController.text;
    await widget.note.save();
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paleOak,

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
            decoration: BoxDecoration(
              color: stoneBrown,
              borderRadius: BorderRadius.only(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 44,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: levenderMist, size: 28),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    _titleController.text.isEmpty
                        ? 'Note'
                        : _titleController.text,
                    maxLines: 1,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: levenderMist,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: IconButton(
                    onPressed: _isEditing
                        ? _saveNote
                        : () => setState(() {
                            _isEditing = true;
                          }),
                    icon: Icon(
                      _isEditing ? Icons.check : Icons.edit,
                      color: levenderMist,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isEditing
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          style: GoogleFonts.dancingScript(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: stoneBrown,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Title',
                            hintStyle: GoogleFonts.dancingScript(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: stoneBrown,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(thickness: 1, color: stoneBrown),
                        Expanded(
                          child: TextField(
                            controller: _contentController,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.top,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              height: 1.6,
                              color: stoneBrown,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Start typing your note...',
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: stoneBrown,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.note.content.isEmpty
                            ? 'Empty Note...'
                            : widget.note.content,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          height: 1.6,
                          color: stoneBrown,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
