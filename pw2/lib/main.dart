import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(
    home: Notes(),
    debugShowCheckedModeBanner: false,
  ));
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<String> _notes = ['напоить джафара... а нет, он же ниииииг........'];
  final TextEditingController _controller = TextEditingController();

  void _addNote() {
    final text = _controller.text.trim();

    if(text.isEmpty){
      return;
    }
    setState(() {
      _notes.insert(0, text);
    });

    _controller.clear();
    FocusScope.of(context).unfocus();
  }
  void _deleteNote(int index){
    final removed = _notes.removeAt(index);
    setState(() {
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Заметка удалена"),
          action: SnackBarAction(label: "Отмена", onPressed: () {
            setState(() {
              _notes.insert(index, removed);
            });
          } ),

        )
    );
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(child: TextField(

              decoration:InputDecoration(
                  hintText: "Введите заметку",
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )
              ) ,

              controller: _controller,
              )
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addNote,
              child: const Text('Сохранить'),
            ),
          ]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                  onTap:() => _editNote(index) ,
                  trailing: IconButton(onPressed: () => _deleteNote(index), icon: const Icon(Icons.delete)),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _editNote(int index) async {
    final dialogController = TextEditingController(text: _notes[index]);

    final result = await showDialog <String>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Редактирование "),
            content: TextField(
              controller: dialogController,
              autofocus: true,
              decoration: const InputDecoration(hintText: "Введите заметку"),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Отмена")
              ),
              FilledButton(
                  onPressed: () => Navigator.pop(context,dialogController.text),
                  child: const Text("Сохранить")
              )
            ],
          );
        }


    );
    dialogController.dispose();
    if(result == null || result.trim().isEmpty){
      return;
    }
    setState(() {
      _notes[index] = result.trim();
    });

  }
}