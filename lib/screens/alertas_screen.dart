import 'package:flutter/material.dart';

class AlertasScreen extends StatefulWidget {
  const AlertasScreen({super.key});

  @override
  State<AlertasScreen> createState() => _AlertasScreenState();
}

class _AlertasScreenState extends State<AlertasScreen> {
  final Map<int, bool> _expandedAlerts = {};

  List<AlertItem> alerts = [
    AlertItem(
      id: 1,
      title: 'Depósito 95% lleno',
      subtitle: 'Contenedor de Plástico',
      priority: 'Retiro Urgente',
      isUrgent: true,
      details: 'Detalles adicionales sobre el alerta de plástico.',
    ),
    AlertItem(
      id: 2,
      title: 'Depósito 90% lleno',
      subtitle: 'Contenedor de Vidrio',
      priority: 'Alto',
      isUrgent: false,
      details: 'Detalles adicionales sobre el alerta de vidrio.',
    ),
    AlertItem(
      id: 3,
      title: 'Depósito 85% lleno',
      subtitle: 'Contenedor de Papel',
      priority: 'Medio',
      isUrgent: false,
      details: 'Detalles adicionales sobre el alerta de papel.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF10B981);
    final dangerColor = const Color(0xFFDC2626);
    final surfaceColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textPrimary = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
    final textSecondary = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: surfaceColor.withAlpha((0.9 * 255).round()),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: textPrimary),
        ),
        title: Text(
          'Alertas',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.05 * 255).round()),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Resumen de Alertas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward, size: 16, color: textSecondary),
                      label: Text(
                        'Ver todo',
                        style: TextStyle(color: textSecondary, fontSize: 14),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            'Urgente',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '3',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            'Alto',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            'Medio',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Lista de alertas
          ...alerts.map((alert) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AlertCard(
                  alert: alert,
                  isExpanded: _expandedAlerts[alert.id] ?? false,
                  onToggle: () {
                    setState(() {
                      _expandedAlerts[alert.id] = !(_expandedAlerts[alert.id] ?? false);
                    });
                  },
                  onDelete: () {
                    setState(() {
                      alerts.removeWhere((a) => a.id == alert.id);
                    });
                  },
                  surfaceColor: surfaceColor,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  primaryColor: primaryColor,
                  dangerColor: dangerColor,
                ),
              )),
        ],
      ),
    );
  }
}

class AlertItem {
  final int id;
  final String title;
  final String subtitle;
  final String priority;
  final bool isUrgent;
  final String details;

  AlertItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.isUrgent,
    required this.details,
  });
}

class AlertCard extends StatelessWidget {
  final AlertItem alert;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;
  final Color surfaceColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color primaryColor;
  final Color dangerColor;

  const AlertCard({
    super.key,
    required this.alert,
    required this.isExpanded,
    required this.onToggle,
    this.onDelete,
    required this.surfaceColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.primaryColor,
    required this.dangerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: alert.isUrgent ? Border(left: BorderSide(color: dangerColor, width: 4)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.03 * 255).round()),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (!alert.isUrgent)
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha((0.1 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: textPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  if (!alert.isUrgent) const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.title,
                          style: TextStyle(
                            fontSize: alert.isUrgent ? 18 : 16,
                            fontWeight: alert.isUrgent ? FontWeight.bold : FontWeight.w600,
                            color: alert.isUrgent ? dangerColor : textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alert.subtitle,
                          style: TextStyle(
                            fontSize: alert.isUrgent ? 16 : 14,
                            fontWeight: alert.isUrgent ? FontWeight.w500 : FontWeight.normal,
                            color: alert.isUrgent ? textPrimary : textSecondary,
                          ),
                        ),
                        if (alert.isUrgent) ...[
                          const SizedBox(height: 4),
                          Text(
                            alert.priority,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.arrow_forward,
                      color: textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text(
                      alert.details,
                      style: TextStyle(
                        fontSize: 14,
                        color: textPrimary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
