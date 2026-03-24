import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:poll_dao/src/features/create_poll/data/enum.dart';
import 'package:poll_dao/src/features/create_poll/data/models/option_model.dart';
import 'package:poll_dao/src/features/create_poll/domain/repositories/repository.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/gender_widget.dart';

class CreatePollNotifier with ChangeNotifier {
  CreatePollNotifier(this._repository);
  final CreatePollRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> sendPollRequest() async {
    validate();
    if (validationRequired) {
      notifyListeners();
      return false;
    }
    _isLoading = true;
    notifyListeners();
    try {
      if (_isAccordionOpen) {
        await _repository.sendPollRequest(
          name: _question,
          topic: _selectedTopicIndex!,
          options: _options,
          location: _selectedLocation,
          biometryPassed: _forVerifiedUsersOnly,
          minAge: _minAge,
          maxAge: _maxAge,
          education: _selectedEducationLevel,
          gender: selectedGender.name,
          maternalLang: _selectedLanguage.join(', '),
          nationality: selectedNationality,
        );
      } else {
        await _repository.sendPollRequest(
          name: _question,
          topic: _selectedTopicIndex!,
          options: _options,
        );
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e, st) {
      _isLoading = false;
      notifyListeners();
      log('Error sending poll request', error: e, stackTrace: st);
      return false;
    }
  }

  void validate() {
    if (isQuestionValidated && isOptionsValidated && isTopicSelected && isOptionsPropertiesValid) {
      _validationRequired = false;
    } else {
      _validationRequired = true;
    }
  }

  bool get isQuestionValidated => _question.isNotEmpty;
  bool get isOptionsValidated => _options.length >= 2;
  bool get isTopicSelected => _selectedTopicIndex != null;
  bool get isOptionsPropertiesValid {
    if (_answerType == null) {
      return false;
    }

    switch (_answerType!) {
      case OptionsType.text:
        return _options.every((element) => element.text != null && element.text!.isNotEmpty);
      case OptionsType.image:
        return _options.every((element) => element.image != null);
      case OptionsType.textImage:
        return _options.every((element) =>
            element.text != null && element.text!.isNotEmpty && element.image != null && element.image!.isNotEmpty);
    }
  }

  bool _validationRequired = false;
  bool get validationRequired => _validationRequired;

  bool _isAccordionOpen = false;
  bool get isAccordionOpen => _isAccordionOpen;
  void toggleAccordion(bool value) {
    _isAccordionOpen = value;
    notifyListeners();
  }

  String _question = '';
  String get question => _question;
  void setQuestion(String value) {
    _question = value;
    _validationRequired = false;
    notifyListeners();
  }

  OptionsType? _answerType;
  OptionsType? get answerType => _answerType;
  void setAnswerType(OptionsType? type) {
    _answerType = type;
    _validationRequired = false;
    notifyListeners();
  }

  final List<OptionModel> _options = [];
  List<OptionModel> get options => _options;

  int? _selectedTopicIndex;
  int? get selectedTopicIndex => _selectedTopicIndex;
  void setSelectedTopic(int? topicIndex) {
    if (_selectedTopicIndex == topicIndex) {
      _selectedTopicIndex = null;
    } else {
      _selectedTopicIndex = topicIndex;
    }
    _validationRequired = false;
    notifyListeners();
  }

  bool _forVerifiedUsersOnly = false;
  bool get forVerifiedUsersOnly => _forVerifiedUsersOnly;
  void toggleForVerifiedUsersOnly(bool value) {
    _forVerifiedUsersOnly = value;
    _validationRequired = false;
    notifyListeners();
  }

  GenderType _selectedGender = GenderType.all;
  GenderType get selectedGender => _selectedGender;
  void setSelectedGender(GenderType genderType) {
    _selectedGender = genderType;
    notifyListeners();
  }

  int _minAge = 14;
  int get minAge => _minAge;
  void setMinAge(int value) {
    _minAge = value;
    notifyListeners();
  }

  int _maxAge = 100;
  int get maxAge => _maxAge;
  void setMaxAge(int value) {
    _maxAge = value;
    notifyListeners();
  }

  String _selectedLocation = '';
  String get selectedLocation => _selectedLocation;
  void setSelectedLocation(String value) {
    _selectedLocation = value;
    notifyListeners();
  }

  String _selectedEducationLevel = '';
  String get selectedEducationLevel => _selectedEducationLevel;
  void setSelectedEducationLevel(String value) {
    _selectedEducationLevel = value;
    notifyListeners();
  }

  List<String> _selectedLanguage = [];
  List<String> get selectedLanguage => _selectedLanguage;
  void setSelectedLanguage(List<String> value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  String _selectedNationality = '';
  String get selectedNationality => _selectedNationality;
  void setSelectedNationality(String value) {
    _selectedNationality = value;
    notifyListeners();
  }

  void deleteImage(int index) {
    _options.removeAt(index);
    notifyListeners();
  }

  void editOption(int index, OptionModel value) {
    debugPrint('editOption: $index, $value');
    _options[index] = value;
    _validationRequired = false;
    notifyListeners();
  }

  void addOption(OptionModel option) {
    debugPrint('addOption: ${option.createdAt}');
    _options.add(option);
    _validationRequired = false;
    notifyListeners();
  }

  void reorderOptions(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = _options.removeAt(oldIndex);
    _options.insert(newIndex, item);
    notifyListeners();
  }
}
