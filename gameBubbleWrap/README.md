# Bubble Wrap Game

A simple, satisfying bubble wrap popping game designed for toddlers and young children.

## Features

- **Grid Layout**: 8x6 grid of colorful bubbles arranged on screen
- **Multitouch Support**: Multiple bubbles can be popped simultaneously
- **Visual Feedback**: Bubbles scale up then fade out with spectacular particle burst effects
- **Audio Feedback**: Each pop plays a sound with random pitch variation
- **Auto-Reset**: Grid automatically regenerates with celebration when all bubbles are popped
- **Colorful Design**: Randomly colored bubbles (red, blue, green, yellow, purple, orange)

## Gameplay

- Touch or click any bubble to pop it
- Bubbles will scale up briefly then disappear with satisfying animations and particle bursts
- Each pop plays a sound effect
- When all bubbles are popped, you'll hear a celebration sound and a new grid appears after 1.5 seconds
- Perfect for stress relief and satisfying tactile feedback

## Technical Details

### Architecture
- **Controller**: Handles multitouch input and coordinates with grid spawner
- **Grid Spawner**: Manages bubble creation, positioning, and tracking
- **Bubble Script**: Individual bubble behavior, animations, and sound effects
- **Particle Spawner**: Creates spectacular particle burst effects at bubble locations
- **Factory Pattern**: Efficient creation and destruction of bubble and particle instances

### Configuration (in bubbleGridSpawner.script)
- `grid_width`: Number of bubbles per row (default: 8)
- `grid_height`: Number of rows (default: 6) 
- `bubble_size`: Bubble diameter in pixels (default: 80)
- `bubble_spacing`: Space between bubbles (default: 10)

### Assets Used
- Bubble sprite from `/assets/game_bubbles/bubble.png`
- Pop sound from `/sounds/pop.ogg`
- Particle effects from `/particles/bubblePop.particlefx` (4 different emitters!)

## Testing

To test this game:
1. Open the project in Defold Editor
2. The game.project is currently set to launch this game
3. Press `Ctrl+B` to build and run
4. Click or touch bubbles to pop them
5. Test multitouch by touching multiple bubbles simultaneously

## Integration

To integrate this as a selectable minigame:
1. Revert `game.project` main_collection back to main game launcher
2. Add bubble wrap game as an option in the main game menu
3. Load `/gameBubbleWrap/gameBubbleWrap.collection` when selected
