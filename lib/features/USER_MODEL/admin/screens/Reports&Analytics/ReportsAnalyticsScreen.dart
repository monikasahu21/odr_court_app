import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ReportsAnalyticsScreen extends StatelessWidget {
  const ReportsAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Users by Role"),
            const SizedBox(height: 200, child: _UserRolePieChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("Cases by Status"),
            const SizedBox(height: 200, child: _CaseStatusBarChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("Documents Status"),
            const SizedBox(height: 200, child: _DocumentStatusPieChart()),
            const SizedBox(height: 20),
            _buildSectionTitle("Monthly Activity Trend"),
            const SizedBox(height: 220, child: _ActivityLineChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
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
              value: 40, title: "Claimant", color: Colors.blue, radius: 50),
          PieChartSectionData(
              value: 25, title: "Respondent", color: Colors.orange, radius: 50),
          PieChartSectionData(
              value: 20, title: "Neutral", color: Colors.green, radius: 50),
          PieChartSectionData(
              value: 15, title: "Admin", color: Colors.purple, radius: 50),
        ],
      ),
    );
  }
}

//
// 🔹 Bar Chart: Cases by Status
//
class _CaseStatusBarChart extends StatelessWidget {
  const _CaseStatusBarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text("Open");
                  case 1:
                    return const Text("In Progress");
                  case 2:
                    return const Text("Resolved");
                  case 3:
                    return const Text("Closed");
                }
                return const Text("");
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 10, color: Colors.orange),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 6, color: Colors.blue),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 8, color: Colors.green),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 4, color: Colors.red),
          ]),
        ],
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
              value: 12, title: "Pending", color: Colors.orange, radius: 50),
          PieChartSectionData(
              value: 20, title: "Approved", color: Colors.green, radius: 50),
          PieChartSectionData(
              value: 5, title: "Rejected", color: Colors.red, radius: 50),
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
                    return const Text("Jan");
                  case 1:
                    return const Text("Feb");
                  case 2:
                    return const Text("Mar");
                  case 3:
                    return const Text("Apr");
                  case 4:
                    return const Text("May");
                }
                return const Text("");
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
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
}
