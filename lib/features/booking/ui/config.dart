// Table colors
import 'package:flutter/widgets.dart';

const tableConfig = TableConfig();

class TableConfig {
  final TableSize ui;
  final TableColors colors;

  const TableConfig({
    this.ui = const TableSize(),
    this.colors = const TableColors(),
  });
}

class TableSize {
  final double width;
  final double separatorWidth;
  final double height;
  final double margin;

  const TableSize({
    this.width = 60,
    this.separatorWidth = 20,
    this.height = 60,
    this.margin = 6,
  });
}

class TableColors {
  final Color available;
  final Color booked;
  final Color unavailable;
  final Color conflict;

  const TableColors({
    this.available = const Color(0xFF6FB2D2),
    this.booked = const Color(0xFF85C88A),
    this.unavailable = const Color(0xFFEEEEEE),
    this.conflict = const Color(0xFFEBD671),
  });
}
