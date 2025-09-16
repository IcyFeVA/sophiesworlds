# Design Document

## Overview

The Fireworks game is a touch-interactive mini-game that creates colorful firework explosions when the user touches the screen. The game follows the established SophiesWorlds architecture pattern with a dedicated game collection, controller script, and particle effects system. The design emphasizes immediate visual feedback, multitouch support, and seamless integration with the existing game selector.

## Architecture

### Game Structure

The Fireworks game follows the established Defold project pattern:

```
gameFireworks/
├── scripts/
│   ├── controller.script          # Main game logic and input handling
│   └── fireworksSpawner.script   # Firework particle management
├── go/
│   ├── controller.go             # Controller game object
│   └── fireworksSpawner.go       # Particle spawner game object
├── gameFireworks.collection      # Main game scene
└── gameFireworks.atlas          # Game-specific sprites (if needed)
```

### Integration Points

- **Main Script**: Add fireworks game proxy and routing logic
- **Game Selector**: Add fireworks button to game selection GUI
- **Particle System**: Create dedicated firework particle effects
- **Sound System**: Integrate firework explosion sounds

## Components and Interfaces

### Controller Script (`controller.script`)

**Responsibilities:**
- Handle touch/mouse input using established input patterns
- Convert screen coordinates to world coordinates using rendercam
- Trigger firework explosions at touch locations
- Support multitouch for simultaneous fireworks
- Manage game state and cleanup

**Key Functions:**
```lua
function init(self)
    -- Initialize input focus and rendercam
    -- Set up multitouch tracking table
end

function handle_input(self, action_id, action)
    -- Handle touch/multitouch input
    -- Convert screen to world coordinates
    -- Trigger firework at touch location
end

function create_firework(self, world_pos)
    -- Spawn firework particle effect at position
    -- Randomize colors and explosion properties
    -- Play sound effect
end
```

### Fireworks Spawner Script (`fireworksSpawner.script`)

**Responsibilities:**
- Manage firework particle effect lifecycle
- Handle color randomization and visual variety
- Clean up completed particle effects
- Optimize performance with effect pooling

**Key Functions:**
```lua
function spawn_firework(self, position, properties)
    -- Create particle effect at specified position
    -- Apply randomized color and size properties
    -- Track active effects for cleanup
end

function cleanup_effects(self)
    -- Remove completed particle effects
    -- Maintain performance optimization
end
```

## Data Models

### Firework Properties

```lua
-- Firework explosion configuration
local firework_config = {
    colors = {
        {r = 1.0, g = 0.2, b = 0.2},  -- Red
        {r = 0.2, g = 1.0, b = 0.2},  -- Green  
        {r = 0.2, g = 0.2, b = 1.0},  -- Blue
        {r = 1.0, g = 1.0, b = 0.2},  -- Yellow
        {r = 1.0, g = 0.2, b = 1.0},  -- Magenta
        {r = 0.2, g = 1.0, b = 1.0},  -- Cyan
        {r = 1.0, g = 0.6, b = 0.2},  -- Orange
        {r = 0.8, g = 0.2, b = 1.0}   -- Purple
    },
    particle_count_range = {min = 20, max = 50},
    explosion_size_range = {min = 80, max = 150},
    particle_lifetime_range = {min = 1.0, max = 2.5}
}
```

### Touch Tracking

```lua
-- Multitouch support following existing pattern
self.activeTouches = {}  -- Track multiple simultaneous touches
```

## Particle Effects Design

### Firework Particle Effect (`particles/fireworks.particlefx`)

**Primary Emitter (Explosion Burst):**
- Type: CIRCLE emitter for radial explosion
- Mode: PLAY_MODE_ONCE for single burst
- Particle count: 30-60 particles
- Speed: High initial velocity (200-400 units)
- Lifetime: 1.5-2.5 seconds
- Color: Randomized from predefined palette
- Physics: Gravity modifier for realistic arc motion

