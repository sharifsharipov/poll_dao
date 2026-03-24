import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/profile_page/presentation/manager/fetch_profile_data_bloc/fetch_profile_data_bloc.dart';
import 'package:poll_dao/src/features/profile_page/presentation/widgets/peronal_information.dart';
import 'package:poll_dao/src/features/widgets/base_bottom_sheet.dart';
import 'package:poll_dao/src/features/widgets/base_textfield.dart';

import '../../../../config/routes/routes.dart';
import '../../../create_poll/presentation/widgets/select_question_type.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final FetchProfileDataBloc fetchProfileDataBloc;
  @override
  void initState() {
    super.initState();
    fetchProfileDataBloc = BlocProvider.of<FetchProfileDataBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // final changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    return BlocListener<FetchProfileDataBloc, FetchProfileDataState>(
      listener: (context, state) {
        // if (state.status == FormStatus.success) {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const DisCoverPage()),
        //   );
        // }
      },
      child: BlocBuilder<FetchProfileDataBloc, FetchProfileDataState>(
        builder: (context, state) {
          return BaseBottomSheet(
            height: height,
            backgroundColor: AppColors.white,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              fetchProfileDataBloc.add(UpdateProfilePressed());
                              if (Navigator.canPop(context)) Navigator.pop(context);
                            },
                            child: const Text('Done', style: TextStyle(color: AppColors.c_0D72FF, fontSize: 17)),
                          ),
                        ),
                      ),
                      BaseTextField(
                        hintText: state.profileModel.email.isEmpty ? "email@mail.com" : state.profileModel.email,
                        text: 'Email Address',
                        icon: AppImages.email,
                        isEditable: false,
                      ),
                      BaseTextField(
                        hintText: state.profileModel.name ?? '',
                        text: 'Username',
                        icon: AppImages.user,
                        controller: fetchProfileDataBloc.nameController,
                      ),
                      BaseTextField(
                        hintText: state.profileModel.age.toString(),
                        text: 'Age',
                        icon: AppImages.age,
                        controller: fetchProfileDataBloc.ageController,
                      ),
                      PersonData(
                        textOne: 'Gender',
                        textTwo: state.profileModel.gender,
                        icon: AppImages.gender,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width / 3),
                                  child: CupertinoActionSheet(
                                    actions: <Widget>[
                                      0.1.ph,
                                      SelectQuestionWidget(
                                        text: "Female",
                                        data: const [],
                                        onTap: () async {
                                          fetchProfileDataBloc.add(UpdateGender(gender: 'Female'));
                                          Navigator.pop(context);
                                        },
                                      ),
                                      0.1.ph,
                                      SelectQuestionWidget(
                                        text: 'Male',
                                        data: const [],
                                        onTap: () {
                                          fetchProfileDataBloc.add(UpdateGender(gender: 'Male'));
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      PersonData(
                        textOne: "Education",
                        textTwo: state.profileModel.education,
                        icon: AppImages.education,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.educationLevelPage).then((value) {
                            if (value is String) {
                              fetchProfileDataBloc.add(UpdateEducation(education: value));
                            }
                          });
                        },
                      ),
                      PersonData(
                        textOne: "Location",
                        textTwo: state.profileModel.location,
                        icon: AppImages.location,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.locationPage).then((value) {
                            if (value is String) {
                              fetchProfileDataBloc.add(UpdateLocation(location: value));
                            }
                          });
                        },
                      ),
                      PersonData(
                        textOne: "Nationality",
                        textTwo: state.profileModel.nationality,
                        icon: AppImages.nationality,
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.nationalityPage).then((value) {
                            if (value is String) {
                              fetchProfileDataBloc.add(UpdateNationality(nationality: value));
                            }
                          });
                        },
                      ),
                      60.ph,
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Change Password",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black),
                          ),
                        ),
                      ),
                      BaseTextField(
                        hintText: '*********',
                        text: 'Old password',
                        icon: AppImages.oldPassword,
                        controller: fetchProfileDataBloc.oldPasswordController,
                      ),
                      BaseTextField(
                        hintText: '*********',
                        text: 'New password',
                        icon: AppImages.newPassword,
                        controller: fetchProfileDataBloc.newPasswordController,
                      ),
                      const _ProfileSignOutBtn(),
                      const _ProfileDeleteAccountBtn(),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileDeleteAccountBtn extends StatelessWidget {
  const _ProfileDeleteAccountBtn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 20),
      child: TextButton(
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("DELETE ACCOUNT"),
                content: const Text("This action is irreversable, are you sure you want to delete an account?"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      BlocProvider.of<FetchProfileDataBloc>(context).add(DeleteAccountEvent());
                      Navigator.pushReplacementNamed(context, RouteNames.discoverPage);
                    },
                    isDestructiveAction: true,
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          );
        },
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSignOutBtn extends StatelessWidget {
  const _ProfileSignOutBtn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Sign Out"),
                content: const Text("Are you sure you want to sign out?"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      BlocProvider.of<FetchProfileDataBloc>(context).add(SignOutEvent());
                      Navigator.pushReplacementNamed(context, RouteNames.discoverPage);
                    },
                    isDestructiveAction: true,
                    child: const Text("Sign Out"),
                  ),
                ],
              );
            },
          );
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.secondary),
            foregroundColor: WidgetStateProperty.all(AppColors.black),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )),
            minimumSize: WidgetStateProperty.all(const Size(double.infinity, 45)),
            padding: WidgetStateProperty.all(const EdgeInsets.all(10.0).copyWith(left: 20)),
            shadowColor: WidgetStateProperty.all(Colors.transparent)),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sign Out",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppColors.red,
            ),
          ),
        ),
      ),
    );
  }
}
