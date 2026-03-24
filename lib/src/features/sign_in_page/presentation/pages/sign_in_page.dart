import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/discover_page/presentation/pages/dicover_page.dart';
import 'package:poll_dao/src/features/sign_in_page/data/repositories/sign_in_repository.dart';
import 'package:poll_dao/src/features/sign_in_page/domain/service/service.dart';
import 'package:poll_dao/src/features/sign_in_page/presentation/widgets/global_button.dart';
import 'package:poll_dao/src/features/widget_servers/status/status.dart';
import 'package:poll_dao/src/features/widgets/base_bottom_sheet.dart';

import '../../../profile_page/presentation/manager/fetch_profile_data_bloc/fetch_profile_data_bloc.dart';
import '../../../sign_up_page/presentation/pages/sign_up_page.dart';
import '../../../widgets/base_textfield.dart';
import '../meneger/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignInBloc(signInRepository: SignInRepository(apiService: Service())),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (BuildContext context, SignInState state) {
            if (state.status == FormStatus.success) {
              BlocProvider.of<FetchProfileDataBloc>(context).add(FetchProfileData());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DisCoverPage()),
              );
            }
          },
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (BuildContext context, SignInState state) {
              final signInBloc = BlocProvider.of<SignInBloc>(context);
              return BaseBottomSheet(
                  height: height,
                  scaleFactor: 1,
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
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel',
                                            style: TextStyle(color: AppColors.c_0D72FF, fontSize: 17))))),
                            (height / 23).ph,
                            const Center(
                              child: Text(
                                'Welcome  Back',
                                style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 33),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Sign in continue where you left off',
                                style: TextStyle(color: AppColors.c_5B6D83, fontSize: 22),
                              ),
                            ),
                            (height / 23).ph,
                            BaseTextField(
                              hintText: 'email@mail.com',
                              text: 'Email Address',
                              icon: AppImages.email,
                              controller: signInBloc.emailController,
                            ),
                            BaseTextField(
                              hintText: '........',
                              text: 'Password',
                              icon: AppImages.clock,
                              controller: signInBloc.passwordController,
                            ),
                            (height / 30).ph,
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: GlobalButton(
                                onTap: () {
                                  debugPrint('Sign In with Firdavs');
                                  signInBloc.add(SignInButtonPressed());
                                },
                                data: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                            color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 25),
                                      ),
                                    )
                                  ],
                                ),
                                color: AppColors.c_5856D6,
                              ),
                            ),
                            (height / 8).ph,
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
                                          builder: (context) => const SignUpPage());
                                    },
                                    child: const Text(
                                      'Sign Up',
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
      ),
    );
  }
}
