# 2D-Shape-Morphing-with-Core-Graphics-and-Linear-Algebra
## Description

This UIKit Mini Project demonstrates how to animate smooth transitions between different 2D shapes using Core Graphics and basic linear algebra. It is designed as a lightweight visual tool to explore how custom vector math and real-time rendering can be combined to create fluid morphing animations entirely from scratch.

The app showcases how to interpolate between multiple geometric figures — such as squares, rectangles, diamonds, and circles — while maintaining visual coherence and smooth motion.

It’s ideal for those interested in learning how drawing, animation, and math can be harmonized in a UIKit-based creative tool.

---

## Project Structure

- **MorphingView.swift**: Custom `UIView` that draws and animates morphing shapes using `UIBezierPath`.
- **ShapeFactory.swift**: Generates base shapes and interpolates them to ensure matching point counts for seamless transitions.
- **ViewController.swift**: Manages the UI and shape selection buttons, and starts the animation.
- **SceneDelegate.swift**: Sets up the window and root view controller.
- **AppDelegate.swift**: Standard app lifecycle entry point.

---

## How It Works

The app performs real-time interpolation between shapes by animating between two sets of `CGPoint` arrays:

| Component | Description |
| --- | --- |
| **Shape Types** | Square, Rectangle, Diamond, Circle |
| **Animation Engine** | CADisplayLink updates the animation frame-by-frame |
| **Rendering** | Shapes are drawn using `UIBezierPath` inside `draw(_:)` |
| **Interpolation** | Each shape is represented with 40 evenly distributed points, ensuring clean transitions |

Shapes are defined as sequences of points on their perimeter. When the user selects a different shape, the app interpolates from the current shape to the target one using linear interpolation of each point pair.

The transition is visually smooth thanks to:

- Frame-based updates via `CADisplayLink`
- Equidistant point sampling for every shape
- Single `UIBezierPath` rendering logic for all shapes

---

## Preview

- Tap a shape button to morph the current shape.
- Shapes include square, rectangle, diamond, and circle.
- The morphing animation is smooth and continuous.
- Real-time rendering using Core Graphics.

---

## Ideas for Extension

Here are some ideas to expand the functionality:

- Add more complex shapes (e.g. star, heart).
- Allow user-drawn shapes with interpolation to presets.
- Add a timeline slider to control morph progress manually.
- Export morphing as image sequences or video.
- Animate shape color or stroke styles during transitions.

---

## License

MIT License. Feel free to use and modify.
