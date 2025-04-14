# Pause Menu Module

**Reusable pausing system with input integration and scene transitions**

## Dependencies
- Requires [`InputHandler.gd`](InputHandler.md) autoload module
- Godot 4.0+

## Features
- Integrated with InputHandler system
- Custom default theme included (`default_pause_theme.tres`)
- Configurable scene transitions (windowed/full-screen)
- Automatic pause action registration
- Signal-driven architecture

## Installation
1. Add these files to your project:
   - `PauseMenu.tscn`
   - `PauseMenu.gd`
   - `default_pause_theme.tres`
2. Set up required dependencies:
   - Ensure `InputHandler.gd` is configured as an autoload
3. Add the PauseMenu scene to your main game scene tree

## Input Integration
The pause menu automatically registers these inputs through the InputHandler:
```gdscript
# Default pause toggle: Escape key
InputHandler.register_action("pause_menu_toggle", [InputEventKey.new(KEY_ESCAPE)])
