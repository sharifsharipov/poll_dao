import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/discover_page/presentation/pages/dicover_page.dart';
import 'package:poll_dao/src/features/widget_servers/status/status.dart';
import 'package:poll_dao/src/features/sign_up_page/data/repositories/sign_up_repository.dart';
import 'package:poll_dao/src/features/sign_up_page/domain/service/service.dart';
import 'package:poll_dao/src/features/sign_up_page/presentation/manager/sign_up_bloc/sign_up_bloc.dart';
import 'package:poll_dao/src/features/widgets/base_bottom_sheet.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../sign_in_page/presentation/pages/sign_in_page.dart';
import '../../../sign_in_page/presentation/widgets/global_button.dart';
import '../../../widgets/base_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SignUpBloc(SignUpRepository(apiService: ApiService())),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DisCoverPage()),
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            final signUpBloc = BlocProvider.of<SignUpBloc>(context);
            return BaseBottomSheet(
                height: height,
                backgroundColor: AppColors.white,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 15, top: 15),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel',
                                          style: TextStyle(
                                              color: AppColors.c_0D72FF, fontSize: 17))))),
                          (height / 23).ph,
                          const Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 33),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Sign up now and start your polls.',
                              style: TextStyle(color: AppColors.c_5B6D83, fontSize: 22),
                            ),
                          ),
                          (height / 23).ph,
                          BaseTextField(
                            hintText: 'emirerdo@yandex.com',
                            text: 'Email Address',
                            icon: AppImages.email,
                            controller: signUpBloc.emailController,
                          ),
                          BaseTextField(
                            hintText: 'Your full name',
                            text: 'Username',
                            icon: AppImages.user,
                            controller: signUpBloc.nameController,
                          ),
                          BaseTextField(
                            hintText: '.....................',
                            text: 'Password',
                            icon: AppImages.clock,
                            isObscure: true,
                            controller: signUpBloc.passwordController,
                          ),
                          if (state.status.isError)
                            Text(
                              state.statusText ?? 'Error in sign up',
                              style: const TextStyle(color: Colors.red),
                            ),
                          (height / 25).ph,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GlobalButton(
                              onTap: () {
                                debugPrint('Sign Up');
                                signUpBloc.add(SignUpButtonPressed());
                              },
                              data: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  )
                                ],
                              ),
                              color: AppColors.c_5856D6,
                            ),
                          ),
                          (height / 25).ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width / 3.31,
                                height: 1,
                                color: AppColors.c_93A2B4,
                              ),
                              const Text(
                                'Or login with',
                                style: TextStyle(color: AppColors.c_5B6D83),
                              ),
                              Container(
                                width: width / 3.31,
                                height: 1,
                                color: AppColors.c_93A2B4,
                              ),
                            ],
                          ),
                          (height / 46.3).ph,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GlobalButton(
                              border: Border.all(color: AppColors.c_A0A4A7),
                              onTap: () {},
                              data: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  1.pw,
                                  SvgPicture.asset(AppImages.google),
                                  (height / 92.6).ph,
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'Sign in with Google',
                                    style: TextStyle(color: AppColors.black, fontSize: 19),
                                  ),
                                  const Text(
                                    "dsadsadas",
                                    style: TextStyle(color: Colors.transparent),
                                  )
                                ],
                              ),
                              color: AppColors.white,
                            ),
                          ),
                          20.ph,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GlobalButton(
                              onTap: () {},
                              data: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  1.pw,
                                  SvgPicture.asset(AppImages.apple),
                                  (height / 92.6).ph,
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'Sign in with Apple',
                                    style: TextStyle(color: AppColors.white, fontSize: 19),
                                  ),
                                  const Text(
                                    "dsadsadas",
                                    style: TextStyle(color: Colors.transparent),
                                  )
                                ],
                              ),
                              color: AppColors.black,
                            ),
                          ),
                          (height / 92.6).ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don`t you have an account?',
                                style: TextStyle(
                                  color: AppColors.c_93A2B4,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: AppColors.white,
                                        elevation: 0,
                                        context: context,
                                        builder: (context) => const SignInPage());
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: AppColors.c_5856D6),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
