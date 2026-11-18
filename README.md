# mmj-finale-game
Game repository for **Metroidvania Month Jam**.

---

## Coding Conventions & Naming Rules

To avoid conflicts with built-in engine variables/functions and make collaborative coding seamless, our codebase follows a modified **`snake_case`** convention (all lowercase letters separated by underscores `_`). 

Using strict prefixes allows anyone on the team to immediately identify a variable's scope, type, or purpose without checking its definition.

### Quick Reference

| Element Type | Convention | Example |
| :--- | :--- | :--- |
| **Member Variables** | `_snake_case` (leading underscore) | `_player_health` |
| **Functions** | `_snake_case()` (leading underscore) | `_take_damage()` |
| **Function Parameters** | `_snake_case` (leading underscore) | `func _take_damage(_amount):` |
| **Local Variables** | `snake_case` (no leading underscore) | `new_direction` |
| **Constants & Enums** | `_UPPER_SNAKE_CASE` | `_PLAYER_MAX_HEALTH`, `_CURRENT_STATE` |
| **Boolean Variables** | `_is_` prefix | `_is_player_dead` |
| **Boolean Functions** | Question prefix (`_is_`, `_can_`, etc.) | `_can_player_transform()`, `_is_in_water()` |
| **Signals** | `_on_` + exact signal name | `_on_start_game`, `_on_player_die` |

---

### Detailed Guidelines

#### 1. Scope & Parameters (Leading Underscore)
* **Script-level Variables & Functions:** Always start with a single underscore (`_`) to distinguish custom code from built-in engine properties.
* **Parameters:** Always start with `_` (e.g., `_amount`). In engines like Godot, this prevents unnecessary compiler warnings when a parameter isn't used inside the function body.
* **Local Variables:** Variables declared inside a function do **not** use a leading underscore, keeping standard `snake_case`.

```gdscript
func _run(_delta):
	var new_direction = _get_input_direction()
	_move(new_direction)