**Secondary Emitter (Sparkle Trail):**
- Type: CIRCLE emitter for trailing sparkles
- Mode: PLAY_MODE_ONCE with delayed start
- Particle count: 10-20 particles
- Speed: Lower velocity (50-150 units)
- Lifetime: 0.5-1.0 seconds
- Color: Lighter variants of main color
- Alpha: Fade out over lifetime

**Tertiary Emitter (Flash Effect):**
- Type: Single large particle for initial flash
- Mode: PLAY_MODE_ONCE
- Duration: 0.1-0.2 seconds
- Size: Large initial size, quickly shrinking
- Color: Bright white/yellow
- Blend mode: ADD for bright flash effect

## Error Handling

### Input Validation

```lua
-- Validate screen coordinates before processing
if not action.screen_x or not action.screen_y then
    return
end

-- Validate world coordinate conversion
local worldPos = rendercam.screen_to_world_2d(action.screen_x, action.screen_y)
if not worldPos then
    return
end
```

### Performance Protection

```lua
-- Limit simultaneous fireworks to prevent performance issues
local MAX_ACTIVE_FIREWORKS = 10

if #self.active_fireworks >= MAX_ACTIVE_FIREWORKS then
    -- Remove oldest firework before creating new one
    self:cleanup_oldest_firework()
end
```

### Resource Management

```lua
-- Automatic cleanup of particle effects
timer.delay(effect_lifetime, false, function()
    if go.exists(effect_id) then
        go.delete(effect_id)
    end
end)
```

## Sound Design

### Sound Effects Integration

- **Firework Launch**: Brief "whoosh" sound on touch
- **Explosion**: Varied explosion sounds with pitch randomization
- **Multiple Fireworks**: Layered sounds without audio clipping
- **Volume Control**: Respect system volume settings

### Audio Implementation

```lua
-- Play randomized firework sound
local sound_variations = {"firework1", "firework2", "firework3"}
local sound_name = sound_variations[math.random(#sound_variations)]
sound.play("/soundfx#" .. sound_name, {
    speed = math.random(80, 120) / 100  -- Pitch variation
})
```

## Testing Strategy

### Unit Testing Approach

1. **Input Handling Tests**
   - Verify touch coordinate conversion
   - Test multitouch support
   - Validate input edge cases

2. **Particle System Tests**
   - Confirm particle effects spawn correctly
   - Test color randomization
   - Verify cleanup mechanisms

3. **Performance Tests**
   - Test with maximum simultaneous fireworks
   - Verify memory cleanup
   - Check frame rate stability

4. **Integration Tests**
   - Test game selector integration
   - Verify proxy loading/unloading
   - Test return to selector functionality

### Manual Testing Scenarios

1. **Basic Functionality**
   - Single touch creates firework
   - Multiple touches create multiple fireworks
   - Visual effects appear at correct locations

2. **Multitouch Testing**
   - Simultaneous touches on different screen areas
   - Rapid successive touches
   - Touch and hold behavior

3. **Performance Testing**
   - Stress test with rapid continuous touches
   - Long-duration play sessions
   - Memory usage monitoring

4. **Cross-Platform Testing**
   - Desktop mouse input
   - Mobile touch input
   - Different screen resolutions

## Performance Considerations

### Optimization Strategies

1. **Particle Effect Pooling**
   - Reuse particle effect instances
   - Limit maximum active effects
   - Efficient cleanup timers

2. **Memory Management**
   - Automatic garbage collection of completed effects
   - Minimal object creation during gameplay
   - Efficient touch tracking data structures

3. **Rendering Optimization**
   - Use appropriate blend modes for visual effects
   - Optimize particle count for target devices
   - Efficient sprite atlas usage

### Resource Limits

- Maximum simultaneous fireworks: 10
- Maximum particles per firework: 60
- Particle effect duration: 2.5 seconds maximum
- Touch input processing: 60 FPS target