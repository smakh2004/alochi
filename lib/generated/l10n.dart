// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get langauage {
    return Intl.message('English', name: 'langauage', desc: '', args: []);
  }

  /// `I HAVE AN ACCOUNT`
  String get akkaunt {
    return Intl.message(
      'I HAVE AN ACCOUNT',
      name: 'akkaunt',
      desc: '',
      args: [],
    );
  }

  /// `This app helps you deeply understand mathematics. Geometric figures will support you along the way.`
  String get intro {
    return Intl.message(
      'This app helps you deeply understand mathematics. Geometric figures will support you along the way.',
      name: 'intro',
      desc: '',
      args: [],
    );
  }

  /// `WIN STREAK`
  String get intro2desc {
    return Intl.message('WIN STREAK', name: 'intro2desc', desc: '', args: []);
  }

  /// `Each step here leads to success. Ahead of you are exciting challenges, achievements, and rewards. Are you ready to begin?`
  String get intro2 {
    return Intl.message(
      'Each step here leads to success. Ahead of you are exciting challenges, achievements, and rewards. Are you ready to begin?',
      name: 'intro2',
      desc: '',
      args: [],
    );
  }

  /// `PURPOSE`
  String get intro3desc {
    return Intl.message('PURPOSE', name: 'intro3desc', desc: '', args: []);
  }

  /// `The purpose of the app is to make learning mathematics easy and understandable. At each stage, you’ll be supported by engaging examples and visual helpers.`
  String get intro3 {
    return Intl.message(
      'The purpose of the app is to make learning mathematics easy and understandable. At each stage, you’ll be supported by engaging examples and visual helpers.',
      name: 'intro3',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get tizimgaKirish {
    return Intl.message('Login', name: 'tizimgaKirish', desc: '', args: []);
  }

  /// `We’re very happy to have you back!`
  String get tizimgaKirishDes {
    return Intl.message(
      'We’re very happy to have you back!',
      name: 'tizimgaKirishDes',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get parol {
    return Intl.message('Password', name: 'parol', desc: '', args: []);
  }

  /// `LOGIN`
  String get kirish {
    return Intl.message('LOGIN', name: 'kirish', desc: '', args: []);
  }

  /// `Don't have an account? `
  String get akkauntizYoqmi {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'akkauntizYoqmi',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get registratsiyaQilish {
    return Intl.message(
      'Sign up',
      name: 'registratsiyaQilish',
      desc: '',
      args: [],
    );
  }

  /// `-Sign in with Google-`
  String get googleOrqali {
    return Intl.message(
      '-Sign in with Google-',
      name: 'googleOrqali',
      desc: '',
      args: [],
    );
  }

  /// `Elementary school`
  String get boshlangich {
    return Intl.message(
      'Elementary school',
      name: 'boshlangich',
      desc: '',
      args: [],
    );
  }

  /// `High school`
  String get yuqoriSinf {
    return Intl.message('High school', name: 'yuqoriSinf', desc: '', args: []);
  }

  /// `University`
  String get student {
    return Intl.message('University', name: 'student', desc: '', args: []);
  }

  /// `Choose your math skill level!`
  String get messageOfMrSquare {
    return Intl.message(
      'Choose your math skill level!',
      name: 'messageOfMrSquare',
      desc: '',
      args: [],
    );
  }

  /// `LET'S GO`
  String get boshlash {
    return Intl.message('LET\'S GO', name: 'boshlash', desc: '', args: []);
  }

  /// `CONTINUE`
  String get davomEtish {
    return Intl.message('CONTINUE', name: 'davomEtish', desc: '', args: []);
  }

  /// `A'lochi`
  String get birinchiBosqich {
    return Intl.message(
      'A\'lochi',
      name: 'birinchiBosqich',
      desc: '',
      args: [],
    );
  }

  /// `Profile Statistics`
  String get kvadratQasri {
    return Intl.message(
      'Profile Statistics',
      name: 'kvadratQasri',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get settings {
    return Intl.message('SETTINGS', name: 'settings', desc: '', args: []);
  }

  /// `Settings`
  String get settingsNew {
    return Intl.message('Settings', name: 'settingsNew', desc: '', args: []);
  }

  /// `STATISTICS`
  String get statistika {
    return Intl.message('STATISTICS', name: 'statistika', desc: '', args: []);
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Arifmetic`
  String get arifmetika {
    return Intl.message('Arifmetic', name: 'arifmetika', desc: '', args: []);
  }

  /// `Multiply`
  String get multiplikativ {
    return Intl.message('Multiply', name: 'multiplikativ', desc: '', args: []);
  }

  /// `Logic`
  String get logika {
    return Intl.message('Logic', name: 'logika', desc: '', args: []);
  }

  /// `Winning streak`
  String get glabaliSeriya {
    return Intl.message(
      'Winning streak',
      name: 'glabaliSeriya',
      desc: '',
      args: [],
    );
  }

  /// `Overall points`
  String get umumiyOchko {
    return Intl.message(
      'Overall points',
      name: 'umumiyOchko',
      desc: '',
      args: [],
    );
  }

  /// `ACHIEVEMENTS`
  String get yutuqlar {
    return Intl.message('ACHIEVEMENTS', name: 'yutuqlar', desc: '', args: []);
  }

  /// `SEE ALL`
  String get hammasiniKorish {
    return Intl.message('SEE ALL', name: 'hammasiniKorish', desc: '', args: []);
  }

  /// `Achievements of 2025`
  String get TwoFiveYutuqlar {
    return Intl.message(
      'Achievements of 2025',
      name: 'TwoFiveYutuqlar',
      desc: '',
      args: [],
    );
  }

  /// `The Square Castle Cup`
  String get kvadratQasriKubogi {
    return Intl.message(
      'The Square Castle Cup',
      name: 'kvadratQasriKubogi',
      desc: '',
      args: [],
    );
  }

  /// `Awarded for solving all Mr.Square problems correctly!`
  String get kvadratQasriKubogiDes {
    return Intl.message(
      'Awarded for solving all Mr.Square problems correctly!',
      name: 'kvadratQasriKubogiDes',
      desc: '',
      args: [],
    );
  }

  /// `Winning streak: activated!`
  String get galabaliSeriyaBoshlandi {
    return Intl.message(
      'Winning streak: activated!',
      name: 'galabaliSeriyaBoshlandi',
      desc: '',
      args: [],
    );
  }

  /// `Awarded for achieving your first winning streak.`
  String get galabaliSeriyaBoshlandiDes {
    return Intl.message(
      'Awarded for achieving your first winning streak.',
      name: 'galabaliSeriyaBoshlandiDes',
      desc: '',
      args: [],
    );
  }

  /// `Speedy!`
  String get tezkor {
    return Intl.message('Speedy!', name: 'tezkor', desc: '', args: []);
  }

  /// `Awarded for solving the problems in record time.`
  String get tezkorDes {
    return Intl.message(
      'Awarded for solving the problems in record time.',
      name: 'tezkorDes',
      desc: '',
      args: [],
    );
  }

  /// `Locked medal`
  String get yopiqMedal {
    return Intl.message('Locked medal', name: 'yopiqMedal', desc: '', args: []);
  }

  /// `Medal not unlocked yet.`
  String get yopiqMedalDes {
    return Intl.message(
      'Medal not unlocked yet.',
      name: 'yopiqMedalDes',
      desc: '',
      args: [],
    );
  }

  /// `Achievements of 2026`
  String get TwoSixYutuqlar {
    return Intl.message(
      'Achievements of 2026',
      name: 'TwoSixYutuqlar',
      desc: '',
      args: [],
    );
  }

  /// `Achievements of 2027`
  String get TwoSevenYutuqlar {
    return Intl.message(
      'Achievements of 2027',
      name: 'TwoSevenYutuqlar',
      desc: '',
      args: [],
    );
  }

  /// `LEVEL 1, SQUARE CASTLE`
  String get kvadratQasriBirinchiBosqich {
    return Intl.message(
      'LEVEL 1, SQUARE CASTLE',
      name: 'kvadratQasriBirinchiBosqich',
      desc: '',
      args: [],
    );
  }

  /// `World of numbers`
  String get kvadratQasriBirinchiBosqichDes {
    return Intl.message(
      'World of numbers',
      name: 'kvadratQasriBirinchiBosqichDes',
      desc: '',
      args: [],
    );
  }

  /// `TRIANGLE PIRAMIDS | SECOND LEVEL`
  String get uchburchakPiramidasiIkkinchiBosqich {
    return Intl.message(
      'TRIANGLE PIRAMIDS | SECOND LEVEL',
      name: 'uchburchakPiramidasiIkkinchiBosqich',
      desc: '',
      args: [],
    );
  }

  /// `THE SECRET OF MATH OPERATIONS`
  String get uchburchakPiramidasiIkkinchiBosqichDes {
    return Intl.message(
      'THE SECRET OF MATH OPERATIONS',
      name: 'uchburchakPiramidasiIkkinchiBosqichDes',
      desc: '',
      args: [],
    );
  }

  /// `CIRCLE CASTLE | STAGE THREE`
  String get doiraQasriUchinchiBosqich {
    return Intl.message(
      'CIRCLE CASTLE | STAGE THREE',
      name: 'doiraQasriUchinchiBosqich',
      desc: '',
      args: [],
    );
  }

  /// `THE WORLD OF FRACTIONS AND SHAPES`
  String get doiraQasriUchinchiBosqichDes {
    return Intl.message(
      'THE WORLD OF FRACTIONS AND SHAPES',
      name: 'doiraQasriUchinchiBosqichDes',
      desc: '',
      args: [],
    );
  }

  /// `RECHARGING IN: {time}`
  String rechargingIn(Object time) {
    return Intl.message(
      'RECHARGING IN: $time',
      name: 'rechargingIn',
      desc: '',
      args: [time],
    );
  }

  /// `START`
  String get start {
    return Intl.message('START', name: 'start', desc: '', args: []);
  }

  /// `Counting, addition-subtraction, recognizing shapes`
  String get kvadratBirinchiBosqichDes {
    return Intl.message(
      'Counting, addition-subtraction, recognizing shapes',
      name: 'kvadratBirinchiBosqichDes',
      desc: '',
      args: [],
    );
  }

  /// `Multiplication/division, place value, measurements`
  String get uchburchakIkkinchiBosqichDes {
    return Intl.message(
      'Multiplication/division, place value, measurements',
      name: 'uchburchakIkkinchiBosqichDes',
      desc: '',
      args: [],
    );
  }

  /// `Math`
  String get matematika {
    return Intl.message('Math', name: 'matematika', desc: '', args: []);
  }

  /// `Store`
  String get magazin {
    return Intl.message('Store', name: 'magazin', desc: '', args: []);
  }

  /// `My Items`
  String get magazinNarsalarim {
    return Intl.message(
      'My Items',
      name: 'magazinNarsalarim',
      desc: '',
      args: [],
    );
  }

  /// `Hearts Stock`
  String get jonlarZapasi {
    return Intl.message(
      'Hearts Stock',
      name: 'jonlarZapasi',
      desc: '',
      args: [],
    );
  }

  /// `Heart`
  String get jon {
    return Intl.message('Heart', name: 'jon', desc: '', args: []);
  }

  /// `Basket Hearts`
  String get savatJon {
    return Intl.message('Basket Hearts', name: 'savatJon', desc: '', args: []);
  }

  /// `Chest of Hearts`
  String get sandiqJon {
    return Intl.message(
      'Chest of Hearts',
      name: 'sandiqJon',
      desc: '',
      args: [],
    );
  }

  /// `Treasures of the Square Castle`
  String get kvadratQasriXazinalari {
    return Intl.message(
      'Treasures of the Square Castle',
      name: 'kvadratQasriXazinalari',
      desc: '',
      args: [],
    );
  }

  /// `Square Box`
  String get kvadratSandiq {
    return Intl.message(
      'Square Box',
      name: 'kvadratSandiq',
      desc: '',
      args: [],
    );
  }

  /// `Square Time`
  String get kvadratVaqt {
    return Intl.message('Square Time', name: 'kvadratVaqt', desc: '', args: []);
  }

  /// `Square Boost`
  String get kvadratBust {
    return Intl.message(
      'Square Boost',
      name: 'kvadratBust',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get sekund {
    return Intl.message('second', name: 'sekund', desc: '', args: []);
  }

  /// `Treasures of the Triangle Pyramid`
  String get uchburchakPiramidasiXazinalari {
    return Intl.message(
      'Treasures of the Triangle Pyramid',
      name: 'uchburchakPiramidasiXazinalari',
      desc: '',
      args: [],
    );
  }

  /// `Triangle Chest`
  String get uchburchakSandiq {
    return Intl.message(
      'Triangle Chest',
      name: 'uchburchakSandiq',
      desc: '',
      args: [],
    );
  }

  /// `Triangle Time`
  String get uchburchakVaqt {
    return Intl.message(
      'Triangle Time',
      name: 'uchburchakVaqt',
      desc: '',
      args: [],
    );
  }

  /// `Triangle Boost`
  String get uchburchakBust {
    return Intl.message(
      'Triangle Boost',
      name: 'uchburchakBust',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get miqdori {
    return Intl.message('Quantity', name: 'miqdori', desc: '', args: []);
  }

  /// `Usage`
  String get ishlatish {
    return Intl.message('Usage', name: 'ishlatish', desc: '', args: []);
  }

  /// `Cost`
  String get narxi {
    return Intl.message('Cost', name: 'narxi', desc: '', args: []);
  }

  /// `Buy`
  String get sotibOlish {
    return Intl.message('Buy', name: 'sotibOlish', desc: '', args: []);
  }

  /// `Solve the given problem.`
  String get berilganMisolniYeching {
    return Intl.message(
      'Solve the given problem.',
      name: 'berilganMisolniYeching',
      desc: '',
      args: [],
    );
  }

  /// `Correct answer!`
  String get togriJavob {
    return Intl.message(
      'Correct answer!',
      name: 'togriJavob',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect answer!`
  String get notogriJavob {
    return Intl.message(
      'Incorrect answer!',
      name: 'notogriJavob',
      desc: '',
      args: [],
    );
  }

  /// `CHECK`
  String get tekshirish {
    return Intl.message('CHECK', name: 'tekshirish', desc: '', args: []);
  }

  /// `Please wait, 1 minute left until the lesson ends!`
  String get darstTugashiga {
    return Intl.message(
      'Please wait, 1 minute left until the lesson ends!',
      name: 'darstTugashiga',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE THE LESSON`
  String get darsDavomEtish {
    return Intl.message(
      'CONTINUE THE LESSON',
      name: 'darsDavomEtish',
      desc: '',
      args: [],
    );
  }

  /// `EXIT`
  String get chiqish {
    return Intl.message('EXIT', name: 'chiqish', desc: '', args: []);
  }

  /// `Select the correct sign`
  String get togriBeliginiTanglang {
    return Intl.message(
      'Select the correct sign',
      name: 'togriBeliginiTanglang',
      desc: '',
      args: [],
    );
  }

  /// `The pizza is divided into equal parts. How many slices were taken from the plate?`
  String get pitsaniTeng {
    return Intl.message(
      'The pizza is divided into equal parts. How many slices were taken from the plate?',
      name: 'pitsaniTeng',
      desc: '',
      args: [],
    );
  }

  /// `Which shape is divided into equal halves?`
  String get qaysiBirShakl {
    return Intl.message(
      'Which shape is divided into equal halves?',
      name: 'qaysiBirShakl',
      desc: '',
      args: [],
    );
  }

  /// `Solve the given problem. Only one number fits in the blue boxes.`
  String get kokKatakchalar {
    return Intl.message(
      'Solve the given problem. Only one number fits in the blue boxes.',
      name: 'kokKatakchalar',
      desc: '',
      args: [],
    );
  }

  /// `Place the horse in the correct square!`
  String get otniTogri {
    return Intl.message(
      'Place the horse in the correct square!',
      name: 'otniTogri',
      desc: '',
      args: [],
    );
  }

  /// `You Lose!`
  String get joningiztugadi {
    return Intl.message(
      'You Lose!',
      name: 'joningiztugadi',
      desc: '',
      args: [],
    );
  }

  /// `Take a break and come back later!`
  String get tanafuzQilib {
    return Intl.message(
      'Take a break and come back later!',
      name: 'tanafuzQilib',
      desc: '',
      args: [],
    );
  }

  /// `RETURN HOME`
  String get uygaQaytish {
    return Intl.message('RETURN HOME', name: 'uygaQaytish', desc: '', args: []);
  }

  /// `GREAT LESSON!`
  String get ajoyibDars {
    return Intl.message(
      'GREAT LESSON!',
      name: 'ajoyibDars',
      desc: '',
      args: [],
    );
  }

  /// `POINTS`
  String get ochko {
    return Intl.message('POINTS', name: 'ochko', desc: '', args: []);
  }

  /// `TIME`
  String get vaqt {
    return Intl.message('TIME', name: 'vaqt', desc: '', args: []);
  }

  /// `ACCURACY`
  String get aniqlik {
    return Intl.message('ACCURACY', name: 'aniqlik', desc: '', args: []);
  }

  /// `See you tomorrow!`
  String get sizniErtagaKutamiz {
    return Intl.message(
      'See you tomorrow!',
      name: 'sizniErtagaKutamiz',
      desc: '',
      args: [],
    );
  }

  /// `Keep your winning streak!`
  String get davomiyYutuq {
    return Intl.message(
      'Keep your winning streak!',
      name: 'davomiyYutuq',
      desc: '',
      args: [],
    );
  }

  /// `Which shapes combine to form a square?`
  String get qaysiShakillar {
    return Intl.message(
      'Which shapes combine to form a square?',
      name: 'qaysiShakillar',
      desc: '',
      args: [],
    );
  }

  /// `Aziz folds the piece of paper along the drawn line. What does he see?`
  String get azizChizilgan {
    return Intl.message(
      'Aziz folds the piece of paper along the drawn line. What does he see?',
      name: 'azizChizilgan',
      desc: '',
      args: [],
    );
  }

  /// `Solve the given problem. The blue boxes must be filled with coins of equal value.`
  String get berilganMisolni {
    return Intl.message(
      'Solve the given problem. The blue boxes must be filled with coins of equal value.',
      name: 'berilganMisolni',
      desc: '',
      args: [],
    );
  }

  /// `Keep adding 4 and find the last number.`
  String get torgaQoshib {
    return Intl.message(
      'Keep adding 4 and find the last number.',
      name: 'torgaQoshib',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Alochi app, get ready to enjoy new challenges!`
  String get notification1 {
    return Intl.message(
      'Welcome to the Alochi app, get ready to enjoy new challenges!',
      name: 'notification1',
      desc: '',
      args: [],
    );
  }

  /// `Let's explore the Square Castle together! An exciting adventure awaits us.`
  String get notification2 {
    return Intl.message(
      'Let\'s explore the Square Castle together! An exciting adventure awaits us.',
      name: 'notification2',
      desc: '',
      args: [],
    );
  }

  /// `Let's go collect the lightning bolts!`
  String get notification3 {
    return Intl.message(
      'Let\'s go collect the lightning bolts!',
      name: 'notification3',
      desc: '',
      args: [],
    );
  }

  /// `NOTIFICATIONS`
  String get xabarlar {
    return Intl.message('NOTIFICATIONS', name: 'xabarlar', desc: '', args: []);
  }

  /// `Unlimited hearts`
  String get cheksizJonlar {
    return Intl.message(
      'Unlimited hearts',
      name: 'cheksizJonlar',
      desc: '',
      args: [],
    );
  }

  /// `Math storm`
  String get matematikShtorm {
    return Intl.message(
      'Math storm',
      name: 'matematikShtorm',
      desc: '',
      args: [],
    );
  }

  /// `1 month Premium`
  String get onePremium {
    return Intl.message(
      '1 month Premium',
      name: 'onePremium',
      desc: '',
      args: [],
    );
  }

  /// `3 months Premium`
  String get threePremium {
    return Intl.message(
      '3 months Premium',
      name: 'threePremium',
      desc: '',
      args: [],
    );
  }

  /// `1 year Premium`
  String get twelvePremium {
    return Intl.message(
      '1 year Premium',
      name: 'twelvePremium',
      desc: '',
      args: [],
    );
  }

  /// `GET STARTED`
  String get yoqish {
    return Intl.message('GET STARTED', name: 'yoqish', desc: '', args: []);
  }

  /// `Arithmetic storm`
  String get arifmetikStorm {
    return Intl.message(
      'Arithmetic storm',
      name: 'arifmetikStorm',
      desc: '',
      args: [],
    );
  }

  /// `LET'S GO`
  String get olga {
    return Intl.message('LET\'S GO', name: 'olga', desc: '', args: []);
  }

  /// `MATH STORM`
  String get mathStorm {
    return Intl.message('MATH STORM', name: 'mathStorm', desc: '', args: []);
  }

  /// `Record: `
  String get rekord {
    return Intl.message('Record: ', name: 'rekord', desc: '', args: []);
  }

  /// `Number of attempts: `
  String get urinishlarSoni {
    return Intl.message(
      'Number of attempts: ',
      name: 'urinishlarSoni',
      desc: '',
      args: [],
    );
  }

  /// `New attempts: `
  String get yangiUrinishlar {
    return Intl.message(
      'New attempts: ',
      name: 'yangiUrinishlar',
      desc: '',
      args: [],
    );
  }

  /// `are recovering`
  String get danSong {
    return Intl.message('are recovering', name: 'danSong', desc: '', args: []);
  }

  /// `minutes`
  String get minut {
    return Intl.message('minutes', name: 'minut', desc: '', args: []);
  }

  /// `hearts`
  String get dona {
    return Intl.message('hearts', name: 'dona', desc: '', args: []);
  }

  /// `New record!`
  String get yangiRekord {
    return Intl.message('New record!', name: 'yangiRekord', desc: '', args: []);
  }

  /// `Nice try!`
  String get yaxshiUrinish {
    return Intl.message('Nice try!', name: 'yaxshiUrinish', desc: '', args: []);
  }

  /// `RETURN`
  String get qaytish {
    return Intl.message('RETURN', name: 'qaytish', desc: '', args: []);
  }

  /// `If you leave, you will lose one attempt!`
  String get agarChiqibKetsangiz {
    return Intl.message(
      'If you leave, you will lose one attempt!',
      name: 'agarChiqibKetsangiz',
      desc: '',
      args: [],
    );
  }

  /// `Points: `
  String get Ochko {
    return Intl.message('Points: ', name: 'Ochko', desc: '', args: []);
  }

  /// `Enter your answer and set a record.`
  String get javobKiriting {
    return Intl.message(
      'Enter your answer and set a record.',
      name: 'javobKiriting',
      desc: '',
      args: [],
    );
  }

  /// `For example: -4`
  String get misolUchun {
    return Intl.message(
      'For example: -4',
      name: 'misolUchun',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get keyingi {
    return Intl.message('NEXT', name: 'keyingi', desc: '', args: []);
  }

  /// `Soon...`
  String get xaliRazrabotkada {
    return Intl.message(
      'Soon...',
      name: 'xaliRazrabotkada',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get ortgaQaytish {
    return Intl.message('Return', name: 'ortgaQaytish', desc: '', args: []);
  }

  /// `5th grade`
  String get beshinchiSinf {
    return Intl.message('5th grade', name: 'beshinchiSinf', desc: '', args: []);
  }

  /// `Natural numbers`
  String get naturalSonlar {
    return Intl.message(
      'Natural numbers',
      name: 'naturalSonlar',
      desc: '',
      args: [],
    );
  }

  /// `Sample problems`
  String get matnliMasalalar {
    return Intl.message(
      'Sample problems',
      name: 'matnliMasalalar',
      desc: '',
      args: [],
    );
  }

  /// `Geometry`
  String get geometriya {
    return Intl.message('Geometry', name: 'geometriya', desc: '', args: []);
  }

  /// `Simple fractions`
  String get oddiyKasrlar {
    return Intl.message(
      'Simple fractions',
      name: 'oddiyKasrlar',
      desc: '',
      args: [],
    );
  }

  /// `Spatial shapes`
  String get fazoviyShakllar {
    return Intl.message(
      'Spatial shapes',
      name: 'fazoviyShakllar',
      desc: '',
      args: [],
    );
  }

  /// `Decimal fractions`
  String get onliKasrlar {
    return Intl.message(
      'Decimal fractions',
      name: 'onliKasrlar',
      desc: '',
      args: [],
    );
  }

  /// `Data analysis`
  String get malumotlarTahlili {
    return Intl.message(
      'Data analysis',
      name: 'malumotlarTahlili',
      desc: '',
      args: [],
    );
  }

  /// `6th grade`
  String get oltinchiSinf {
    return Intl.message('6th grade', name: 'oltinchiSinf', desc: '', args: []);
  }

  /// `Fractions with different denominators`
  String get harXilMaxrajliKasrlar {
    return Intl.message(
      'Fractions with different denominators',
      name: 'harXilMaxrajliKasrlar',
      desc: '',
      args: [],
    );
  }

  /// `Multiplication/Division of fractions`
  String get kasrlarniKopaytirishBolish {
    return Intl.message(
      'Multiplication/Division of fractions',
      name: 'kasrlarniKopaytirishBolish',
      desc: '',
      args: [],
    );
  }

  /// `Ratio and proportion`
  String get nisbatVaProporsiya {
    return Intl.message(
      'Ratio and proportion',
      name: 'nisbatVaProporsiya',
      desc: '',
      args: [],
    );
  }

  /// `Whole numbers`
  String get butunSonlar {
    return Intl.message(
      'Whole numbers',
      name: 'butunSonlar',
      desc: '',
      args: [],
    );
  }

  /// `Rational numbers`
  String get ratsionalSonlar {
    return Intl.message(
      'Rational numbers',
      name: 'ratsionalSonlar',
      desc: '',
      args: [],
    );
  }

  /// `Equations`
  String get tenglamalar {
    return Intl.message('Equations', name: 'tenglamalar', desc: '', args: []);
  }

  /// `Working with data`
  String get malumotlarBilanIshlash {
    return Intl.message(
      'Working with data',
      name: 'malumotlarBilanIshlash',
      desc: '',
      args: [],
    );
  }

  /// `Geometric material`
  String get geometrikMaterial {
    return Intl.message(
      'Geometric material',
      name: 'geometrikMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Final review`
  String get yakuniyTakrorlash {
    return Intl.message(
      'Final review',
      name: 'yakuniyTakrorlash',
      desc: '',
      args: [],
    );
  }

  /// `7th grade`
  String get yetinchiSinf {
    return Intl.message('7th grade', name: 'yetinchiSinf', desc: '', args: []);
  }

  /// `Algebraic expressions`
  String get algebraikIfodalar {
    return Intl.message(
      'Algebraic expressions',
      name: 'algebraikIfodalar',
      desc: '',
      args: [],
    );
  }

  /// `First-degree equations`
  String get birinchiDarajaliTenglamalar {
    return Intl.message(
      'First-degree equations',
      name: 'birinchiDarajaliTenglamalar',
      desc: '',
      args: [],
    );
  }

  /// `Monomials and polynomials`
  String get birhadlarVaKophadlar {
    return Intl.message(
      'Monomials and polynomials',
      name: 'birhadlarVaKophadlar',
      desc: '',
      args: [],
    );
  }

  /// `Factoring polynomials`
  String get kophadniAjratish {
    return Intl.message(
      'Factoring polynomials',
      name: 'kophadniAjratish',
      desc: '',
      args: [],
    );
  }

  /// `Algebraic fractions`
  String get algebraikKasrlar {
    return Intl.message(
      'Algebraic fractions',
      name: 'algebraikKasrlar',
      desc: '',
      args: [],
    );
  }

  /// `Combinatorics`
  String get kombinatorika {
    return Intl.message(
      'Combinatorics',
      name: 'kombinatorika',
      desc: '',
      args: [],
    );
  }

  /// `8th grade`
  String get sakkizinchiSinf {
    return Intl.message(
      '8th grade',
      name: 'sakkizinchiSinf',
      desc: '',
      args: [],
    );
  }

  /// `Algebraic fractions and rational expressions`
  String get algebraikKasrlarVaRatsionalIfodalar {
    return Intl.message(
      'Algebraic fractions and rational expressions',
      name: 'algebraikKasrlarVaRatsionalIfodalar',
      desc: '',
      args: [],
    );
  }

  /// `Powers and roots`
  String get darajalarVaIldizlar {
    return Intl.message(
      'Powers and roots',
      name: 'darajalarVaIldizlar',
      desc: '',
      args: [],
    );
  }

  /// `Y = k/x function`
  String get funksiyasi {
    return Intl.message(
      'Y = k/x function',
      name: 'funksiyasi',
      desc: '',
      args: [],
    );
  }

  /// `Inequalities`
  String get tengsizliklar {
    return Intl.message(
      'Inequalities',
      name: 'tengsizliklar',
      desc: '',
      args: [],
    );
  }

  /// `Quadratic equations`
  String get kvadratTenglamalar {
    return Intl.message(
      'Quadratic equations',
      name: 'kvadratTenglamalar',
      desc: '',
      args: [],
    );
  }

  /// `Approximate calculations and errors`
  String get taqribiyHisoblashVaXatoliklar {
    return Intl.message(
      'Approximate calculations and errors',
      name: 'taqribiyHisoblashVaXatoliklar',
      desc: '',
      args: [],
    );
  }

  /// `9th grade`
  String get toqqizinchiSinf {
    return Intl.message(
      '9th grade',
      name: 'toqqizinchiSinf',
      desc: '',
      args: [],
    );
  }

  /// `Quadratic functions and inequalities`
  String get kvadratFunksiyaTaTengsizliklar {
    return Intl.message(
      'Quadratic functions and inequalities',
      name: 'kvadratFunksiyaTaTengsizliklar',
      desc: '',
      args: [],
    );
  }

  /// `Systems of equations and inequalities`
  String get tenglamalarVaTengsizliklarSistemalari {
    return Intl.message(
      'Systems of equations and inequalities',
      name: 'tenglamalarVaTengsizliklarSistemalari',
      desc: '',
      args: [],
    );
  }

  /// `Basics of trigonometry`
  String get trigonometriyaAsoslari {
    return Intl.message(
      'Basics of trigonometry',
      name: 'trigonometriyaAsoslari',
      desc: '',
      args: [],
    );
  }

  /// `Numerical sequences`
  String get sonliKetmaKetliklar {
    return Intl.message(
      'Numerical sequences',
      name: 'sonliKetmaKetliklar',
      desc: '',
      args: [],
    );
  }

  /// `Probability and statistics`
  String get ehtimollarVaStatistik {
    return Intl.message(
      'Probability and statistics',
      name: 'ehtimollarVaStatistik',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email`
  String get emailNotFound {
    return Intl.message(
      'No account found with this email',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get wrongPassword {
    return Intl.message(
      'Incorrect password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password`
  String get somethingWentWrong {
    return Intl.message(
      'Incorrect email or password',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get registratsiya {
    return Intl.message(
      'Registered',
      name: 'registratsiya',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the world of math`
  String get matematikaDunyosi {
    return Intl.message(
      'Welcome to the world of math',
      name: 'matematikaDunyosi',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get parolniTasdiqlash {
    return Intl.message(
      'Confirm password',
      name: 'parolniTasdiqlash',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get registratsiyaQilishQ {
    return Intl.message(
      'SIGN UP',
      name: 'registratsiyaQilishQ',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get akkauntizBormi {
    return Intl.message(
      'Already have an account? ',
      name: 'akkauntizBormi',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get tizimgaKirishQ {
    return Intl.message('Log in', name: 'tizimgaKirishQ', desc: '', args: []);
  }

  /// `You are not signed in yet`
  String get sizHaliKirmagansiz {
    return Intl.message(
      'You are not signed in yet',
      name: 'sizHaliKirmagansiz',
      desc: '',
      args: [],
    );
  }

  /// `USE ACCOUNT`
  String get akkauntgaKirish {
    return Intl.message(
      'USE ACCOUNT',
      name: 'akkauntgaKirish',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered`
  String get emailAlreadyUsed {
    return Intl.message(
      'This email is already registered',
      name: 'emailAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `The email address is invalid`
  String get emailInvalid {
    return Intl.message(
      'The email address is invalid',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak`
  String get weakPassword {
    return Intl.message(
      'The password is too weak',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get yanvar {
    return Intl.message('January', name: 'yanvar', desc: '', args: []);
  }

  /// `February`
  String get fevral {
    return Intl.message('February', name: 'fevral', desc: '', args: []);
  }

  /// `March`
  String get mart {
    return Intl.message('March', name: 'mart', desc: '', args: []);
  }

  /// `April`
  String get aprel {
    return Intl.message('April', name: 'aprel', desc: '', args: []);
  }

  /// `May`
  String get may {
    return Intl.message('May', name: 'may', desc: '', args: []);
  }

  /// `June`
  String get iyun {
    return Intl.message('June', name: 'iyun', desc: '', args: []);
  }

  /// `July`
  String get iyul {
    return Intl.message('July', name: 'iyul', desc: '', args: []);
  }

  /// `August`
  String get avgust {
    return Intl.message('August', name: 'avgust', desc: '', args: []);
  }

  /// `September`
  String get sentabr {
    return Intl.message('September', name: 'sentabr', desc: '', args: []);
  }

  /// `October`
  String get oktabr {
    return Intl.message('October', name: 'oktabr', desc: '', args: []);
  }

  /// `November`
  String get noyabr {
    return Intl.message('November', name: 'noyabr', desc: '', args: []);
  }

  /// `December`
  String get dekabr {
    return Intl.message('December', name: 'dekabr', desc: '', args: []);
  }

  /// `User`
  String get foydalanuvchi {
    return Intl.message('User', name: 'foydalanuvchi', desc: '', args: []);
  }

  /// `Guest`
  String get mehmon {
    return Intl.message('Guest', name: 'mehmon', desc: '', args: []);
  }

  /// `Passwords do not match`
  String get parolNotogriMsg {
    return Intl.message(
      'Passwords do not match',
      name: 'parolNotogriMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please select a level`
  String get darajaTanlanmadiMsg {
    return Intl.message(
      'Please select a level',
      name: 'darajaTanlanmadiMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first and last name`
  String get ismFamiliyaYoqMsg {
    return Intl.message(
      'Please enter your first and last name',
      name: 'ismFamiliyaYoqMsg',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful!`
  String get royxatdanOtildiMsg {
    return Intl.message(
      'Registration successful!',
      name: 'royxatdanOtildiMsg',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Select a level`
  String get darajaniTanlang {
    return Intl.message(
      'Select a level',
      name: 'darajaniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered`
  String get emailAlreadyExists {
    return Intl.message(
      'This email is already registered',
      name: 'emailAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `The email entered is invalid`
  String get emailInvalid1 {
    return Intl.message(
      'The email entered is invalid',
      name: 'emailInvalid1',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak`
  String get weakPassword1 {
    return Intl.message(
      'The password is too weak',
      name: 'weakPassword1',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred: `
  String get errorOccurred {
    return Intl.message(
      'An error occurred: ',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Error:`
  String get xatolik {
    return Intl.message('Error:', name: 'xatolik', desc: '', args: []);
  }

  /// `SIGN OUT`
  String get signOut {
    return Intl.message('SIGN OUT', name: 'signOut', desc: '', args: []);
  }

  /// `No internet connection`
  String get noConnection {
    return Intl.message(
      'No internet connection',
      name: 'noConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get qaytaUrinish {
    return Intl.message('Try again', name: 'qaytaUrinish', desc: '', args: []);
  }

  /// `SAVE`
  String get save {
    return Intl.message('SAVE', name: 'save', desc: '', args: []);
  }

  /// `Accaunt`
  String get akkauntLow {
    return Intl.message('Accaunt', name: 'akkauntLow', desc: '', args: []);
  }

  /// `Parameters`
  String get parameters {
    return Intl.message('Parameters', name: 'parameters', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get kurslar {
    return Intl.message('Courses', name: 'kurslar', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Help center`
  String get helpCenter {
    return Intl.message('Help center', name: 'helpCenter', desc: '', args: []);
  }

  /// `Send feedback`
  String get sendFeedback {
    return Intl.message(
      'Send feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get wrongPassword1 {
    return Intl.message(
      'Incorrect password',
      name: 'wrongPassword1',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmailFormat {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Math storm infinity attempts`
  String get mathShtorm {
    return Intl.message(
      'Math storm infinity attempts',
      name: 'mathShtorm',
      desc: '',
      args: [],
    );
  }

  /// `Which pencil is the longest?`
  String get whichPencil {
    return Intl.message(
      'Which pencil is the longest?',
      name: 'whichPencil',
      desc: '',
      args: [],
    );
  }

  /// `Find the perimeter of a rectangle.`
  String get findThePerimeter {
    return Intl.message(
      'Find the perimeter of a rectangle.',
      name: 'findThePerimeter',
      desc: '',
      args: [],
    );
  }

  /// `Which number is in the triangle and also in the square and also in the circle?`
  String get whichNumberIn {
    return Intl.message(
      'Which number is in the triangle and also in the square and also in the circle?',
      name: 'whichNumberIn',
      desc: '',
      args: [],
    );
  }

  /// `Hint`
  String get hint {
    return Intl.message('Hint', name: 'hint', desc: '', args: []);
  }

  /// `Square Castle`
  String get squareCastle {
    return Intl.message(
      'Square Castle',
      name: 'squareCastle',
      desc: '',
      args: [],
    );
  }

  /// `You are beast!`
  String get beast {
    return Intl.message('You are beast!', name: 'beast', desc: '', args: []);
  }

  /// `Solution:`
  String get solution {
    return Intl.message('Solution:', name: 'solution', desc: '', args: []);
  }

  /// `Subtraction means taking away.\n\nSample:\nIf you have 3 things and you take away 2, count what’s left:\n•  Start with 3 fingers.\n•  Put down 2 fingers.\n•  How many fingers are still up?\n\nThink: 3… take away 1 (now 2)… take away 1 more (now 1).`
  String get hint1 {
    return Intl.message(
      'Subtraction means taking away.\n\nSample:\nIf you have 3 things and you take away 2, count what’s left:\n•  Start with 3 fingers.\n•  Put down 2 fingers.\n•  How many fingers are still up?\n\nThink: 3… take away 1 (now 2)… take away 1 more (now 1).',
      name: 'hint1',
      desc: '',
      args: [],
    );
  }

  /// `When we look at two numbers, we often want to know how they relate to each other.\n\nThere are three main symbols we use:\n1. Equal sign "=" means “is equal to” or “is the same as.” Use it when both sides have the same value.\n2. Less than sign "<" means “is less than.” The number on the left is smaller than the number on the right.\n3. Greater than sign ">" means “is greater than.” The number on the left is bigger than the number on the right.\n\nMemory Trick\nThink of the symbols "<" and ">" like a hungry mouth:\nThe mouth opens toward the bigger number because it wants to eat the larger one.`
  String get hint2 {
    return Intl.message(
      'When we look at two numbers, we often want to know how they relate to each other.\n\nThere are three main symbols we use:\n1. Equal sign "=" means “is equal to” or “is the same as.” Use it when both sides have the same value.\n2. Less than sign "<" means “is less than.” The number on the left is smaller than the number on the right.\n3. Greater than sign ">" means “is greater than.” The number on the left is bigger than the number on the right.\n\nMemory Trick\nThink of the symbols "<" and ">" like a hungry mouth:\nThe mouth opens toward the bigger number because it wants to eat the larger one.',
      name: 'hint2',
      desc: '',
      args: [],
    );
  }

  /// `Look carefully at each line.\nEach picture stands for a number.\nTry to find the value of each picture step by step!\n\nSample:`
  String get hint3 {
    return Intl.message(
      'Look carefully at each line.\nEach picture stands for a number.\nTry to find the value of each picture step by step!\n\nSample:',
      name: 'hint3',
      desc: '',
      args: [],
    );
  }

  /// `Advice:\nSlow down and observe carefully. Look for patterns, differences, or hidden details. Move your eyes across the whole image instead of focusing on one spot. Sometimes the key is in small details that first seem unimportant.`
  String get hint4 {
    return Intl.message(
      'Advice:\nSlow down and observe carefully. Look for patterns, differences, or hidden details. Move your eyes across the whole image instead of focusing on one spot. Sometimes the key is in small details that first seem unimportant.',
      name: 'hint4',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
