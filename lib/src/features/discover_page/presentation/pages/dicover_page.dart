import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:poll_dao/src/config/routes/routes.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/create_poll/domain/repositories/repository.dart';
import 'package:poll_dao/src/features/create_poll/logic/create_poll_notifier.dart';
import 'package:poll_dao/src/features/create_poll/presentation/pages/create_poll.dart';
import 'package:poll_dao/src/features/discover_page/data/models/poll_model.dart';
import 'package:poll_dao/src/features/discover_page/presentation/widgets/category_select.dart';
import 'package:poll_dao/src/features/discover_page/presentation/widgets/options_answer.dart';
import 'package:poll_dao/src/features/discover_page/presentation/widgets/show_dialog.dart';
import 'package:poll_dao/src/features/profile_page/presentation/pages/profile_page.dart';
import 'package:poll_dao/src/features/sign_in_page/presentation/pages/sign_in_page.dart';
import 'package:poll_dao/src/features/sign_up_page/presentation/pages/sign_up_page.dart';
import 'package:poll_dao/src/features/widget_servers/loger_service/loger.dart';
import 'package:poll_dao/src/features/widget_servers/repositories/storage_repository.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../config/theme/fonts/app_text_style.dart';
import '../../../create_poll/presentation/widgets/select_question_type.dart';
import '../../../profile_page/presentation/manager/fetch_profile_data_bloc/fetch_profile_data_bloc.dart';
import '../../../widget_servers/status/status.dart';
import '../widgets/active_polls_navigate.dart';
import '../widgets/circle_avatar_with_name.dart';
import '../widgets/option_widget.dart';
import '../widgets/poll_widget.dart';
import '../widgets/time_ago_text.dart';
import '../widgets/voice.dart';

class DisCoverPage extends StatefulWidget {
  const DisCoverPage({super.key});

  @override
  State<DisCoverPage> createState() => _DisCoverPageState();
}

class _DisCoverPageState extends State<DisCoverPage> {
  bool isVoice = true;
  late final FetchProfileDataBloc fetchProfileDataBloc;
  @override
  void initState() {
    super.initState();
    fetchProfileDataBloc = BlocProvider.of<FetchProfileDataBloc>(context);
    if (fetchProfileDataBloc.state.status == FormStatus.pure && StorageRepository.getString("token").isNotEmpty) {
      fetchProfileDataBloc.add(FetchProfileData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F3FA),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffF0F3FA),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.c_C8E8FA),
                child: IconButton(
                    onPressed: () {
                      if (StorageRepository.getString("token").isNotEmpty) {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: AppColors.white,
                            elevation: 0,
                            context: context,
                            builder: (context) {
                              return const ProfilePage();
                            });
                      } else {
                        Navigator.pushNamed(context, RouteNames.signInPage);
                      }
                    },
                    icon: SvgPicture.asset(AppImages.user))),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => CreatePollNotifier(const CreatePollRepository()),
                    child: const CreatePoll(),
                  ),
                );
              },
              icon: SvgPicture.asset(AppImages.add),
            )
          ]),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(
            child: Row(
              children: [
                Gap(25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Discover",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
              child: StorageRepository.getString("token") != ""
                  ? Column(children: [
                      FutureBuilder<int>(
                        future: fetchMyPolls(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return ActivePollsNavigate(
                              radius: 20,
                              color: AppColors.c_5856D6,
                              textColorOne: AppColors.white,
                              textColorTwo: AppColors.white.withValues(alpha: 0.7),
                              onTap: () {
                                Navigator.pushNamed(context, RouteNames.activePollsPage);
                              },
                              icon: AppImages.arrowBackAndroidRight,
                              textOne: "${snapshot.data} Active Polls", // Используем полученное значение
                              textTwo: 'See Details',
                              textSizeOne: 20,
                              textSizeTwo: 15,
                              fontWeightTextOne: FontWeight.w600,
                              fontWeightTextTwo: FontWeight.w500,
                            );
                          }
                        },
                      ),
                    ])
                  : Container()),
          const SliverToBoxAdapter(child: Gap(10)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectCategory(
            
                selectColor: isVoice,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Gap(10)),
          const PollListWidget(),
        ],
      ),
    );
  }
}

