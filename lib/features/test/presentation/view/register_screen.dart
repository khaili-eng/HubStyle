import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/core/routes/routes_app.dart';
import 'package:untitled7/core/widget/custom_button.dart';
import 'package:untitled7/core/widget/custom_text_field.dart';
import 'package:untitled7/core/utils/validators.dart';
import 'package:untitled7/features/test/data/data_source/auth_remote_ds.dart';
import 'package:untitled7/features/test/presentation/manager/auth_cubit.dart';
import 'package:untitled7/features/test/presentation/usecases/forget_password_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/login_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/register_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/verify_code_usecase.dart';
import 'package:untitled7/features/test/repo/auth_repo_impl.dart';

import '../manager/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late AnimationController _animController;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    fullName.dispose();
    email.dispose();
    address.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        registerUseCase:
        RegisterUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        forgetPasswordUseCase:
        ForgetPasswordUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        verifyCodeUseCase:
        VerifyCodeUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey.shade100,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: FadeTransition(
                opacity: fadeAnim,
                child: SlideTransition(
                  position: slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to HubStyle",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Discover fashion that fits your style",
                        style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 25.h),

                      // Logo with Hero animation
                      Hero(
                        tag: "app_logo",
                        child: SizedBox(
                          height: 140,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // Form card
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Registration successful")),
                              );
                            }
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            final cubit = context.read<AuthCubit>();
                            return Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: fullName,
                                    label: "Full Name",
                                    prefixIcon: Icons.person,
                                    validator: Validators.fullName,
                                  ),
                                  SizedBox(height: 14.h),
                                  CustomTextField(
                                    controller: email,
                                    label: "Email",
                                    prefixIcon: Icons.email_outlined,
                                    validator: Validators.email,
                                  ),
                                  SizedBox(height: 14.h),
                                  CustomTextField(
                                    controller: address,
                                    label: "Address",
                                    prefixIcon: Icons.location_on_outlined,
                                    validator: Validators.required,
                                  ),
                                  SizedBox(height: 14.h),
                                  CustomTextField(
                                    controller: password,
                                    label: "Password",
                                    obscure: true,
                                    prefixIcon: Icons.lock_outline,
                                    validator: Validators.password,
                                  ),

                                  SizedBox(height: 22.h),

                                  // Register Button
                                  state is AuthLoading
                                      ? const CircularProgressIndicator()
                                      : Container(
                                    width: double.infinity,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(14.r),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black87,
                                          Colors.grey.shade800,
                                        ],
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(14.r),
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.register(
                                              fullName.text.trim(),
                                              email.text.trim(),
                                              address.text.trim(),
                                              password.text.trim(),
                                            );
                                            Navigator.pushNamed(
                                                context, RoutesApp.login);
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Already have an account?"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, RoutesApp.login);
                                        },
                                        child: const Text("Login"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        "By creating an account, you agree to our Terms & Privacy Policy",
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
