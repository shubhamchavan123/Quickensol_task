import 'package:flutter/material.dart';
import 'package:quickensol/core/colors_themes/theme_genarator.dart';
import 'package:quickensol/core/local_assets/comman_images.dart';
import 'package:quickensol/core/local_strings/local_string.dart';
import 'package:quickensol/models/user.dart';
import 'package:quickensol/viewmodels/user_viewmodel.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _viewModel = UserViewModel();
  late Future<List<User>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = _viewModel.getUsers();
  }

  void _refreshUserList() {
    setState(() {
      _userListFuture = _viewModel.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.userListTitle),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshUserList,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(LocalAssets.login_screen),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<User>>(
          future: _userListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error loading users. Please try again.'),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _refreshUserList,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return Center(child: Text("No users found."));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _buildUserListTile(users[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserListTile(User user) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: Colors.black54,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.avatarBackgroundColor,
          child: Icon(Icons.person, color: AppColors.secondaryColor),
        ),
        title: Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primaryTextColor,
          ),
        ),
        subtitle: Text(
          user.password,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryTextColor,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: AppColors.iconColor),
          onPressed: () async {
            final bool? isUpdated = await Navigator.pushNamed(
              context,
              '/userUpdate',
              arguments: user,
            ) as bool?;
            if (isUpdated == true) {
              _refreshUserList();
            }
          },
        ),
      ),
    );

  }
}
