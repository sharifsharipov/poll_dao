import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:poll_dao/src/config/theme/fonts/app_text_style.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/features/active_polls_page/presentation/widget/cupertinoactionsheet.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/constants/answer_constants.dart';
import '../../../../core/icons/app_icons.dart';
import '../../../create_poll/domain/repositories/repository.dart';
import '../../../create_poll/logic/create_poll_notifier.dart';
import '../../../create_poll/presentation/widgets/advanced_audince_control.dart';
import '../../../discover_page/data/models/poll_model.dart';
import '../../../widget_servers/repositories/storage_repository.dart';
import '../../data/models/votes.dart';

class PollResultPage extends StatefulWidget {
  final int pollId;

  const PollResultPage({super.key, required this.pollId});

  @override
  State<PollResultPage> createState() => _PollResultPageState();
}

class _PollResultPageState extends State<PollResultPage> {
  Future<int?> getUserVote(int pollId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://94.131.10.253:3000/vote/user-votes/$pollId'),
        headers: {'access-token': token},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.isNotEmpty ? data[0] : null;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Poll> getPoll(int pollId, String token) async {
    final response = await http.get(
      Uri.parse('http://94.131.10.253:3000/poll/$pollId'),
      headers: {
        'access-token': token,
      },
    );
    if (response.statusCode == 200) {
      return Poll.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load poll');
    }
  }

  Future<Votes> getVotes({
    required int pollId,
    required String token,
    List<int>? age,
    String? biometryPassed,
    String? location,
    String? maternalLang,
    String? nationality,
    String? gender,
  }) async {
    log('upd filter');
    var headers = {'access-token': '\$2b\$10\$ECEYvJ7zmFwhE.hPOw0oju4ofQm3s51zhSgT1rGbpLn9NksQfRwQG'};
    var dio = Dio();
    late final String? genderStr;
    switch (gender) {
      case 'women':
        genderStr = 'Female';
      case 'men':
        genderStr = 'Male';
      case 'other':
        genderStr = 'Other';
      case 'all':
        genderStr = 'All';
      default:
        genderStr = null;
    }
    Map<String, dynamic>? queryParameters = {};
    if (age != null) queryParameters['age'] = age.join(', ');
    if (biometryPassed != null) queryParameters['biometryPassed'] = biometryPassed;
    if (location != null && location.isNotEmpty) queryParameters['location'] = location;
    if (maternalLang != null && maternalLang.isNotEmpty) queryParameters['maternalLang'] = maternalLang;
    if (nationality != null && nationality.isNotEmpty) queryParameters['nationality'] = nationality;
    if (genderStr != null && genderStr.isNotEmpty) queryParameters['gender'] = genderStr;

    var response = await dio.request(
      'http://94.131.10.253:3000/vote/poll-votes/60',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return Votes.fromJson(response.data);
    } else {
      throw Exception('Failed to load votes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = StorageRepository.getString("token");
    return Scaffold(
        backgroundColor: AppColors.c_F8F8FF,
        body: ChangeNotifierProvider(
          create: (context) => CreatePollNotifier(const CreatePollRepository()),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.discoverPage);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.arrowBackIos),
                            5.pw,
                            const Text(
                              'Active Polls',
                              style: TextStyle(color: AppColors.c_5856D6, fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Insights',
                        style: TextStyle(color: AppColors.black, fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      const Text("                   "),
                      IconButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) => CupertinoActionSheetActionWidget(
                                onPressed: () {},
                                text: 'Delete Poll',
                              ),
                            );
                          },
                          icon: SvgPicture.asset(AppImages.delete)),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Consumer<CreatePollNotifier>(
                      builder: (context, filter, child) {
                        return FutureBuilder(
                            future: Future.wait([
                              getPoll(widget.pollId, token),
                              filter.isAccordionOpen
                                  ? getVotes(
                                      pollId: widget.pollId,
                                      token: token,
                                      age: [filter.minAge, filter.maxAge],
                     
                                      location: filter.selectedLanguage.join(', '),
                                      maternalLang: filter.selectedLocation,
                                      gender: filter.selectedGender.name,
                                      nationality: filter.selectedNationality,
                                    )
                                  : getVotes(
                                      pollId: widget.pollId,
                                      token: token,
                                    ),
                              getUserVote(widget.pollId, token),
                            ]),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.data != null && snapshot.hasData) {
                                final poll = snapshot.data![0] as Poll;
                                final votes = snapshot.data![1] as Votes;
                                final userVote = snapshot.data![2] as int?;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      poll.name,
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: poll.options.length,
                                      itemBuilder: (context, index) {
                                        final option = poll.options[index];
                                        final voteCount = votes.voteResults[index];
                                        final votePercent = votes.totalVotes == 0
                                            ? 0
                                            : (voteCount / votes.totalVotes * 100).toStringAsFixed(1);

                                        return ListTile(
                                          contentPadding: const EdgeInsets.all(0),
                                          leading: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: index == userVote ? AppColors.c_5856D6 : AppColors.c_93A2B4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                answerList[index],
                                                style: AppTextStyle.bodyLargeBold.copyWith(
                                                  color: index == userVote ? AppColors.white : AppColors.c_5856D6,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(option.text??''),
                                          subtitle: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: votes.totalVotes == 0
                                                    ? 10
                                                    : MediaQuery.of(context).size.width *
                                                        (voteCount / votes.totalVotes),
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: index == userVote ? AppColors.c_5856D6 : AppColors.c_93A2B4,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            '$votePercent%',
                                            style: AppTextStyle.bodyMediumRegular.copyWith(color: AppColors.c_93A2B4),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            });
                      },
                    ),
                  ),
                  const AdvancedAudienceControl(
                    padding: EdgeInsets.only(top: 20),
                    safeAreaTop: false,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class PollResultOption extends StatelessWidget {
  final Votes vote;
  final Option option;
  final bool isSelected;
  final int index;
  final double indicatorWidth;
  final String votePercent;

  const PollResultOption(
      {super.key,
      required this.vote,
      required this.isSelected,
      required this.index,
      required this.option,
      required this.indicatorWidth,
      required this.votePercent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? AppColors.c_5856D6 : const Color(0x00F2F2F7),
            radius: 40,
            child: Text(answerList[index]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(option.text??''),
              Stack(
                children: <Widget>[
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 15,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.c_5856D6 : const Color(0x00F2F2F7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text('$votePercent%')
        ],
      ),
    );
  }
}
