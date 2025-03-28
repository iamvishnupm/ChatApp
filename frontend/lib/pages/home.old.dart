import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

import "package:frontend/config.dart";
import "package:frontend/components/theme_button.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> contacts = [];
  Map<String, String> contactsMap = {};

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse("$baseURL/contacts/"),
      headers: {'Authorization': "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        contactsMap = Map<String, String>.from(data["contacts"]);
        // contacts = List<String>.from(data["contacts"].values);
      });

      //
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Contacts Fetch Failed !! ")));
    }
  }

  @override
  Widget build(BuildContext cntext) {
    return Scaffold(
      //
      appBar: AppBar(title: Text(""), actions: [ThemeButton()]),

      body: ListView.builder(
        itemCount: contactsMap.length,
        itemBuilder: (context, index) {
          String username = contactsMap.keys.elementAt(index);
          String name = contactsMap[username]!;

          return ListTile(title: Text(name), subtitle: Text(username));
        },
      ),
      //
    );
  }
}
