import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/mainScreens/InitialScreen.dart';
import 'package:foodpanda_users_app/mainScreens/home_screen.dart';
import 'package:foodpanda_users_app/widgets/custom_text_field.dart';
import 'package:foodpanda_users_app/widgets/error_diolog.dart';
import 'package:foodpanda_users_app/widgets/loaading_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();



  String sellerImageUrl = "";




  Future<void> _getImage() async
  {
    imageXFile= await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }





  Future<void> formValidation() async
  {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDiolog(
              message: "Please select an image",
            );
          }
      );
    }


    else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty && nameController.text.isNotEmpty
        ) {
          //we will start uploading the image
          showDialog(
              context: context,
              builder: (c){
                return LoadingDiolog(
                  message: "Registering account",
                );
              }
          );
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStorage.UploadTask uploadTask=reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;

            //SAVE INFO TO FIRESTORE

            authenticateSellerAndSignUp();



          });
        }
        else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDiolog(
                  message: "Please write the required information to Sing up",
                );
              }
          );
        }
      }
      else {
        //if the image dont match to each other

        showDialog(
            context: context,
            builder: (c) {
              return ErrorDiolog(
                message: "Password do not match.",
              );
            }
        );
      }
    }
  }


  void authenticateSellerAndSignUp() async
  {
    User? currentUser;

    await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDiolog(
              message: error.message.toString(),
            );
          }
      );

    });

    if(currentUser !=null){ //if cuurent user has a value do the following
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context); //make the dialog or progress bar to desappear
        //send user to homepage
        Route newRoute = MaterialPageRoute(builder: (c) => InitialScreen());
        Navigator.pushReplacement(context, newRoute);

      });
    }

  }


  Future saveDataToFirestore(User currentUser) async
  {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": nameController.text.trim(),
      "photoUrl": sellerImageUrl,
      "status": "approved",
      "userCart": ['garbageValue'],
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
    //empty cart list when the user register from the begening
    await sharedPreferences!.setStringList("userCart", ['garbageValue']);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade800,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/20),
              InkWell(
                onTap: ()
                {
                  _getImage();
                },
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundColor: Colors.white,
                    backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                    child: imageXFile ==null ?
                    Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    ) :null

                ),
              ),
              const SizedBox(height: 10,),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: nameController,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.email,
                      controller: emailController,
                      hintText: "Email",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: passwordController,
                      hintText: "Password",
                      isObsecre: true,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmPasswordController,
                      hintText: "Confirm password",
                      isObsecre: true,
                    ),


                  ],
                ),


              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold,),

                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 78, vertical: 10),

                  ),
                  onPressed: (){

                    formValidation();

                  }
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}