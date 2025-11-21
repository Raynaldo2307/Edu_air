import 'package:flutter/material.dart';

import 'package:edu_air/src/core/app_theme.dart';

class InfoCardsRow extends StatelessWidget {
  const InfoCardsRow({super.key, required this.cards});

  final List<InfoCardData> cards;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = (screenHeight * 0.22).clamp(150.0, 190.0).toDouble();

    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final card = cards[index];
          return _InfoCard(card: card);
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.card});

  final InfoCardData card;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 240,
        height: 160, // fixed height to avoid overflow
        decoration: BoxDecoration(
          color: card.backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textPrimary.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),
                  if (card.ctaLabel != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Flexible(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 32),
                          child: ElevatedButton(
                            onPressed: card.onTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              minimumSize: const Size(0, 32),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(card.ctaLabel!),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 100,
                width: 90,
                child: card.imageUrl != null
                    ? Image.network(
                        card.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _FallbackImage(color: card.backgroundColor),
                      )
                    : _FallbackImage(color: card.backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FallbackImage extends StatelessWidget {
  const _FallbackImage({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.35),
      child: const Icon(Icons.image, color: AppTheme.textPrimary),
    );
  }
}

class InfoCardData {
  const InfoCardData({
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.ctaLabel,
    this.onTap,
    this.backgroundColor = const Color(0xFFFDECEF),
  });

  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? ctaLabel;
  final VoidCallback? onTap;
  final Color backgroundColor;
}
