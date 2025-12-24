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

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
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
                  "Verify Your Code",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 6.h),

                Text(
                  "Enter the verification code we sent to your email",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 22.h),


                SizedBox(
                  height: 150.h,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 30.h),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }

                    if (state is VerificationsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Code Verified Successfully")),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesApp.login,
                            (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<AuthCubit>();

                    return Column(
                      children: [
                        CustomTextField(
                          controller: codeController,
                          label: "Verification Code",
                          prefixIcon: Icons.verified_outlined,
                          validator: Validators.code,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: 22.h),

                        state is AuthLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                          title: "Verify",
                          onPressed: () {
                            cubit.verifyCode(codeController.text.trim());
                          },
                        ),

                        SizedBox(height: 20.h),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesApp.login);
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
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
