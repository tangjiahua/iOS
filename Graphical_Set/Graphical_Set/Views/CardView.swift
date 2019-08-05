//
//  CardView.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/30.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit

class CardView: UIView {

    var state: State.stateOfSelection?
    var card: Card?
    var heightOfObject:CGFloat{
        return bounds.height/4
    }
    var heightOfSpace:CGFloat{
        return bounds.height/16
    }
    
    var color:Card.Color?{
        return card?.color
    }
//    private var color: Card.Color?{
//        return card?.color
//    }
    private var shape: Card.Shape? {
        return card?.shape
    }
    private var number: Card.Number? {
        return card?.number
    }
    private var fill: Card.Fill? {
        return card?.fill
    }
    
    //常规初始化uiview的不要步骤？
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //初始化该cardViews的时候，要拿一张卡来与它绑定
    convenience init(frame: CGRect, card:Card) {
        self.init(frame:frame)
        self.card = card
        self.state = State.stateOfSelection.unselected
        backgroundColor = UIColor.white
    }
 
    
    //绘制卡片的图形，需要重写
    //绘制卡片包括：卡片边框的颜色、卡片中心object的内容
    override func draw(_ rect: CGRect) {
        drawObject()
        let border = UIBezierPath(rect: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height))
        border.lineWidth = state == State.stateOfSelection.selected ? Border.selectedBorderWidth : Border.unselectedBorderWidth
        borderColor.setStroke()
        border.stroke()
        backgroundColor = UIColor.orange
    }
    
    var borderColor:UIColor{
        if let state = state{
            switch state{
            case .selected:
                return UIColor.red
            case.unselected:
                return UIColor.gray
            case.hinted:
                return UIColor.blue
            }
        }
        return UIColor.gray
    }
    
    //绘制中心的图形
    func drawObject(){
        if let num = card?.number.rawValue{
            for index in 0..<num{
                if let shape_now = shape, let color_now = color, let fill_now = fill{
                    //后面几个是object的颜色、形状、条纹属性
                    let object = ObjectView(frame: objectFrame[index], shape: shape_now, color: color_now, fill: fill_now)
                    addSubview(object)
                }
            }
        }
    }
    //object的位置、大小、数量三个属性在这里
    var objectFrame: [CGRect]{
        var frames = [CGRect]()
        let number = card!.number.rawValue
        // first object
        var currentY = heightOfSpace
        var objectFrame = CGRect(x: (bounds.midX - heightOfObject/2), y: currentY, width: heightOfObject, height: heightOfObject)
        frames.append(objectFrame)
        //others
        for _ in 1..<number{
            currentY += heightOfSpace + heightOfObject
            frames.append(CGRect(x: (bounds.midX - heightOfObject/2), y: currentY, width: heightOfObject, height: heightOfObject))
        }
        return frames
    }
    
    
}

struct State{
    enum stateOfSelection: String{
        case selected
        case unselected
        case hinted
    }

}


