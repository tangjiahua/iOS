//
//  ObjectView.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/30.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit

class ObjectView: UIView {
    var shape:Card.Shape?
    var color:Card.Color?
    var fill:Card.Fill?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, shape: Card.Shape, color: Card.Color, fill: Card.Fill) {
        self.init(frame: frame)
        self.shape = shape
        self.color = color
        self.fill = fill
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    var path: UIBezierPath{
        if let currenShape = shape{
            switch currenShape{
            case .circle: return UIBezierPath(
                arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                radius: bounds.width/2,
                startAngle: CGFloat.zero, endAngle: CGFloat.pi * 2, clockwise: true
                )
            case .square: return UIBezierPath(
                rect: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height)
                )
            case .triangle:
                let path = UIBezierPath()
                path.move(to: CGPoint(x: bounds.width / 2, y: bounds.origin.y))
                path.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
                path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
                path.close()
                return path
            }
        }
        return UIBezierPath()
    }
    
    override func draw(_ rect: CGRect) {
        let drawShape = path
        path.addClip()
        
        var drawColor: UIColor = UIColor.purple
        switch color! {
        case .green:
            drawColor = UIColor.green
        case .purple:
            drawColor = UIColor.purple
        case .red:
            drawColor = UIColor.red
        }
        
        switch fill! {
        case .empty:
            drawColor.setStroke()
            drawShape.lineWidth = Border.unselectedBorderWidth
            drawShape.stroke()
        case .solid:
            drawColor.setFill()
            drawShape.fill()
        case .stripe:
//            drawColor.setFill()
//            drawShape.fill()
//            for y in stride(from: 0, to: bounds.height, by: bounds.height/15){
//                let strpath = UIBezierPath()
//                strpath.move(to: CGPoint(x: 0, y: y))
//                strpath.addLine(to: CGPoint(x: bounds.width, y: y))
//                UIColor.white.setStroke()
//                strpath.stroke()
//            }
            drawColor.setStroke()
            for x in stride(from: 0, to: bounds.width, by: bounds.width / 10) {
                let path = UIBezierPath()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: 0, y: x))
                path.stroke()
            }
            for y in stride(from: 0, to: bounds.width, by: bounds.width / 10) {
                let path = UIBezierPath()
                path.move(to: CGPoint(x: y, y: bounds.height))
                path.addLine(to: CGPoint(x: bounds.width, y: y))
                path.stroke()
            }
        }
    }
    
}

struct Border {
    static let unselectedBorderWidth: CGFloat = 3
    static let selectedBorderWidth: CGFloat = 5
}
