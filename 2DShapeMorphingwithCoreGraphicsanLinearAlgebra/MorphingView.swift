//
//  MorphingView.swift
//  miniproject2
//
//  Created by Stephano Portella on 03/04/25.
//
import UIKit

enum ShapeType {
    case square, rectangle, diamond, circle, heart, star
}

class MorphingView: UIView {

    private var displayLink: CADisplayLink?
    private var progress: CGFloat = 0.0
    private let duration: CGFloat = 3.0
    private var startTime: CFTimeInterval = 0

    private var shapeA: [CGPoint] = []
    private var shapeB: [CGPoint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        shapeA = ShapeFactory.square()
        shapeB = shapeA
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startMorphing() {
        progress = 0.0
        startTime = CACurrentMediaTime()
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .default)
    }

    func setTargetShape(_ type: ShapeType) {
        shapeA = currentInterpolatedShape()
        switch type {
        case .square:
            shapeB = ShapeFactory.square()
        case .rectangle:
            shapeB = ShapeFactory.rectangle()
        case .diamond:
            shapeB = ShapeFactory.diamond()
        case .circle:
            shapeB = ShapeFactory.circle()
        case .heart:
            shapeB = ShapeFactory.heart()
        case .star:
            shapeB = ShapeFactory.star()
        }
    startMorphing()
}

    private func currentInterpolatedShape() -> [CGPoint] {
        return zip(shapeA, shapeB).map { (a, b) in
            CGPoint(
                x: a.x + (b.x - a.x) * progress,
                y: a.y + (b.y - a.y) * progress
            )
        }
    }

    @objc private func updateAnimation() {
        let currentTime = CACurrentMediaTime()
        let elapsedTime = CGFloat(currentTime - startTime)
        progress = min(max(elapsedTime / duration, 0), 1)
        setNeedsDisplay()

        if progress >= 1.0 {
            progress = 1.0
            shapeA = shapeB
            displayLink?.invalidate()
            displayLink = nil
        }
    }

    override func draw(_ rect: CGRect) {
        guard shapeA.count == shapeB.count else { return }

        let path = UIBezierPath()
        for i in 0..<shapeA.count {
            let pointA = shapeA[i]
            let pointB = shapeB[i]
            let interpolated = CGPoint(
                x: pointA.x + (pointB.x - pointA.x) * progress,
                y: pointA.y + (pointB.y - pointA.y) * progress
            )
            if i == 0 {
                path.move(to: interpolated)
            } else {
                path.addLine(to: interpolated)
            }
        }
        path.close()

        UIColor.systemBlue.setFill()
        path.fill()
    }
}
