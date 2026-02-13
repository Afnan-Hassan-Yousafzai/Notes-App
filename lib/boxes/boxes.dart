
import 'package:hive/hive.dart';
import 'package:notepad/models/models.dart';

class Boxes {
    
    static Box<Models> getData() => Hive.box<Models>('notes');
}