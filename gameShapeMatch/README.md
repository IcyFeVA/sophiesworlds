# Shape Matching Game

A delightful shape matching minigame designed for toddlers and young children, featuring colorful draggable shapes that need to be matched with their corresponding outlines.

## 🎮 Game Features

### Core Gameplay
- **Drag & Drop Mechanics**: Touch and drag colorful shapes from the left side of the screen
- **Shape Matching**: Match each shape to its corresponding outline on the right side
- **Visual Feedback**: Shapes light up and animate when correctly matched
- **Auto-Reset**: Game automatically creates a new level when all shapes are matched

### Toddler-Friendly Design
- **Large Touch Targets**: Minimum 60px radius for easy touch detection
- **Bright Colors**: Saturated, appealing colors (red, blue, green, yellow, purple, orange)
- **Smooth Animations**: Satisfying drag behavior with bounce and scale effects
- **Audio Feedback**: Different sounds for pickup, putback, success, and error states
- **No Text Required**: Purely visual gameplay suitable for non-readers

### Technical Features
- **Multitouch Support**: Handle multiple simultaneous touches
- **Screen Adaptation**: Optimized for 960x540 mobile landscape orientation
- **Performance Optimized**: Efficient factory-based object creation/destruction
- **State Management**: Robust game state tracking prevents double-interactions

## 🔧 Configuration Options

The game includes several configurable parameters in `shapeGameManager.script`:

```lua
-- Game Configuration (at top of init function)
self.num_shapes = 4           -- Number of shapes per level (1-6 recommended)
self.shape_size = 100         -- Shape diameter in pixels (60-150 recommended)
self.outline_size = 120       -- Outline diameter (should be larger than shape_size)
self.drag_threshold = 80      -- Distance for successful match (50-100 recommended)

-- Colors and shapes are also configurable
self.shape_types = {"circle", "square", "triangle", "star"}
self.shape_colors = {
    vmath.vector4(1.0, 0.3, 0.3, 1.0),  -- red
    vmath.vector4(0.3, 0.3, 1.0, 1.0),  -- blue  
    -- ... add more colors as needed
}
```

## 🎵 Audio Assets Used

The game uses existing sound files from the `/sounds/` directory:
- **Pickup**: `pullout.mp3` - When shape is grabbed (with pitch variation)
- **Putback**: `putback.mp3` - When shape is released without matching
- **Success**: `inbaSuccess.mp3` - When shapes are successfully matched
- **Error**: `smallButton2.mp3` - When wrong match is attempted
- **Highlight**: `guiselect.mp3` - Subtle UI feedback (lower volume)

All sounds play with random pitch variation (±20%) for variety and natural feel.

## 🏗️ Architecture Overview

### File Structure
```
gameShapeMatch/
├── scripts/
│   ├── controller.script          # Input handling & touch coordination
│   ├── shapeGameManager.script    # Game logic & level generation
│   ├── shape.script              # Draggable shape behavior
│   └── outline.script            # Target outline behavior
├── go/
│   ├── shape.go                  # Draggable shape game object
│   ├── shape.sprite              # Shape sprite definition
│   ├── outline.go                # Target outline game object
│   └── outline.sprite            # Outline sprite definition
├── gameShapeMatch.atlas          # Sprite atlas (uses bubble.png)
├── gameShapeMatch.collection     # Main collection with factories
└── README.md                     # This documentation
```

### Component Communication
- **Controller**: Handles all input events, converts screen to world coordinates
- **Game Manager**: Creates levels, manages game state, handles shape-outline matching
- **Shapes**: Individual draggable objects with animation and audio feedback
- **Outlines**: Target areas with pulsing animations and highlight effects

### Key Patterns Used
- **Factory Pattern**: Dynamic creation/destruction of shapes and outlines
- **Message Passing**: Communication between game components
- **State Management**: Prevents double-interactions and handles game flow
- **Animation Queueing**: Smooth transitions with proper cleanup

## 🚀 Integration Steps

### Testing the Game

1. **Temporary Setup** (for testing):
   ```
   Update game.project:
   main_collection = /gameShapeMatch/gameShapeMatch.collectionc
   ```

2. **Build and Run**: The game should start immediately with 4 colorful shapes on the left and matching outlines on the right

3. **Test Interactions**:
   - Drag shapes to matching outlines
   - Try wrong matches (should return to original position)
   - Complete all matches (should auto-reset after 2 seconds)

### Production Integration

1. **Revert game.project**:
   ```
   main_collection = /gameBubbleWrap/gameBubbleWrap.collectionc
   ```

2. **Menu Integration**: Add shape matching game to main menu system
   - Update menu scripts to load `/gameShapeMatch/gameShapeMatch.collection`
   - Add appropriate menu buttons and transitions

3. **Optional Customization**:
   - Adjust `num_shapes` for different difficulty levels
   - Modify colors and sizes for different themes
   - Add progression system (increasing number of shapes)

## 🎯 Game Flow

1. **Initialization**: 4 shapes appear on left, outlines appear on right (shuffled positions)
2. **Player Interaction**: Touch and drag shapes toward matching outlines
3. **Feedback Loop**: 
   - Correct matches: satisfying animation + success sound
   - Wrong matches: shake animation + error sound + return to start
4. **Level Completion**: All shapes matched → celebration → auto-reset after 2 seconds
5. **Infinite Play**: New random level generates automatically

## 🔧 Troubleshooting

### Common Issues
- **Shapes don't drag**: Check that multitouch input is properly configured
- **No audio**: Verify sound files exist in `/sounds/` directory
- **Performance issues**: Reduce `num_shapes` or simplify animations
- **Touch detection problems**: Adjust `shape_size` and `drag_threshold` values

### Debug Information
The game includes comprehensive console logging:
- Shape creation and matching events
- Input coordinate conversions
- Game state transitions
- Error conditions and warnings

## 🎨 Customization Ideas

### Easy Modifications
- **More Shapes**: Add pentagon, hexagon, heart shapes to `shape_types`
- **Seasonal Themes**: Change colors for holidays (red/green for Christmas, etc.)
- **Difficulty Progression**: Start with 2 shapes, increase to 6 over time
- **Sound Packs**: Replace audio files for different themes (animals, vehicles, etc.)

### Advanced Features
- **Shape Animation**: Make shapes rotate or pulse during idle state
- **Particle Effects**: Add sparkles or stars for successful matches
- **Combo System**: Reward consecutive successful matches
- **Time Challenge**: Optional timer for older children

## 📱 Performance Notes

- **Memory Efficient**: Uses factory pattern to reuse game objects
- **Battery Friendly**: Optimized animations, reasonable frame rate
- **Touch Responsive**: Large touch targets, immediate visual feedback
- **Scalable**: Easy to adjust difficulty and complexity

The game is designed to be engaging for toddlers while being simple enough to understand without instructions, making it perfect for the SophiesWorlds educational game collection.