class PollListWidget extends StatefulWidget {
  final int? currentCategoryId;

  const PollListWidget({super.key, this.currentCategoryId});

  @override
  State<PollListWidget> createState() => _PollListWidgetState();
}

class _PollListWidgetState extends State<PollListWidget> {
  List<Poll> _polls = [];
  late CategoryProvider categoryProvider;

  @override
  void initState() {
    super.initState();
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.addListener(_fetchPolls);
    _fetchPolls(); // Первоначальная загрузка данных
  }

  @override
  void dispose() {
    categoryProvider.removeListener(_fetchPolls);
    super.dispose();
  }

  void _fetchPolls() async {
    final categoryId = categoryProvider.selectedCategoryId;
    debugPrint("Fetching polls for category ID: $categoryId"); // Добавлен вывод в консоль
    List<Poll> newPolls = await fetchPolls(selectedCategoryId: categoryId);
    setState(() {
      _polls = newPolls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: _polls.length + 1,
      itemBuilder: (context, index) {
        if (index < _polls.length) {
          return PollWidget(poll: _polls[index]);
        }
        return null;
      },
    );
  }

  Widget buildPollContainer(Poll poll) {
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AvatarWithName(
                      name: poll.author.name,
                      radius: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(poll.author.name, style: AppTextStyle.bodyXlargeMedium),
                  ],
                ),
                TimeAgoText(createdAt: poll.createdAt)
              ],
            ),
            const SizedBox(height: 20),
            Text(poll.name, style: AppTextStyle.bodyXlargeMedium),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: buildOptionsList(
                poll.options,
                widget.currentCategoryId,
                (v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<List<Poll>> fetchPolls({int? selectedCategoryId}) async {
  final Dio dio = Dio();

  try {
    String? token = StorageRepository.getString("token");
    final options = Options(headers: {"access-token": token});
    final responce = await dio.get('http://94.131.10.253:3000/public/polls', options: options);

    if (responce.statusCode == 200) {
      final List<dynamic> jsonData = responce.data;

      final polls = jsonData.map((json) => Poll.fromJson(json)).toList().reversed;
      return polls.toList();
    } else {
      return [];
    }
  } catch (e) {
    debugPrint('fetch polls $e');
    return [];
  }

  /*String url = 'http://94.131.10.253:3000/public/polls';
  if (selectedCategoryId != null) {
    url += '?topic=$selectedCategoryId';
  }
  final response = await http.get(Uri.parse(url), headers: {"Keep-Alive": "timeout=5, max=1000"});

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Poll.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load polls');
  }*/
}

Future<int> fetchMyPolls() async {
  final Dio dio = Dio();

  try {
    String? token = StorageRepository.getString("token");

    final options = Options(headers: {"access-token": token});

    final response = await dio.get(
      'http://94.131.10.253:3000/poll/my',
      options: options,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      debugPrint("Количество элементов: ${data.length}");
      return data.length;
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  } catch (e) {
    LoggerService.e('$e');
    return 0;
  }
}

class VoiceWidget extends StatefulWidget {
  const VoiceWidget({super.key});

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Voice(
      onTap: () {
        pollshowDialog(
            context: context,
            onTapOne: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  context: context,
                  builder: (context) => const SignUpPage());
            },
            onTapTwo: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  context: context,
                  builder: (context) => const SignInPage());
            },
            onTapThree: () {
              Navigator.pop(context);
            });
      },
      onTapTwo: () {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(left: width / 3),
                child: CupertinoActionSheet(
                  actions: <Widget>[
                    0.1.ph,
                    SelectQuestionWidget(
                      text: "Change choice",
                      data: [SvgPicture.asset(AppImages.returnNer)],
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                    0.1.ph,
                    SelectQuestionWidget(
                      text: 'Delete',
                      data: [
                        SvgPicture.asset(AppImages.deleteBlack),
                      ],
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildButtonWidget(BuildContext context) {
  return BuildButton(onTap: () {
    pollshowDialog(
        context: context,
        onTapOne: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              context: context,
              builder: (context) => const SignUpPage());
        },
        onTapTwo: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              context: context,
              builder: (context) => const SignInPage());
        },
        onTapThree: () {
          Navigator.pop(context);
        });
  });
}
