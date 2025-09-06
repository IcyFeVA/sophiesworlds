# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

**SophiesWorlds** is a mobile game project built with the [Defold game engine](https://defold.com/). The project contains multiple mini-games designed for mobile platforms (Android and iOS) with multitouch support and particle effects.

### Key Technologies
- **Defold Engine**: Lua-based 2D game engine
- **Lua**: Primary scripting language
- **Target Platforms**: Mobile (Android/iOS) with desktop support
- **Screen Resolution**: 960x540 with Fixed Fit projection

## Development Workflow

### Building and Running
This is a Defold project that requires the Defold Editor for development:

1. **Open Project**: Launch Defold Editor and open the project directory
2. **Build and Run**: Use `Project → Build` or `Ctrl+B` in the editor
3. **Bundle**: Use `Project → Bundle` to create platform-specific builds
4. **Hot Reload**: Code changes are automatically reloaded in debug builds

### Command Line Building (if Bob is installed)
```bash
# Build for desktop
bob --platform x86_64-darwin build

# Build for mobile platforms
bob --platform armv7-android build
bob --platform arm64-ios build
```

### Testing
- **Interactive Testing**: Run the project in the editor and interact with touch/mouse input
- **Device Testing**: Use Defold's mobile app or bundle for device testing
- **Debug Output**: Check the console in the editor for print statements and errors

## Project Architecture

### Multi-Game Structure
The project is organized as a collection of mini-games:

```
├── main/                    # Entry point and shared utilities
│   ├── main.collection      # Main scene collection
│   ├── main.script         # Platform detection and initialization
│   └── data.lua            # Shared data module (screen size, utilities)
├── gameBubbles/            # Bubble popping game
│   ├── scripts/            # Game logic scripts
│   │   ├── controller.script    # Input handling and game logic
│   │   ├── spawner.script      # Bubble creation and management
│   │   └── particleSpawner.script # Particle effects
│   └── go/                 # Game objects and components
├── gameXylophone/          # Xylophone game (in development)
└── input/                  # Input binding configuration
```

### Key Components

#### Main Entry Point (`main/main.script`)
- Detects platform (Android/iOS) for platform-specific features
- Handles initial setup and routing

#### Shared Data Module (`main/data.lua`)
```lua
M.SW = 960  -- Screen width
M.SH = 540  -- Screen height
M.tablelength = function(T) -- Utility for table length
```

#### Input System (`input/game.input_binding`)
- **Mouse**: Left click mapped to "touch" action
- **Touch**: Multi-touch support mapped to "multitouch" action
- Both handled uniformly in game controllers

#### Bubble Game Architecture (`gameBubbles/`)
- **Controller**: Manages input, collision detection, and game state
- **Spawner**: Creates and tracks bubble instances with factory pattern
- **Particle Spawner**: Handles pop effects and cleanup
- **Multitouch Support**: Tracks multiple simultaneous touches
- **Object Pool**: Efficient bubble lifecycle management

### External Dependencies
Configured in `game.project`:
- **rendercam** (v1.0.1): Camera management and screen-to-world coordinate conversion
- **defold-input**: Enhanced input handling utilities  
- **gooey**: GUI framework for UI elements

## Development Guidelines

### Code Patterns

#### Game Controllers
Each game has a controller script that follows this pattern:
```lua
function init(self)
    msg.post(".", "acquire_input_focus")
    -- Initialize game state
end

function on_input(self, action_id, action)
    -- Handle touch/mouse input
    -- Convert screen to world coordinates using rendercam
end
```

#### Factory Pattern Usage
For dynamic object creation (bubbles, particles):
```lua
local object_id = factory.create("#factory_name", position, rotation, properties, scale)
```

#### Message Passing
Games use Defold's message system for communication:
```lua
msg.post(recipient, "message_name", {data = value})
```

### Performance Considerations
- **Efficient Collision Detection**: Use squared distance calculations to avoid sqrt()
- **Object Pooling**: Remove objects from tracking tables when destroyed
- **Particle Cleanup**: Use timers to automatically clean up particle effects
- **Touch Optimization**: Track active touches in tables for multitouch support

### Platform-Specific Features
- **Mobile Optimizations**: Accelerometer disabled for better battery life
- **Touch Handling**: Unified touch/mouse input system
- **Screen Adaptation**: Fixed Fit projection maintains aspect ratio across devices
- **Icons**: Separate icon sets for iOS and Android platforms

### File Organization
- **Scripts**: `.script` files contain game logic
- **Game Objects**: `.go` files define entities with components
- **Collections**: `.collection` files define scenes and object hierarchies
- **Assets**: Organized by game type in respective directories

### Common Development Tasks
- **Adding New Games**: Create new directory under root, follow existing game structure
- **Modifying Input**: Edit `input/game.input_binding` for new input mappings
- **Screen Resolution**: Update `data.lua` and `game.project` display settings
- **Dependencies**: Add new dependencies in `game.project` dependencies section

## Mobile-Specific Configuration

### Screen Settings
- **Resolution**: 960x540 (landscape orientation available)
- **Projection**: Fixed Fit (maintains aspect ratio)
- **High DPI**: Disabled for consistent scaling

### Platform Bundles
- **iOS**: Bundle identifier `com.example.todo` (update for production)
- **Android**: Package name matches iOS bundle identifier
- **Icons**: Platform-specific icon sets configured in `game.project`

### Performance Settings
- **Physics**: Gravity set to -1000, scale 0.01 for mobile optimization
- **Input**: Accelerometer disabled to preserve battery life
- **Shared State**: Enabled for better script performance

## Rules Integration
- Never use Expo Router, use React Native Navigation instead (Note: This rule applies to React Native projects, not applicable to this Defold project)
