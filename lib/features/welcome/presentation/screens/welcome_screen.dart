import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:test_task/core/core.dart';
import 'package:test_task/features/welcome/presentation/view_models/view_models.dart';
import 'package:test_task/app/router/app_router.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final WelcomeViewModel _vm;
  late final AnimationController _textController;
  bool _navigated = false;
  Timer? _timer;
  static const int _lifeTimeS = 5;

  @override
  void initState() {
    super.initState();
    _vm = getIt<WelcomeViewModel>();

    _textController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    unawaited(_init());
  }

  Future<void> _init() async {
    await _vm.load();
    if (!mounted) return;

    if (!_vm.isFirstStart) {
      _navigateToGeneral();
      return;
    }

    _textController.forward();
    _timer = Timer(const Duration(seconds: _lifeTimeS), () async {
      await _vm.markFirstStartDone();
      if (!mounted) return;
      _navigateToGeneral();
    });
  }

  void _navigateToGeneral() {
    if (_navigated) return;
    _navigated = true;
    context.router.replace(const GeneralRoute());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fade1 = CurvedAnimation(parent: _textController, curve: const Interval(0.0, 0.7));
    final fade2 = CurvedAnimation(parent: _textController, curve: const Interval(0.3, 1.0));

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: fade1.value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - fade1.value) * 16),
                        child: Text(
                          'Все ваши подписки в одном месте',
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(
                            context,
                          ).textTheme.navTitleTextStyle.copyWith(fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 18),
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: fade2.value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - fade2.value) * 16),
                        child: Text(
                          'Здесь вы можете отслеживать все ваши подписки и информацию о них',
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey.resolveFrom(context),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 26),
                if (_vm.isLoading) const CupertinoActivityIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
