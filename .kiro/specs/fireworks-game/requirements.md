# Requirements Document

## Introduction

The Fireworks game is a touch-interactive mini-game for the SophiesWorlds mobile game collection. Players touch anywhere on the screen to trigger colorful firework explosions at the touch location. The game provides immediate visual feedback with particle effects and satisfying animations, designed for young children who enjoy cause-and-effect interactions.

## Requirements

### Requirement 1

**User Story:** As a young child, I want to touch the screen to create fireworks, so that I can enjoy colorful visual effects and feel a sense of control over the display.

#### Acceptance Criteria

1. WHEN the player touches anywhere on the screen THEN the system SHALL create a firework explosion at the touch location
2. WHEN a firework is triggered THEN the system SHALL display colorful particle effects that expand outward from the touch point
3. WHEN multiple touches occur simultaneously THEN the system SHALL create separate firework explosions for each touch point
4. WHEN a firework explosion occurs THEN the system SHALL play an appropriate sound effect

### Requirement 2

**User Story:** As a young child, I want the fireworks to be visually appealing and varied, so that each touch feels exciting and different.

#### Acceptance Criteria

1. WHEN a firework is created THEN the system SHALL use randomized colors from a predefined palette
2. WHEN a firework explodes THEN the system SHALL display particles that fade out over time
3. WHEN particles are created THEN the system SHALL animate them with realistic physics (gravity and velocity)
4. WHEN a firework is triggered THEN the system SHALL vary the explosion size and particle count for visual variety

### Requirement 3

**User Story:** As a parent, I want the game to be accessible and responsive, so that my child can easily interact with it on mobile devices.

#### Acceptance Criteria

1. WHEN the game starts THEN the system SHALL support both touch input and mouse input for cross-platform compatibility
2. WHEN input is received THEN the system SHALL respond immediately with visual feedback
3. WHEN the game is running THEN the system SHALL maintain smooth performance with multiple simultaneous fireworks
4. WHEN particles are no longer visible THEN the system SHALL clean them up to maintain performance

### Requirement 4

**User Story:** As a user of SophiesWorlds, I want to access the Fireworks game from the game selector, so that I can easily switch between different mini-games.

#### Acceptance Criteria

1. WHEN the game selector is displayed THEN the system SHALL include a "Fireworks" button alongside other games
2. WHEN the Fireworks button is pressed THEN the system SHALL launch the Fireworks game scene
3. WHEN the Fireworks game is active THEN the system SHALL hide the game selector interface
4. WHEN the user wants to return to the selector THEN the system SHALL provide a way to exit back to the main menu

### Requirement 5

**User Story:** As a developer, I want the Fireworks game to follow the existing project architecture, so that it integrates seamlessly with the SophiesWorlds codebase.

#### Acceptance Criteria

1. WHEN the game is implemented THEN the system SHALL follow the existing Defold project structure with appropriate directories
2. WHEN the game is created THEN the system SHALL use the established input handling patterns from other games
3. WHEN particle effects are implemented THEN the system SHALL use Defold's particle system for optimal performance
4. WHEN the game is integrated THEN the system SHALL use the existing screen resolution and projection settings (960x540 Fixed Fit)