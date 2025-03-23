import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/extension/context_ext.dart';

import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_loading.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_pinned_sheet.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/service_success.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/appbar_widget.dart';
import 'package:mpd_client/src/widgets/error_type_widget.dart';

class ServicesPage extends StatefulWidget {
  final int specialistId;
  const ServicesPage({super.key, required this.specialistId});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  void initState() {
    context
        .read<ProductSpecalistBloc>()
        .add(GetProductSpecalistEvent(specialistId: widget.specialistId));
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
                context.read<ProductSpecalistBloc>().add(
                    GetProductSpecalistEvent(
                        specialistId: widget.specialistId, isMore: true));
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
                  context.read<ProductSpecalistBloc>().add(
                      GetProductSpecalistEvent(
                          specialistId: widget.specialistId));
                },
              ),
            );
          }
          return Center(
            child: ErrorTypeWidget(
              tryAgainPressed: () {
                context.read<ProductSpecalistBloc>().add(
                    GetProductSpecalistEvent(
                        specialistId: widget.specialistId));
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
