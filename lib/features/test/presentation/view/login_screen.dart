import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/core/routes/routes_app.dart';
import 'package:untitled7/core/utils/validators.dart';
import 'package:untitled7/core/widget/custom_button.dart';
import 'package:untitled7/core/widget/custom_text_field.dart';
import 'package:untitled7/features/test/data/data_source/auth_remote_ds.dart';
import 'package:untitled7/features/test/presentation/manager/auth_cubit.dart';
import 'package:untitled7/features/test/presentation/manager/auth_state.dart';
import 'package:untitled7/features/test/presentation/usecases/forget_password_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/login_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/register_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/verify_code_usecase.dart';
import 'package:untitled7/features/test/repo/auth_repo_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        registerUseCase: RegisterUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        forgetPasswordUseCase: ForgetPasswordUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
        verifyCodeUseCase: VerifyCodeUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 6.h),

                Text(
                  "Login to continue your shopping journey",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 24.h),


                SizedBox(
                  height: 140.h,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 26.h),


                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20.h),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login successful")),
                      );
                      Navigator.pushNamed(context, RoutesApp.home);
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
                            controller: email,
                            label: "Email",
                            validator: Validators.email,
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(height: 16.h),

                          CustomTextField(
                            controller: password,
                            label: "Password",
                            validator: Validators.password,
                            obscure: true,
                            prefixIcon: Icons.lock_outline,
                          ),

                          SizedBox(height: 24.h),

                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                            title: "Login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.login(
                                  email.text.trim(),
                                  password.text.trim(),
                                );
                              }
                            },
                          ),

                          SizedBox(height: 20.h),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RoutesApp.register);
                                },
                                child: const Text("Register"),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),


                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesApp.forgetPassword);
                            },
                            child: const Text("Forgot your password?"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}