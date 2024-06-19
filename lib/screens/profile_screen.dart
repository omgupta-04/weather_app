import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart'; 

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _user = User(); // Initialize with default User
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadUserData(); 
  }

  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    final userData = _prefs.getString('user');
    if (userData != null) {
      setState(() {
        _user = User.fromMap(json.decode(userData));
      });
    } 
  }

  Future<void> _saveUserData() async {
    await _prefs.setString('user', json.encode(_user.toMap()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Added for button stretching
            children: [
              TextFormField(
                initialValue: _user.name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => setState(() => _user.name = value!),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                initialValue: _user.email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => setState(() => _user.email = value!),
                validator: (value) => !value!.contains('@') ? 'Please enter a valid email' : null,
              ),
              TextFormField(
                initialValue: _user.location,
                decoration: const InputDecoration(labelText: 'Home Location'),
                onSaved: (value) => setState(() => _user.location = value!),
              ),
              const SizedBox(height: 20), // Added spacing
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _saveUserData();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
