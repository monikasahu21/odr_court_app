import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ReportsAnalyticsScreen extends StatelessWidget {
  const ReportsAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Reports & Analytics",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("👥 Users by Role", theme),
            const SizedBox(height: 200, child: _UserRolePieChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("⚖️ Cases by Status", theme),
            const SizedBox(height: 200, child: _CaseStatusBarChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("📄 Documents Status", theme),
            const SizedBox(height: 200, child: _DocumentStatusPieChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("📊 Monthly Activity Trend", theme),
            const SizedBox(height: 220, child: _ActivityLineChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

//
// 🔹 Pie Chart: Users by Role
//
class _UserRolePieChart extends StatelessWidget {
  const _UserRolePieChart();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: 40,
            title: "Claimant",
            color: AppColors.primary,
            radius: 50,
            titleStyle: _chartTitleStyle,
          ),
          PieChartSectionData(
            value: 25,
            title: "Respondent",
            color: AppColors.accentOrange,
            radius: 50,
            titleStyle: _chartTitleStyle,
          ),
          PieChartSectionData(
            value: 20,
            title: "Neutral",
            color: Colors.green,
            radius: 50,
            titleStyle: _chartTitleStyle,
          ),
          PieChartSectionData(
            value: 15,
            title: "Admin",
            color: Colors.purple,
            radius: 50,
            titleStyle: _chartTitleStyle,
          ),
        ],
      ),
    );
  }

  static const TextStyle _chartTitleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
}

//
// 🔹 Bar Chart: Cases by Status
//
class _CaseStatusBarChart extends StatelessWidget {
  const _CaseStatusBarChart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return _bottomTitle("Open");
                  case 1:
                    return _bottomTitle("In Progress");
                  case 2:
                    return _bottomTitle("Resolved");
                  case 3:
                    return _bottomTitle("Closed");
                }
                return const Text("");
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 10, color: AppColors.accentOrange)
          ]),
          BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 6, color: AppColors.primary)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 8, color: Colors.green)]),
          BarChartGroupData(
              x: 3, barRods: [BarChartRodData(toY: 4, color: Colors.red)]),
        ],
      ),
    );
  }

  static Widget _bottomTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

//
// 🔹 Pie Chart: Documents Status
//
class _DocumentStatusPieChart extends StatelessWidget {
  const _DocumentStatusPieChart();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: 12,
            title: "Pending",
            color: AppColors.accentOrange,
            radius: 50,
            titleStyle: _UserRolePieChart._chartTitleStyle,
          ),
          PieChartSectionData(
            value: 20,
            title: "Approved",
            color: Colors.green,
            radius: 50,
            titleStyle: _UserRolePieChart._chartTitleStyle,
          ),
          PieChartSectionData(
            value: 5,
            title: "Rejected",
            color: Colors.red,
            radius: 50,
            titleStyle: _UserRolePieChart._chartTitleStyle,
          ),
        ],
      ),
    );
  }
}

//
// 🔹 Line Chart: Monthly Activity
//
class _ActivityLineChart extends StatelessWidget {
  const _ActivityLineChart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return _bottomTitle("Jan");
                  case 1:
                    return _bottomTitle("Feb");
                  case 2:
                    return _bottomTitle("Mar");
                  case 3:
                    return _bottomTitle("Apr");
                  case 4:
                    return _bottomTitle("May");
                }
                return const Text("");
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              reservedSize: 30,
            ),
          ),
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 2),
              FlSpot(3, 5),
              FlSpot(4, 3.5),
            ],
            dotData: FlDotData(show: true),
            color: AppColors.primary,
            barWidth: 3,
          ),
        ],
      ),
    );
  }

  static Widget _bottomTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
