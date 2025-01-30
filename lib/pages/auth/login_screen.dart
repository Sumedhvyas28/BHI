import 'package:bhi/component/round_button.dart';
import 'package:bhi/component/utils.dart';
import 'package:bhi/constant/pallete.dart';
import 'package:bhi/pages/home/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // For Realtime Database
// import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size mediaSize;
  bool _isPasswordHidden = true; // for pass
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  // final _database = FirebaseDatabase.instance.reference(); // For Realtime Database
  final _firestore = FirebaseFirestore.instance; // Uncomment for Firestore

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Save user data in the Firebase Realtime Database
  Future<void> storeUserData(User user) async {
    // final userRef = _database.child("users").child(user.uid); // Realtime Database
    // Uncomment below for Firestore
    final userRef = _firestore.collection('users').doc(user.uid);

    try {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'createdAt': DateTime.now().toIso8601String(),
        'lastLogin': DateTime.now().toIso8601String(),
        'role': 'user', // Add custom roles if needed
      });
      debugPrint('User data saved successfully.');
    } catch (e) {
      debugPrint('Error saving user data: $e');
      utils().toastMessage('Error saving user data: $e');
    }
  }

  // Login method
  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      utils().toastMessage('Email or Password cannot be empty');
      return;
    }

    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text.trim(),
    )
        .then((value) async {
      final user = value.user!;
      utils().toastMessage('Welcome, ${user.email}');

      // Save user data in the database
      await storeUserData(user);

      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      setState(() {
        loading = false;
      });
    }).onError((error, StackTrace stackTrace) {
      setState(() {
        loading = false;
      });
      utils().toastMessage(error.toString());
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: mediaSize.width,
                    height: mediaSize.height,
                    decoration: BoxDecoration(
                      color: Pallete.mainDashColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottom(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.7,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        color: Colors.white,
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaSize.width * 0.08,
        vertical: mediaSize.height * 0.02,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: mediaSize.height * 0.13,
              ),
            ),
            const Spacer(),
            _buildGreyText('Enter your Email', emailController),
            SizedBox(height: mediaSize.height * 0.02),
            _buildPasswordTextField('Enter your Password'),
            SizedBox(height: mediaSize.height * 0.02),
            _buildForgotPassword(),
            const Spacer(),
            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                login();
              },
            ),
            SizedBox(height: mediaSize.height * 0.02),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontSize: mediaSize.width * 0.045,
          ),
        ),
      ),
    );
  }

  Widget _buildGreyText(String text, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(String text) {
    return TextFormField(
      controller: passwordController,
      obscureText: _isPasswordHidden,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
      ),
    );
  }
}
