import 'package:flutter/material.dart';
import 'package:quickensol/core/colors_themes/theme_genarator.dart';
import 'package:quickensol/core/local_assets/comman_images.dart';
import 'package:quickensol/core/local_strings/local_string.dart';
import 'package:quickensol/models/user.dart';
import 'package:quickensol/screens/widgets/custom_password_field.dart';
import 'package:quickensol/screens/widgets/login_username_field.dart';
import 'package:quickensol/viewmodels/user_viewmodel.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _viewModel = UserViewModel();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(LocalAssets.login_screen), // Path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? screenWidth * 0.2 : 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.welcomeText,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 32 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // TextFormField(
                  //   controller: _usernameController,
                  //   decoration: InputDecoration(
                  //     labelText: AppStrings.usernameLabel,
                  //     prefixIcon: Icon(Icons.person),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your username';
                  //     }
                  //     return null;
                  //   },
                  // ),

                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    labelColor: AppColors.secondaryTextColor,
                    hintColor: AppColors.buttonColor,
                    textColor: Colors.amberAccent,
                    iconColor: AppColors.iconColor,
                    fillColor: AppColors.labelColor,
                    borderColor: AppColors.appBarColor,
                    focusedBorderColor: AppColors.backgroundColor1,
                    onSuffixIconPressed: () {
                      _usernameController.clear();
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),
                  CustomPasswordField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    labelColor: AppColors.secondaryTextColor,
                    hintColor: AppColors.buttonColor,
                    textColor: Colors.amberAccent,
                    iconColor: AppColors.iconColor,
                    fillColor: AppColors.labelColor,
                    borderColor: AppColors.appBarColor,
                    focusedBorderColor: AppColors.backgroundColor1,
                  ),

                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = User(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                        await _viewModel.registerUser(user);
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.buttonColor,  // Use extracted color
                    ),
                    child: Text(
                      AppStrings.registerButtonText,
                      style: TextStyle(
                          fontSize: isLargeScreen ? 20 : 18, color: AppColors.textColor),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  Row(
                    children: [
                      Spacer(),
                      Text(
                        AppStrings.alreadyHaveAccountText,
                        style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: isLargeScreen ? 18 : 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          AppStrings.login_here,
                          style: TextStyle(
                              color: AppColors.backgroundColor,  // Use extracted color
                              fontSize: isLargeScreen ? 18 : 16),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
