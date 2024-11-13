import 'package:flutter/material.dart';
import 'package:quickensol/core/colors_themes/theme_genarator.dart';
import 'package:quickensol/core/local_assets/comman_images.dart';
import 'package:quickensol/core/local_strings/local_string.dart';
import 'package:quickensol/models/user.dart';
import 'package:quickensol/viewmodels/user_viewmodel.dart';

class UserUpdateScreen extends StatefulWidget {
  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = UserViewModel();
  late User _user;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    _user = ModalRoute.of(context)!.settings.arguments as User;
    _usernameController.text = _user.username;
    _passwordController.text = _user.password;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.updateUserTitle),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(LocalAssets.login_screen), // Path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.lime),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: AppStrings.usernameLabel,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.lime),
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: AppStrings.passwordLabel,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final updatedUser = User(
                        id: _user.id,
                        username: _usernameController.text,
                        password: _passwordController.text,
                      );
                      await _viewModel.updateUser(updatedUser);
                      Navigator.pop(context, true); // Indicate update was successful
                    },
                    child: Text(AppStrings.updateButton),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _viewModel.deleteUser(_user.id!);
                      Navigator.pop(context, true); // Indicate deletion
                    },
                    child: Text(AppStrings.deleteButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
