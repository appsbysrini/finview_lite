import 'package:flutter/material.dart';

import '../models/user_portfolio.dart';
import '../utils/layout_constants.dart';
import 'allocation_chart.dart';
import 'holdings_list.dart';

/// Mobile dashboard sections stacked in a single column.
class DashboardMobileBody extends StatelessWidget {
  /// Creates a single-column dashboard body.
  const DashboardMobileBody({
    super.key,
    required this.portfolio,
  });

  /// Loaded portfolio used by the holdings section.
  final UserPortfolio portfolio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AllocationChart(),
        const SizedBox(height: LayoutConstants.sectionSpacing),
        HoldingsList(holdings: portfolio.holdings),
      ],
    );
  }
}

/// Tablet and web dashboard with chart and holdings side by side.
class DashboardTabletBody extends StatelessWidget {
  /// Creates a two-column dashboard body.
  const DashboardTabletBody({
    super.key,
    required this.portfolio,
  });

  /// Loaded portfolio used by the holdings section.
  final UserPortfolio portfolio;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: AllocationChart(),
        ),
        const SizedBox(width: LayoutConstants.columnSpacing),
        Expanded(
          child: HoldingsList(holdings: portfolio.holdings),
        ),
      ],
    );
  }
}

/// Picks mobile or tablet dashboard layout based on available width.
class DashboardBody extends StatelessWidget {
  /// Creates a responsive dashboard body for [portfolio].
  const DashboardBody({
    super.key,
    required this.portfolio,
  });

  /// Loaded portfolio shown on the dashboard.
  final UserPortfolio portfolio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= LayoutConstants.tabletBreakpoint) {
          return DashboardTabletBody(portfolio: portfolio);
        }

        return DashboardMobileBody(portfolio: portfolio);
      },
    );
  }
}
