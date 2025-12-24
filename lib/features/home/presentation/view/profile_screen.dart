import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/home/presentation/widgets/info_card.dart';
import 'package:untitled7/features/test/data/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    final user = UserModel.defaultUser();
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
                user.fullName,
            style:  Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 5,),
            Text(user.address,
              style:   Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
            ),
            const SizedBox(height: 30,),
            InfoCard(
                icon: Icons.email,
                title: 'Email',
                value: user.email),
            InfoCard(
                icon: Icons.password_sharp,
                title: 'Password',
                value: user.password),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isEditing = !isEditing;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          isEditing ? Icons.save : Icons.edit,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
