import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/services/components/service_loading.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/services/components/service_pinned_sheet.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/services/components/service_success.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/pages/services/components/w_error_type.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class ServicesPage extends StatefulWidget {
  final int specialistId;
  const ServicesPage({super.key, required this.specialistId});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  void initState() {
    context.read<ProductSpecalistBloc>().add(GetProductSpecalistEvent(specialistId: widget.specialistId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ServicePinnedSheet(specialistId: widget.specialistId),
      appBar: AppBarWidget(title: context.l10n.book_appointment_page),
      body: BlocBuilder<ProductSpecalistBloc, ProductSpecalistState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            return ServiceSuccess(
              specialistProducts: state.specialistProducts,
              hasMoreToFetch: state.count > state.specialistProducts.length,
              fetchMoreFunction: () {
                context.read<ProductSpecalistBloc>().add(GetProductSpecalistEvent(specialistId: widget.specialistId, isMore: true));
              },
              paginatorStatus: state.status,
              localProducts: state.localProducts,
            );
          } else if (state.status.isInProgress) {
            return const ServiceLoading();
          } else if (state.status.isFailure) {
            return Center(
              child: ErrorTypeWidget(
                errorIcon: AppIcons.serverError,
                errorSubtitle: context.l10n.error_internal_server_subtitle,
                errorTitle: context.l10n.error_internal_server_title,
                hasReturnButton: false,
                tryAgainPressed: () {
                  context.read<ProductSpecalistBloc>().add(GetProductSpecalistEvent(specialistId: widget.specialistId));
                },
              ),
            );
          }
          return Center(
            child: ErrorTypeWidget(
              tryAgainPressed: () {
                context.read<ProductSpecalistBloc>().add(GetProductSpecalistEvent(specialistId: widget.specialistId));
              },
              hasReturnButton: false,
              errorIcon: AppIcons.connectionLostError,
              errorSubtitle: context.l10n.error_connection_lost_subtitle,
              errorTitle: context.l10n.error_connection_lost_title,
            ),
          );
        },
      ),
    );
  }
}
