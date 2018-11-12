//
//  CanvasView.swift
//  Lab3
//
//  Created by Reis Sirdas on 2/15/17.
//  Copyright © 2017 sirdas. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var currLine: LineView?
    var points = [CGPoint]()
    var color = UIColor.red
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
    }
    
    var thickness: CGFloat = 25
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        points.removeAll()
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        
        points.append(touchPoint)
        
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        currLine = LineView(frame: frame)
        
        
        currLine?.theLine = Line(thickness: thickness, path: createQuadPath(points: points), color: color)

        
        self.addSubview(currLine!)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        points.append(touchPoint)
        //print(touchPoint)
        
        currLine?.theLine?.path = createQuadPath(points: points)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        points.append(touchPoint)
        currLine?.theLine?.path = createQuadPath(points: points)
       
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        return CGPoint(x: (first.x + second.x) / 2, y: (first.y + second.y) / 2)
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineCapStyle = .round
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
}
