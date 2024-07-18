import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz')
  ];

  /// No description provided for @presentation_title.
  ///
  /// In en, this message translates to:
  /// **'MPD'**
  String get presentation_title;

  /// No description provided for @presentation_description.
  ///
  /// In en, this message translates to:
  /// **'This is an application that allows you to control your health'**
  String get presentation_description;

  /// No description provided for @presentation_select_language.
  ///
  /// In en, this message translates to:
  /// **'Start your journey to MPD by choosing a language'**
  String get presentation_select_language;

  /// No description provided for @presentation_language_uz.
  ///
  /// In en, this message translates to:
  /// **'O\'zbek'**
  String get presentation_language_uz;

  /// No description provided for @presentation_language_ru.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get presentation_language_ru;

  /// No description provided for @presentation_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get presentation_language_en;

  /// No description provided for @presentation_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get presentation_next;

  /// No description provided for @presentation_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get presentation_skip;

  /// No description provided for @presentation_first_page.
  ///
  /// In en, this message translates to:
  /// **'Do you need to find a doctor urgently or quickly?'**
  String get presentation_first_page;

  /// No description provided for @presentation_first_page_description.
  ///
  /// In en, this message translates to:
  /// **'Use the doctor map in our app and find the nearest doctor to your location, wherever you are.'**
  String get presentation_first_page_description;

  /// No description provided for @presentation_second_page.
  ///
  /// In en, this message translates to:
  /// **'Keep a copy of your health record in the MPD app in a safe place'**
  String get presentation_second_page;

  /// No description provided for @presentation_second_description.
  ///
  /// In en, this message translates to:
  /// **'Keep your medical profile right in the app. Keep track of your medical history, store your tests and get notified about upcoming doctor visits'**
  String get presentation_second_description;

  /// No description provided for @presentation_third_page.
  ///
  /// In en, this message translates to:
  /// **'Look for fresh reviews from a variety of sources'**
  String get presentation_third_page;

  /// No description provided for @presentation_third_description.
  ///
  /// In en, this message translates to:
  /// **'Our application will help you read reviews about doctors and medical institutions, as well as the doctor\'s rating will help you not to make a mistake in choosing a good specialist.'**
  String get presentation_third_description;

  /// No description provided for @presentation_four_page.
  ///
  /// In en, this message translates to:
  /// **'Access to emergency services'**
  String get presentation_four_page;

  /// No description provided for @presentation_four_page_description.
  ///
  /// In en, this message translates to:
  /// **'Users through the MPD app, caRn get quick access to emergency services with just a few taps'**
  String get presentation_four_page_description;

  /// No description provided for @presentation_get_start.
  ///
  /// In en, this message translates to:
  /// **'Get start'**
  String get presentation_get_start;

  /// No description provided for @login_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!\nLogin to your account'**
  String get login_text;

  /// No description provided for @login_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number or username'**
  String get login_phone;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get login_password;

  /// No description provided for @login_rememberme.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get login_rememberme;

  /// No description provided for @login_forgot.
  ///
  /// In en, this message translates to:
  /// **'forgot password'**
  String get login_forgot;

  /// No description provided for @login_enter.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_enter;

  /// No description provided for @login_register_account.
  ///
  /// In en, this message translates to:
  /// **'Don`t you have an account?'**
  String get login_register_account;

  /// No description provided for @login_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_register;

  /// No description provided for @login_error_account.
  ///
  /// In en, this message translates to:
  /// **'This user not found'**
  String get login_error_account;

  /// No description provided for @login_error.
  ///
  /// In en, this message translates to:
  /// **'Incorrect phone number or password'**
  String get login_error;

  /// No description provided for @restory_account.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number for restore'**
  String get restory_account;

  /// No description provided for @restory_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter phone'**
  String get restory_phone;

  /// No description provided for @restory_button_restory.
  ///
  /// In en, this message translates to:
  /// **'Restory account'**
  String get restory_button_restory;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to MPD!\nEnter your data to Sign Up'**
  String get register_title;

  /// No description provided for @register_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get register_phone;

  /// No description provided for @register_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Term of use'**
  String get register_terms_of_use;

  /// No description provided for @register_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register_register;

  /// No description provided for @register_have_account.
  ///
  /// In en, this message translates to:
  /// **'Do you have an account?'**
  String get register_have_account;

  /// No description provided for @register_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and policy'**
  String get register_privacy_policy;

  /// No description provided for @register_agree_privacy_and_policy.
  ///
  /// In en, this message translates to:
  /// **'I agree and continue'**
  String get register_agree_privacy_and_policy;

  /// No description provided for @register_error_number_format.
  ///
  /// In en, this message translates to:
  /// **'It is not valid phone number '**
  String get register_error_number_format;

  /// No description provided for @register_verify_code.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get register_verify_code;

  /// No description provided for @register_verify_code_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6 digit  code we sent to'**
  String get register_verify_code_description;

  /// No description provided for @register_verify_code_sent_again.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get register_verify_code_sent_again;

  /// No description provided for @register_verify_code_from_message.
  ///
  /// In en, this message translates to:
  /// **'SMS from message'**
  String get register_verify_code_from_message;

  /// No description provided for @register_verify_code_error_code_write.
  ///
  /// In en, this message translates to:
  /// **'You have entered an invalid code'**
  String get register_verify_code_error_code_write;

  /// No description provided for @register_create_password.
  ///
  /// In en, this message translates to:
  /// **'Please create your\npassword'**
  String get register_create_password;

  /// No description provided for @register_new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get register_new_password;

  /// No description provided for @register_new_password_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get register_new_password_confirm;

  /// No description provided for @register_password_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get register_password_continue;

  /// No description provided for @register_error_code_password_missmatch.
  ///
  /// In en, this message translates to:
  /// **'Password mismatch'**
  String get register_error_code_password_missmatch;

  /// No description provided for @register_error_code_password_cant_empty.
  ///
  /// In en, this message translates to:
  /// **'Can not be empty'**
  String get register_error_code_password_cant_empty;

  /// No description provided for @register_error_code_password_mistake.
  ///
  /// In en, this message translates to:
  /// **'This password is too short. It must containt at least 8 characters.'**
  String get register_error_code_password_mistake;

  /// No description provided for @register_user_info.
  ///
  /// In en, this message translates to:
  /// **'Please enter your details to register'**
  String get register_user_info;

  /// No description provided for @register_login.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get register_login;

  /// No description provided for @register_firstname.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get register_firstname;

  /// No description provided for @register_lastname.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get register_lastname;

  /// No description provided for @register_thirdname.
  ///
  /// In en, this message translates to:
  /// **'Thirdname'**
  String get register_thirdname;

  /// No description provided for @register_date_birth.
  ///
  /// In en, this message translates to:
  /// **'Date birth'**
  String get register_date_birth;

  /// No description provided for @register_date_birth_select.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get register_date_birth_select;

  /// No description provided for @register_date_birth_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get register_date_birth_cancel;

  /// No description provided for @register_date_birth_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get register_date_birth_ok;

  /// No description provided for @register_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get register_gender;

  /// No description provided for @register_gender_man.
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get register_gender_man;

  /// No description provided for @register_gender_woman.
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get register_gender_woman;

  /// No description provided for @register_profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get register_profession;

  /// No description provided for @register_profession_title.
  ///
  /// In en, this message translates to:
  /// **'Select your profession'**
  String get register_profession_title;

  /// No description provided for @register_profession_search.
  ///
  /// In en, this message translates to:
  /// **'Search your profession'**
  String get register_profession_search;

  /// No description provided for @register_profession_search_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get register_profession_search_cancel;

  /// No description provided for @register_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get register_region;

  /// No description provided for @register_region_title.
  ///
  /// In en, this message translates to:
  /// **'Select your region'**
  String get register_region_title;

  /// No description provided for @register_error_code_text_cant_empty.
  ///
  /// In en, this message translates to:
  /// **'Can not be empty'**
  String get register_error_code_text_cant_empty;

  /// No description provided for @register_error_code_text_short.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 6 characters'**
  String get register_error_code_text_short;

  /// No description provided for @register_error_code_username_exist.
  ///
  /// In en, this message translates to:
  /// **'The username is already exist!'**
  String get register_error_code_username_exist;

  /// No description provided for @navbar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navbar_home;

  /// No description provided for @navbar_Doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get navbar_Doctor;

  /// No description provided for @navbar_Appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get navbar_Appointment;

  /// No description provided for @navbar_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navbar_profile;

  /// No description provided for @lenth_hello.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get lenth_hello;

  /// No description provided for @lenth_likes.
  ///
  /// In en, this message translates to:
  /// **'likes'**
  String get lenth_likes;

  /// No description provided for @lenth_comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get lenth_comment;

  /// No description provided for @lenth_no_comments.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get lenth_no_comments;

  /// No description provided for @lenth_read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get lenth_read_more;

  /// No description provided for @lenth_show_less.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get lenth_show_less;

  /// No description provided for @lenth_write_comment.
  ///
  /// In en, this message translates to:
  /// **'Write your comment'**
  String get lenth_write_comment;

  /// No description provided for @lenth_publish_comment.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get lenth_publish_comment;

  /// No description provided for @lenth_year_ago.
  ///
  /// In en, this message translates to:
  /// **'a year ago'**
  String get lenth_year_ago;

  /// No description provided for @lenth_month_ago.
  ///
  /// In en, this message translates to:
  /// **'a month ago'**
  String get lenth_month_ago;

  /// No description provided for @lenth_day_ago.
  ///
  /// In en, this message translates to:
  /// **'a day ago'**
  String get lenth_day_ago;

  /// No description provided for @lenth_hour_ago.
  ///
  /// In en, this message translates to:
  /// **'an hour ago'**
  String get lenth_hour_ago;

  /// No description provided for @lenth_minute_ago.
  ///
  /// In en, this message translates to:
  /// **'a minute ago'**
  String get lenth_minute_ago;

  /// No description provided for @lenth_now_ago.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get lenth_now_ago;

  /// No description provided for @lenth_years_ago.
  ///
  /// In en, this message translates to:
  /// **'years ago'**
  String get lenth_years_ago;

  /// No description provided for @lenth_months_ago.
  ///
  /// In en, this message translates to:
  /// **'months ago'**
  String get lenth_months_ago;

  /// No description provided for @lenth_days_ago.
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get lenth_days_ago;

  /// No description provided for @lenth_hours_ago.
  ///
  /// In en, this message translates to:
  /// **'hours ago'**
  String get lenth_hours_ago;

  /// No description provided for @lenth_minutes_ago.
  ///
  /// In en, this message translates to:
  /// **'minutes ago'**
  String get lenth_minutes_ago;

  /// No description provided for @lenth_create_post.
  ///
  /// In en, this message translates to:
  /// **'Create post'**
  String get lenth_create_post;

  /// No description provided for @lenth_image_add.
  ///
  /// In en, this message translates to:
  /// **'Add an image or video'**
  String get lenth_image_add;

  /// No description provided for @lenth_post_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get lenth_post_description;

  /// No description provided for @lenth_postwrite.
  ///
  /// In en, this message translates to:
  /// **'Write something'**
  String get lenth_postwrite;

  /// No description provided for @lenth_publish_post.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get lenth_publish_post;

  /// No description provided for @search_doctor.
  ///
  /// In en, this message translates to:
  /// **'Search your specialist'**
  String get search_doctor;

  /// No description provided for @search_doctor_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get search_doctor_loading;

  /// No description provided for @search_doctor_showing.
  ///
  /// In en, this message translates to:
  /// **'Showing'**
  String get search_doctor_showing;

  /// No description provided for @search_doctor_no_result.
  ///
  /// In en, this message translates to:
  /// **'Specialist not found'**
  String get search_doctor_no_result;

  /// No description provided for @search_doctor_service_price_start.
  ///
  /// In en, this message translates to:
  /// **'Service start from'**
  String get search_doctor_service_price_start;

  /// No description provided for @search_doctor_service_book_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get search_doctor_service_book_now;

  /// No description provided for @search_category.
  ///
  /// In en, this message translates to:
  /// **'Search category'**
  String get search_category;

  /// No description provided for @search_filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get search_filter;

  /// No description provided for @search_filter_count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get search_filter_count;

  /// No description provided for @search_filter_select_category.
  ///
  /// In en, this message translates to:
  /// **'Select the category'**
  String get search_filter_select_category;

  /// No description provided for @search_filter_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get search_filter_price;

  /// No description provided for @search_filter_free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get search_filter_free;

  /// No description provided for @search_filter_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get search_filter_reset;

  /// No description provided for @search_filter_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get search_filter_apply;

  /// No description provided for @book_doctor_follow.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get book_doctor_follow;

  /// No description provided for @book_doctor_unfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get book_doctor_unfollow;

  /// No description provided for @book_doctor_book.
  ///
  /// In en, this message translates to:
  /// **'Book an appointment'**
  String get book_doctor_book;

  /// No description provided for @book_doctor_patients_patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get book_doctor_patients_patients;

  /// No description provided for @book_doctor_year_expirience.
  ///
  /// In en, this message translates to:
  /// **'Year expirience'**
  String get book_doctor_year_expirience;

  /// No description provided for @book_doctor_patients_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get book_doctor_patients_orders;

  /// No description provided for @book_doctor_patients_reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get book_doctor_patients_reviews;

  /// No description provided for @book_doctor_about_doctor.
  ///
  /// In en, this message translates to:
  /// **'About doctor'**
  String get book_doctor_about_doctor;

  /// No description provided for @book_doctor_place_work_hours.
  ///
  /// In en, this message translates to:
  /// **'Place of work and working hours'**
  String get book_doctor_place_work_hours;

  /// No description provided for @book_doctor_work_week_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get book_doctor_work_week_monday;

  /// No description provided for @book_doctor_work_week_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get book_doctor_work_week_tuesday;

  /// No description provided for @book_doctor_work_week_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get book_doctor_work_week_wednesday;

  /// No description provided for @book_doctor_work_week_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get book_doctor_work_week_thursday;

  /// No description provided for @book_doctor_work_week_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get book_doctor_work_week_friday;

  /// No description provided for @book_doctor_work_week_Saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get book_doctor_work_week_Saturday;

  /// No description provided for @book_doctor_work_week_Sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get book_doctor_work_week_Sunday;

  /// No description provided for @book_doctor_education_sertificate.
  ///
  /// In en, this message translates to:
  /// **'Education and certificate'**
  String get book_doctor_education_sertificate;

  /// No description provided for @book_doctor_reviews.
  ///
  /// In en, this message translates to:
  /// **'Rewiews'**
  String get book_doctor_reviews;

  /// No description provided for @book_doctor_reviews_read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get book_doctor_reviews_read_more;

  /// No description provided for @book_doctor_reviews_all.
  ///
  /// In en, this message translates to:
  /// **'View all '**
  String get book_doctor_reviews_all;

  /// No description provided for @book_doctor_reviews_no.
  ///
  /// In en, this message translates to:
  /// **'No have reviews'**
  String get book_doctor_reviews_no;

  /// No description provided for @book_doctor_reviews_appointment_detail.
  ///
  /// In en, this message translates to:
  /// **'Review appointment details'**
  String get book_doctor_reviews_appointment_detail;

  /// No description provided for @book_doctor_reviews_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get book_doctor_reviews_today;

  /// No description provided for @book_doctor_reviews_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get book_doctor_reviews_tomorrow;

  /// No description provided for @book_doctor_reviews_success_title.
  ///
  /// In en, this message translates to:
  /// **'Waiting doctors aprove'**
  String get book_doctor_reviews_success_title;

  /// No description provided for @book_doctor_reviews_success_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your cannot book now, select correct time and recent again'**
  String get book_doctor_reviews_success_subtitle;

  /// No description provided for @book_doctor_reviews_success_first_button.
  ///
  /// In en, this message translates to:
  /// **'Book again'**
  String get book_doctor_reviews_success_first_button;

  /// No description provided for @book_doctor_reviews_success_second_button.
  ///
  /// In en, this message translates to:
  /// **'Book another appointment'**
  String get book_doctor_reviews_success_second_button;

  /// No description provided for @book_doctor_reviews_cancel_title.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get book_doctor_reviews_cancel_title;

  /// No description provided for @book_doctor_reviews_cancel_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your cannot book now, select correct time and recent again'**
  String get book_doctor_reviews_cancel_subtitle;

  /// No description provided for @book_doctor_reviews_cancel_first_button.
  ///
  /// In en, this message translates to:
  /// **'Book again'**
  String get book_doctor_reviews_cancel_first_button;

  /// No description provided for @book_doctor_reviews_cancel_second_button.
  ///
  /// In en, this message translates to:
  /// **'Book another appointment'**
  String get book_doctor_reviews_cancel_second_button;

  /// No description provided for @select_the_map.
  ///
  /// In en, this message translates to:
  /// **'Select the map'**
  String get select_the_map;

  /// No description provided for @book_appointment_page.
  ///
  /// In en, this message translates to:
  /// **'Select service'**
  String get book_appointment_page;

  /// No description provided for @book_appointment_select.
  ///
  /// In en, this message translates to:
  /// **'Select the type of service you need'**
  String get book_appointment_select;

  /// No description provided for @book_appointment_selected.
  ///
  /// In en, this message translates to:
  /// **'services are selected'**
  String get book_appointment_selected;

  /// No description provided for @book_appointment_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get book_appointment_next;

  /// No description provided for @book_appointment_date_page.
  ///
  /// In en, this message translates to:
  /// **'Appointment date and time'**
  String get book_appointment_date_page;

  /// No description provided for @book_appointment_select_date.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get book_appointment_select_date;

  /// No description provided for @book_appointment_select_time.
  ///
  /// In en, this message translates to:
  /// **'Select aviable time'**
  String get book_appointment_select_time;

  /// No description provided for @book_appointment_select_first_come.
  ///
  /// In en, this message translates to:
  /// **'Specialist accepts on a first-come, first-served basis'**
  String get book_appointment_select_first_come;

  /// No description provided for @book_appointment_select_first_come_stats_last.
  ///
  /// In en, this message translates to:
  /// **'Today last'**
  String get book_appointment_select_first_come_stats_last;

  /// No description provided for @book_appointment_select_first_come_stats_now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get book_appointment_select_first_come_stats_now;

  /// No description provided for @book_appointment_comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get book_appointment_comment;

  /// No description provided for @book_appointment_comment_write.
  ///
  /// In en, this message translates to:
  /// **'Write comment'**
  String get book_appointment_comment_write;

  /// No description provided for @book_appointment_time_error.
  ///
  /// In en, this message translates to:
  /// **'On this time have another patient'**
  String get book_appointment_time_error;

  /// No description provided for @book_appointment_date_error.
  ///
  /// In en, this message translates to:
  /// **'Don`t work this day'**
  String get book_appointment_date_error;

  /// No description provided for @pay_appointment_page.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get pay_appointment_page;

  /// No description provided for @pay_appointment_page_title.
  ///
  /// In en, this message translates to:
  /// **'Select payment method'**
  String get pay_appointment_page_title;

  /// No description provided for @pay_appointment_payme_subscribe.
  ///
  /// In en, this message translates to:
  /// **'Pay with add card'**
  String get pay_appointment_payme_subscribe;

  /// No description provided for @pay_appointment_payme_merchant.
  ///
  /// In en, this message translates to:
  /// **'Pay in app'**
  String get pay_appointment_payme_merchant;

  /// No description provided for @pay_appointment_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get pay_appointment_cash;

  /// No description provided for @pay_appointment_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get pay_appointment_next;

  /// No description provided for @pay_appointment_bottom_sheet.
  ///
  /// In en, this message translates to:
  /// **'Select your card'**
  String get pay_appointment_bottom_sheet;

  /// No description provided for @pay_appointment_add_card.
  ///
  /// In en, this message translates to:
  /// **'Add your card'**
  String get pay_appointment_add_card;

  /// No description provided for @pay_appointment_card_number.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get pay_appointment_card_number;

  /// No description provided for @pay_appointment_card_expire.
  ///
  /// In en, this message translates to:
  /// **'Card expire'**
  String get pay_appointment_card_expire;

  /// No description provided for @pay_appointment_card_name.
  ///
  /// In en, this message translates to:
  /// **'Card name'**
  String get pay_appointment_card_name;

  /// No description provided for @pay_appointment_card_add.
  ///
  /// In en, this message translates to:
  /// **'Card add'**
  String get pay_appointment_card_add;

  /// No description provided for @pay_appointment_card_empty.
  ///
  /// In en, this message translates to:
  /// **'Can not be empty'**
  String get pay_appointment_card_empty;

  /// No description provided for @appointment_main_page.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment_main_page;

  /// No description provided for @appointment_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get appointment_upcoming;

  /// No description provided for @appointment_upcoming_title.
  ///
  /// In en, this message translates to:
  /// **'You don`t have an appointment yet'**
  String get appointment_upcoming_title;

  /// No description provided for @appointment_upcoming_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You don`t have a doctor`s appointment scheduled at the moment'**
  String get appointment_upcoming_subtitle;

  /// No description provided for @appointment_book_appointment.
  ///
  /// In en, this message translates to:
  /// **'Book appointment'**
  String get appointment_book_appointment;

  /// No description provided for @appointment_server_error.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get appointment_server_error;

  /// No description provided for @appointment_server_error_description.
  ///
  /// In en, this message translates to:
  /// **'Please reload again or enter later'**
  String get appointment_server_error_description;

  /// No description provided for @appointment_server_error_reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get appointment_server_error_reload;

  /// No description provided for @appointment_complited.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get appointment_complited;

  /// No description provided for @appointment_canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get appointment_canceled;

  /// No description provided for @appointment_detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get appointment_detail;

  /// No description provided for @appointment_appointment_list.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment_appointment_list;

  /// No description provided for @appointment_filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get appointment_filter;

  /// No description provided for @appointment_cooming_today.
  ///
  /// In en, this message translates to:
  /// **'Todat at'**
  String get appointment_cooming_today;

  /// No description provided for @appointment_cooming_at.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get appointment_cooming_at;

  /// No description provided for @appointment_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get appointment_cancel;

  /// No description provided for @appointment_reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschudule'**
  String get appointment_reschedule;

  /// No description provided for @appointment_book_again.
  ///
  /// In en, this message translates to:
  /// **'Book again'**
  String get appointment_book_again;

  /// No description provided for @appointment_view_doctor_profile.
  ///
  /// In en, this message translates to:
  /// **'View doctor profile'**
  String get appointment_view_doctor_profile;

  /// No description provided for @appointment_time_and_place.
  ///
  /// In en, this message translates to:
  /// **'Appointment time and place'**
  String get appointment_time_and_place;

  /// No description provided for @appointment_service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get appointment_service;

  /// No description provided for @appointment_get_direction.
  ///
  /// In en, this message translates to:
  /// **'Get direction'**
  String get appointment_get_direction;

  /// No description provided for @appointment_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get appointment_payment;

  /// No description provided for @appointment_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get appointment_amount;

  /// No description provided for @appointment_discount_coupons.
  ///
  /// In en, this message translates to:
  /// **'Discount & Coupons'**
  String get appointment_discount_coupons;

  /// No description provided for @appointment_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get appointment_payment_method;

  /// No description provided for @appointment_total.
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get appointment_total;

  /// No description provided for @cancel_appointment.
  ///
  /// In en, this message translates to:
  /// **'Cancel the appointment'**
  String get cancel_appointment;

  /// No description provided for @cancel_appointment_are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the appointment?'**
  String get cancel_appointment_are_you_sure;

  /// No description provided for @cancel_appointment_change_my_mind.
  ///
  /// In en, this message translates to:
  /// **'Change my mind'**
  String get cancel_appointment_change_my_mind;

  /// No description provided for @cancel_appointment_wrong_doctor.
  ///
  /// In en, this message translates to:
  /// **'Booking the wrong doctor'**
  String get cancel_appointment_wrong_doctor;

  /// No description provided for @cancel_appointment_desctiption.
  ///
  /// In en, this message translates to:
  /// **'Why are you canceling the appointment'**
  String get cancel_appointment_desctiption;

  /// No description provided for @cancel_appointment_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, I want to cancel appointment '**
  String get cancel_appointment_confirm;

  /// No description provided for @cancel_appointment_not_want.
  ///
  /// In en, this message translates to:
  /// **'No, I don`t want'**
  String get cancel_appointment_not_want;

  /// No description provided for @records_title.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records_title;

  /// No description provided for @records_seach.
  ///
  /// In en, this message translates to:
  /// **'Search offer'**
  String get records_seach;

  /// No description provided for @records_not_found.
  ///
  /// In en, this message translates to:
  /// **'No medical records'**
  String get records_not_found;

  /// No description provided for @records_not_found_description.
  ///
  /// In en, this message translates to:
  /// **'A detail health history helps typing a doctor'**
  String get records_not_found_description;

  /// No description provided for @records_new_added.
  ///
  /// In en, this message translates to:
  /// **'New added'**
  String get records_new_added;

  /// No description provided for @records_prescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get records_prescription;

  /// No description provided for @records_record.
  ///
  /// In en, this message translates to:
  /// **'Medical records'**
  String get records_record;

  /// No description provided for @records_view_doctor_profile.
  ///
  /// In en, this message translates to:
  /// **'View doctor profile'**
  String get records_view_doctor_profile;

  /// No description provided for @profile_language_uz.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get profile_language_uz;

  /// No description provided for @profile_language_ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get profile_language_ru;

  /// No description provided for @profile_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profile_language_en;

  /// No description provided for @profile_personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get profile_personal_info;

  /// No description provided for @profile_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get profile_payment;

  /// No description provided for @profile_following_doctors.
  ///
  /// In en, this message translates to:
  /// **'Following doctors'**
  String get profile_following_doctors;

  /// No description provided for @profile_following_doctors_doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get profile_following_doctors_doctor;

  /// No description provided for @profile_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_language;

  /// No description provided for @profile_choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose the application language'**
  String get profile_choose_language;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_logout;

  /// No description provided for @profile_not_activated_account.
  ///
  /// In en, this message translates to:
  /// **'Not activated account'**
  String get profile_not_activated_account;

  /// No description provided for @profile_edit_photo.
  ///
  /// In en, this message translates to:
  /// **'Edit profile photo'**
  String get profile_edit_photo;

  /// No description provided for @profile_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profile_username;

  /// No description provided for @profile_firstname.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get profile_firstname;

  /// No description provided for @profile_lastname.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get profile_lastname;

  /// No description provided for @profile_thirdname.
  ///
  /// In en, this message translates to:
  /// **'Thirdname'**
  String get profile_thirdname;

  /// No description provided for @profile_birth.
  ///
  /// In en, this message translates to:
  /// **'Date birth'**
  String get profile_birth;

  /// No description provided for @profile_select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get profile_select_date;

  /// No description provided for @profile_select_date_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profile_select_date_cancel;

  /// No description provided for @profile_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profile_gender;

  /// No description provided for @profile_profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profile_profession;

  /// No description provided for @profile_profession_select.
  ///
  /// In en, this message translates to:
  /// **'Select profession'**
  String get profile_profession_select;

  /// No description provided for @profile_profession_Profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profile_profession_Profession;

  /// No description provided for @profile_region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get profile_region;

  /// No description provided for @profile_region_select.
  ///
  /// In en, this message translates to:
  /// **'Select region'**
  String get profile_region_select;

  /// No description provided for @profile_region_Profession.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get profile_region_Profession;

  /// No description provided for @profile_change_number.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get profile_change_number;

  /// No description provided for @profile_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profile_save_changes;

  /// No description provided for @profile_following_doctors_page.
  ///
  /// In en, this message translates to:
  /// **'Following doctors'**
  String get profile_following_doctors_page;

  /// No description provided for @profile_following_doctors_search_doctor.
  ///
  /// In en, this message translates to:
  /// **'Search doctors'**
  String get profile_following_doctors_search_doctor;

  /// No description provided for @profile_language_page.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get profile_language_page;

  /// No description provided for @profile_logout_page.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get profile_logout_page;

  /// No description provided for @profile_logout_yes.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout_yes;

  /// No description provided for @profile_logout_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profile_logout_cancel;

  /// No description provided for @error_internal_server_title.
  ///
  /// In en, this message translates to:
  /// **'Internal Server Error'**
  String get error_internal_server_title;

  /// No description provided for @error_internal_server_subtitle.
  ///
  /// In en, this message translates to:
  /// **'U-rent is currently unable to handle this request. HTTP ERROR 500.'**
  String get error_internal_server_subtitle;

  /// No description provided for @error_connection_lost_title.
  ///
  /// In en, this message translates to:
  /// **'Connection Lost!'**
  String get error_connection_lost_title;

  /// No description provided for @error_connection_lost_subtitle.
  ///
  /// In en, this message translates to:
  /// **'No internet connection, check the connection to your network.'**
  String get error_connection_lost_subtitle;

  /// No description provided for @error_pagenot_found_title.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get error_pagenot_found_title;

  /// No description provided for @error_pagenot_found_subtitle.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for doesn’t exits'**
  String get error_pagenot_found_subtitle;

  /// No description provided for @error_try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get error_try_again;

  /// No description provided for @error_return_tohome.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get error_return_tohome;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
    case 'uz': return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
