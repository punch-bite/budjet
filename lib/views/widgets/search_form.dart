import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  // ignore: unused_field
  // final List<Depense> _depenses = await LocalStorage().loadDepenses();
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final TextEditingController _SearchController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _SearchController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Form(
        key: _formKey,

        child: Stack(
          children: [
            TextFormField(
              controller: _SearchController,
              // focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Search",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                ),
                hintText: "Search dépense...",
                prefixIcon: Icon(Icons.search_outlined, size: 26),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Champs vide !";
                }
                return null;
              },
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent[700],
                  ),
                  child: Icon(
                    Icons.send_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    print("search : ${_SearchController.text}");
                    // dispose();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
