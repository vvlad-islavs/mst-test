import 'package:flutter/cupertino.dart';

import 'package:test_task/core/core.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.onTap});

  final ServiceEntity service;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6.resolveFrom(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.title, style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                  const SizedBox(height: 6),
                  Text(
                    service.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CupertinoTheme.of(
                      context,
                    ).textTheme.textStyle.copyWith(color: CupertinoColors.systemGrey.resolveFrom(context)),
                  ),

                  SizedBox(height: 12),
                  Text(
                    service.hasSubscribe ? 'Осталось дней подписки: ${service.subscribeDays}' : 'Подписка не активна',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                      color: service.hasSubscribe
                          ? CupertinoColors.systemCyan.resolveFrom(context)
                          : CupertinoColors.systemOrange.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) const Icon(CupertinoIcons.chevron_forward, size: 22),
          ],
        ),
      ),
    );
  }
}
