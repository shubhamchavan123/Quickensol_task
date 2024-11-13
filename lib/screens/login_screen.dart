import 'package:flutter/material.dart';
import 'package:quickensol/core/colors_themes/theme_genarator.dart';
import 'package:quickensol/core/local_assets/comman_images.dart';
import 'package:quickensol/core/local_strings/local_string.dart';
import 'package:quickensol/viewmodels/user_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _viewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
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
                  // Welcome text
                  Text(
                    AppStrings.welcomeBack,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 32 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Username field with transparency
                  _buildTextField(
                    controller: _usernameController,
                    labelText: AppStrings.username,
                    icon: Icons.person,
                    isPassword: false,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Password field with transparency
                  _buildTextField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Login button with transparency
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final isValid = await _viewModel.loginUser(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        if (isValid) {
                          Navigator.pushReplacementNamed(context, '/userList');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppStrings.invalidCredentials),
                            backgroundColor: AppColors.errorSnackBarColor,
                          ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.buttonColor.withOpacity(0.8),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: isLargeScreen ? 20 : 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        AppStrings.registerPrompt,
                        style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: isLargeScreen ? 18 : 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          AppStrings.registerButtonText2,
                          style: TextStyle(
                              color: AppColors.backgroundColor,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool isPassword,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8), // Transparent background for field
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColors.iconColor),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: AppColors.iconColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        if (isPassword && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
