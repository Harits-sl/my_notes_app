import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_bloc.dart';
import 'package:my_notes_app/features/notes/presentation/bloc/add_note/add_note_state.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController titleController;
  late TextEditingController descController;
  final TextEditingController customCategoryController =
      TextEditingController();

  // List kategori awal
  List<String> categories = ['Personal', 'Work', 'Study', 'Finance', 'Ideas'];
  // List untuk menyimpan kategori yang dipilih
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    customCategoryController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan dialog tambah kategori baru
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Category"),
        content: TextField(
          controller: customCategoryController,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Category name..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (customCategoryController.text.isNotEmpty) {
                setState(() {
                  categories.add(customCategoryController.text);
                  selectedCategories.add(customCategoryController.text);
                  customCategoryController.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Buat Catatan Baru",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: BlocConsumer<AddNoteBloc, AddNoteState>(
        listener: (context, state) {
          log('image url ${state.imageUrl}');
          if (state.title.isNotEmpty) {
            titleController.text = state.title;
            descController.text = state.desc;
          }
        },
        builder: (context, state) {
          if (state.isLoadingPreview) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. IMAGE PREVIEW (Read-only dari Entity)
                if (state.imageUrl.isNotEmpty) ...[
                  _buildLabel("Image Preview (Read-only)"),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(state.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // 2. MULTI-CATEGORY SELECTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLabel("Categories"),
                    TextButton.icon(
                      onPressed: _showAddCategoryDialog,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text("Add New"),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  children: categories.map((cat) {
                    final isSelected = selectedCategories.contains(cat);
                    return FilterChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: Colors.blue.withOpacity(0.2),
                      checkmarkColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black54,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            selectedCategories.add(cat);
                          } else {
                            selectedCategories.remove(cat);
                          }
                        });
                      },
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: isSelected ? Colors.blue : Colors.grey[300]!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // 3. TITLE INPUT
                _buildLabel("Title"),
                TextField(
                  controller: titleController,
                  decoration: _inputDecoration("Judul catatan..."),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // 4. DESCRIPTION INPUT
                _buildLabel("Description"),
                TextField(
                  controller: descController,
                  maxLines: 6,
                  decoration: _inputDecoration("Tulis detail di sini..."),
                ),

                const SizedBox(height: 30),

                // 5. SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Di sini Anda bisa membuat objek Note dengan data:
                      // titleController.text, descController.text, selectedCategory, dll
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Simpan Catatan",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }
}
