# Game Selector

A beautiful, touch-friendly game selection screen for Sophie's Worlds.

## Features

- **Horizontal Scrollable List**: Smooth gesture-based scrolling through available games
- **Momentum Physics**: Natural scrolling with momentum and bouncing at edges
- **Large Portrait Buttons**: Big, colorful game cards perfect for toddler fingers
- **Touch Animations**: Visual feedback with scaling animations on button press
- **Game Descriptions**: Each game has a title and brief description

## Games Available

1. **Bubble Pop** (Light Blue) - Pop floating bubbles in the ocean
2. **Bubble Wrap** (Pink) - Pop all the bubbles in the grid  
3. **Xylophone** (Gold) - Make beautiful music

## Technical Architecture

### Controller (`controller.script`)
- Handles touch input for scrolling
- Manages scroll physics with momentum and bouncing
- Communicates scroll position to GUI
- Processes game launch requests

### GUI (`gameSelector.gui_script`)
- Creates and positions game buttons dynamically
- Updates button positions based on scroll
- Handles button tap detection and animations
- Sends game launch messages to controller

### Scroll Physics
- **Momentum**: Flick gestures continue scrolling after release
- **Elastic Bouncing**: Smooth bounce-back at list edges (50px overshroll)
- **Damping**: Natural deceleration (92% per frame)
- **Edge Snapping**: Automatic return to bounds when stopped

### Button Layout
- **Size**: 250x350px portrait rectangles
- **Spacing**: 30px between buttons
- **Colors**: Each game has unique bright color
- **Typography**: Large title (1.2x scale) + smaller description (0.7x scale)
- **Effects**: Subtle shadow and press animations

## Integration

The game selector is set as the main collection in `game.project`. When a game button is tapped, it currently logs the selection. For full integration, implement collection proxy loading to dynamically switch between games.

## Usage

- **Scroll**: Drag horizontally to browse games
- **Select**: Tap any game button to select (currently logs selection)
- **Bounce**: Scroll past the edges to see elastic bounce effect
- **Momentum**: Quick flicks create momentum scrolling

Perfect for toddlers with large touch targets, smooth animations, and satisfying physics!
