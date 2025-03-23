export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:get_it/get_it.dart';
export 'package:mpd_client/app/app_routes.dart';
export 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';
export 'package:mpd_client/features/authentication/domain/blocs/auth/auth_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/sub_profession/sub_professions_bloc.dart';
export 'package:mpd_client/features/authentication/presentation/pages/auth/auth_page.dart';
export 'package:mpd_client/features/authentication/presentation/pages/privacy/privacy_page.dart';
export 'package:mpd_client/features/authentication/presentation/pages/register_detail/register_detail_page.dart';
export 'package:mpd_client/features/introduction/domain/inhereted/inherited_notifier.dart';
export 'package:mpd_client/features/introduction/presentation/language/language_page.dart';
export 'package:mpd_client/features/introduction/presentation/splash/splash_page.dart';
export 'package:mpd_client/features/introduction/presentation/tutorial/tutorial_page.dart';
export 'package:mpd_client/features/user/presentation/pages/help_center/help_center.dart';
export 'package:mpd_client/features/user/presentation/pages/user_following/user_following.dart';
export 'package:mpd_client/features/user/presentation/pages/user_info/user_info_page.dart';
export 'package:mpd_client/features/home/presentation/pages/notification/notification_page.dart';
export 'package:mpd_client/features/user/presentation/pages/user_payment/user_payment.dart';

export 'package:mpd_client/src/appointment_info/appointment_info_model.dart';

export 'package:mpd_client/core/locator.dart';
export 'package:mpd_client/features/authentication/domain/blocs/change_password/change_password_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/passport/passport_bloc.dart';
export 'package:mpd_client/features/yandex_doctor/data/models/top_specialists_model.dart';
export 'package:mpd_client/features/home/data/repositories/home_repository.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_payment/appoinment_payment.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_date_time/appoinment_date_time.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/pages/review_appoinment/review_appoinment.dart';
export 'package:mpd_client/features/user/presentation/pages/records/record.dart';
export 'package:mpd_client/features/user/presentation/pages/records/records_page.dart';

export 'package:mpd_client/features/appointment/data/repositories/appoinment_repository.dart';
export 'package:mpd_client/features/appointment/domain/blocs/appointment/appoinment_bloc.dart';
export 'package:mpd_client/features/appointment/presentation/pages/book_appoinment/book_appoinment.dart';

export 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';

export 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';
export 'package:mpd_client/features/doctor_profile_booking/domain/blocs/subscripption/subscription_bloc.dart';
export 'package:mpd_client/features/doctor_profile_booking/domain/blocs/timetable_bloc/timetable_bloc.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/pages/dr_profile_byid.dart';

export 'package:mpd_client/features/user/data/repositories/user_repository.dart';
export 'package:mpd_client/features/user/domain/blocs/user_records/records_bloc.dart';
export 'package:mpd_client/features/user/domain/blocs/user_subscriptions/user_subscriptions_bloc.dart';

export 'package:mpd_client/features/appointment/data/models/appointment_arg_model.dart';
export 'package:mpd_client/features/appointment/domain/blocs/canceled_appointment/canceled_appointment_bloc.dart';
export 'package:mpd_client/features/appointment/domain/blocs/completed_appointment/completed_appointment_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/bloc/profession_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/check_username/check_username_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/district/district_bloc.dart';
export 'package:mpd_client/features/authentication/domain/blocs/region/region_bloc.dart';
export 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
export 'package:mpd_client/features/doctor_profile_booking/data/models/pdf_viewer_model.dart';
export 'package:mpd_client/features/doctor_profile_booking/domain/blocs/create_order/create_order_bloc.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/widgets/pdf_viewer_widget.dart';
export 'package:mpd_client/features/home/domain/blocs/advertisement_bloc/adverticement_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/banner/banner_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/create_post/create_post_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/like_unlike/like_unlike_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/media_control/media_control_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/post_coment/post_coment_bloc.dart';
export 'package:mpd_client/features/home/domain/blocs/send_coment/send_coment_bloc.dart';
export 'package:mpd_client/features/home/presentation/pages/coment_sheet/coment_page.dart';
export 'package:mpd_client/features/home/presentation/pages/create_post/create_post_page.dart';
export 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/services_page.dart';
export 'package:mpd_client/features/user/data/models/specialist_info_model.dart';
export 'package:mpd_client/features/user/data/models/user_records_model.dart';
export 'package:mpd_client/features/user/domain/blocs/user_info/user_info_bloc.dart';
export 'package:mpd_client/features/yandex_doctor/data/repositories/yandex_doctor_repository.dart';

export '../features/appointment/domain/blocs/cancel_appointment/cancel_appointment_bloc.dart';
export '../features/doctor_profile_booking/domain/blocs/my_cards_bloc/my_cards_bloc.dart';
export '../features/home/domain/blocs/post/post_bloc.dart';
export '../features/yandex_doctor/domain/blocs/search_by_specialist/search_by_specialist_bloc.dart';
export '../features/yandex_doctor/domain/blocs/yandex_doctor/yandex_doctor_bloc.dart';
export '../features/yandex_doctor/domain/services/yandex_service.dart';
export '../features/yandex_doctor/presentation/doctor_page.dart';
export '../features/main_page.dart';
