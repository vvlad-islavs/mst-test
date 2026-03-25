import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_task/core/core.dart';
import 'package:test_task/features/payload/presentation/view_models/view_models.dart';

@RoutePage()
class PayloadScreen extends StatefulWidget {
  const PayloadScreen({super.key, required this.serviceId, required this.title, required this.subtitle});

  final int serviceId;
  final String title;
  final String subtitle;

  @override
  State<PayloadScreen> createState() => _PayloadScreenState();
}

class _PayloadScreenState extends State<PayloadScreen> with SingleTickerProviderStateMixin {
  late final PayloadViewModel _vm;
  late final AnimationController _gradientController;
  StreamSubscription? _errorSub;


  @override
  void initState() {
    super.initState();
    _vm = PayloadViewModel(repository: getIt<ServicesRepository>());
    _errorSub =_vm.errorStream.listen(_onError);

    _gradientController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _errorSub?.cancel();
    super.dispose();
  }

  Future<void> _buy(int days) async {
    final updated = await _vm.buyService(id: widget.serviceId, days: days);

    if (updated == null) return;

    if (!mounted) return;
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Покупка успешна'),
        content: Text('${widget.title} активирована на ${days == 30 ? "30 дней" : "год"}'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    context.router.pop(updated);
  }

  Future<void> _onError(String message) async {
    if (!mounted) return;
    await DialogManager.showErrorDialog(context, message: message);
  }


  @override
  Widget build(BuildContext context) {
    final activeBegin = Tween<Alignment>(
      begin: const Alignment(-1, -1),
      end: const Alignment(1, 1),
    ).transform(_gradientController.value);

    final activeEnd = Tween<Alignment>(
      begin: const Alignment(1, -1),
      end: const Alignment(-1, 1),
    ).transform(_gradientController.value);

    return Stack(
      children: [
        CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Оплата')),
          child: AnimatedBuilder(
            animation: _gradientController,
            builder: (context, _) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: activeBegin,
                            end: activeEnd,
                            colors: [
                              CupertinoColors.activeBlue.withValues(alpha: 0.35),
                              const Color(0xFF7C4DFF).withValues(alpha: 0.25),
                              CupertinoColors.systemPink.withValues(alpha: 0.25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _vm,
                      builder: (context, _) => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.title,
                                      textAlign: TextAlign.center,
                                      style: CupertinoTheme.of(
                                        context,
                                      ).textTheme.navTitleTextStyle.copyWith(fontSize: 28),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.subtitle,
                                      textAlign: TextAlign.center,
                                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                        fontSize: 16,
                                        color: CupertinoColors.systemGrey.resolveFrom(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: CupertinoButton.filled(
                                    onPressed: _vm.isLoading ? null : () => _buy(365),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Год - ',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: '11 999',
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                              decoration: TextDecoration.lineThrough,
                                              color: Colors.white.withValues(alpha: 0.7),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '   9 999 руб.',
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                              color: Colors.white.withValues(alpha: 0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: CupertinoButton(
                                    onPressed: _vm.isLoading ? null : () => _buy(30),
                                    child: RichText(
                                      text: TextSpan(
                                        text: '30 дней - ',
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          color: CupertinoColors.systemBlue.resolveFrom(context),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '999 руб.',
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                              color: Colors.black.withValues(alpha: 0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _vm,
            builder: (context, _) {
              if (_vm.isLoading) {
                return Container(
                  color: CupertinoColors.black.withValues(alpha: 0.15),
                  child: const Center(child: CupertinoActivityIndicator()),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
