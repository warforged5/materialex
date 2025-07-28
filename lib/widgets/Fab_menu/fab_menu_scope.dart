import "package:flutter/material.dart";

abstract class FloatingActionButtonMenuScope {
  AlignmentDirectional get horizontalAlignment;
}

abstract class ToggleFloatingActionButtonScope {
  double get checkedProgress;
}

// Implementation classes
class FloatingActionButtonMenuScopeImpl implements FloatingActionButtonMenuScope {
  @override
  final AlignmentDirectional horizontalAlignment;
  
  const FloatingActionButtonMenuScopeImpl(this.horizontalAlignment);
}

class ToggleFloatingActionButtonScopeImpl implements ToggleFloatingActionButtonScope {
  @override
  final double checkedProgress;
  
  const ToggleFloatingActionButtonScopeImpl(this.checkedProgress);
}
