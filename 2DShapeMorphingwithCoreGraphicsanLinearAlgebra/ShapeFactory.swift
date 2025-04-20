//
//  ShapeFactory.swift
//  miniproject2
//
//  Created by Stephano Portella on 03/04/25.
//
import UIKit

struct ShapeFactory {

    static let pointCount = 40

    static func square() -> [CGPoint] {
        let base: [CGPoint] = [
            CGPoint(x: 50, y: 50),
            CGPoint(x: 250, y: 50),
            CGPoint(x: 250, y: 250),
            CGPoint(x: 50, y: 250)
        ]
        return interpolate(points: base, count: pointCount)
    }

    static func rectangle() -> [CGPoint] {
        let base: [CGPoint] = [
            CGPoint(x: 50, y: 0),
            CGPoint(x: 250, y: 0),
            CGPoint(x: 250, y: 300),
            CGPoint(x: 50, y: 300)
        ]
        return interpolate(points: base, count: pointCount)
    }

    static func diamond() -> [CGPoint] {
        let base: [CGPoint] = [
            CGPoint(x: 150, y: 30),
            CGPoint(x: 270, y: 150),
            CGPoint(x: 150, y: 270),
            CGPoint(x: 30, y: 150)
        ]
        return interpolate(points: base, count: pointCount)
    }

    static func circle() -> [CGPoint] {
        let center = CGPoint(x: 150, y: 150)
        let radius: CGFloat = 100
        return (0..<pointCount).map { i in
            let angle = CGFloat(i) * (.pi * 2) / CGFloat(pointCount)
            return CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
        }
    }

    static func heart() -> [CGPoint] {
        let center = CGPoint(x: 150, y: 150)
        let scale: CGFloat = 8.0
        return (0..<pointCount).map { i in
            let t = CGFloat(i) * (.pi * 2) / CGFloat(pointCount)
            let x = 16 * pow(sin(t), 3)
            let y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)
            return CGPoint(
                x: center.x + x * scale,
                y: center.y - y * scale
            )
        }
    }

    static func star() -> [CGPoint] {
        let center = CGPoint(x: 150, y: 150)
        let outerRadius: CGFloat = 100
        let innerRadius: CGFloat = 45
        let totalPoints = pointCount
        return (0..<totalPoints).map { i in
            let angle = CGFloat(i) * (.pi * 2) / CGFloat(totalPoints)
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            return CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
        }
    }
    }

func interpolate(points: [CGPoint], count: Int) -> [CGPoint] {
        guard points.count >= 2 else { return points }

        var distances: [CGFloat] = [0]
        var totalLength: CGFloat = 0

        for i in 0..<points.count {
            let next = points[(i + 1) % points.count]
            let d = hypot(points[i].x - next.x, points[i].y - next.y)
            totalLength += d
            distances.append(totalLength)
        }

        var interpolated: [CGPoint] = []
        let step = totalLength / CGFloat(count)

        for i in 0..<count {
            let targetDistance = CGFloat(i) * step

            var segment = 0
            for j in 1..<distances.count {
                if distances[j] >= targetDistance {
                    segment = j - 1
                    break
                }
            }

            let segmentStart = points[segment % points.count]
            let segmentEnd = points[(segment + 1) % points.count]
            let segmentLength = distances[segment + 1] - distances[segment]
            let distanceInSegment = targetDistance - distances[segment]
            let t = segmentLength > 0 ? distanceInSegment / segmentLength : 0

            let interpolatedPoint = CGPoint(
                x: segmentStart.x + (segmentEnd.x - segmentStart.x) * t,
                y: segmentStart.y + (segmentEnd.y - segmentStart.y) * t
            )
            interpolated.append(interpolatedPoint)
        }

        return interpolated
    }

func matchPoints(to points: [CGPoint], count: Int) -> [CGPoint] {
        guard points.count != count else { return points }
        var result: [CGPoint] = []
        for i in 0..<count {
            let t = CGFloat(i) / CGFloat(count) * CGFloat(points.count)
            let index = Int(t) % points.count
            result.append(points[index])
        }
        return result
    }
