import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_task/core/core.dart';
import 'package:test_task/features/general/presentation/view_models/view_models.dart';
import 'package:test_task/features/general/presentation/widgets/widgets.dart';
import 'package:test_task/app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  late final GeneralViewModel _vm;
  StreamSubscription? _errorSub;

  @override
  void initState() {
    super.initState();
    _vm = getIt<GeneralViewModel>();
   _errorSub =  _vm.errorStream.listen(_onError);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAllServices();
    });
  }

  Future<void> _onTapService(ServiceEntity service) async {
    final updated = await context.router.push<ServiceEntity>(
      PayloadRoute(
        serviceId: service.id,
        title: service.title,
        subtitle: service.subtitle,
      ),
    );

    if (updated != null) {
      _vm.upsertService(updated);
    }
  }

  void _onError(String message) async {
    if (!mounted) return;
    await DialogManager.showErrorDialog(context, message: message);
  }

  @override
  void dispose() {
    _errorSub?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> _vm.getAllServices(),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Подписки'),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _vm,
            builder: (context, _) {
              if (_vm.isLoading && _vm.services.isEmpty) {
                return const Center(child: CupertinoActivityIndicator());
              }
      
              if (_vm.errorMessage != null && _vm.services.isEmpty) {
                return  Center(
                  child: CupertinoButton.filled(
                      onPressed: ()=> _vm.getAllServices(),
                      child: Text('Обновить страницу'),
                  ),
                );
              }
      
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                children: _vm.services
                    .map(
                      (service) => ServiceCard(
                        service: service,
                        onTap: service.hasSubscribe? null: () => _onTapService(service),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

