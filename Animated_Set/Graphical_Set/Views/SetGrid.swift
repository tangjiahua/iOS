//
//  SetGrid.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/30.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit
struct SetGrid{
    private var bounds: CGRect { didSet { calculateGrid() } }//
    private var numberOfFrames: Int  { didSet { calculateGrid() } }//格子数量，didSet：更改的时候调用calculateGrid方法
    static var idealAspectRatio: CGFloat = 0.7//格子宽：格子高度
    
    //最后SetGrid给出每一张牌的位置、大小放进一个数组里面返回出去。
    init(for bounds: CGRect, withNoOfFrames: Int, forIdeal aspectRatio: CGFloat = SetGrid.idealAspectRatio) {
        self.bounds = bounds
        self.numberOfFrames = withNoOfFrames
        SetGrid.idealAspectRatio = aspectRatio
        calculateGrid()
    }

    subscript(index: Int) -> CGRect? {
        return index < cellFrames.count ? cellFrames[index] : nil
    }
    
    func count() -> Int{
        return cellFrames.count
    }
    
    private var cellFrames: [CGRect] = []
    
    private mutating func calculateGrid() {
        var grid = [CGRect]()
        calculateGridDimensions()//寻找griddimenssions，将最好的s设置在bestGridDimensions中
        guard let bestGridDimensions = bestGridDimensions else {
            grid = []
            return
        }
        for row in 0..<bestGridDimensions.rows {
            for col in 0..<bestGridDimensions.cols {
                let origin = CGPoint(x: CGFloat(col) * bestGridDimensions.frameSize.width, y: CGFloat(row) * bestGridDimensions.frameSize.height)
                let rect = CGRect(origin: origin, size: bestGridDimensions.frameSize)
                grid.append(rect)
            }
        }
        self.cellFrames = grid
    }

    private var bestGridDimensions: GridDimensions?
    
    mutating func calculateGridDimensions(){
        /*
         由于有许多种组合，我们需要从中找出铺满屏幕的同时最接近idealAspectRatio的组合
         举个例子，假设现在要将12张卡片显示在屏幕之上，那么我们将会拥有：
         1x12 2x6 3x4 4x3 5x3 6x2 7x2 8x2 9x2 10x2 11x2 12x1    （乘号左边是列数，右边是行数）ps：总的格子数可以超过12个！
         这么多种列表组合，那么我们就在这之中选择最接近宽比长0.7的选择！
        */
        for cols in 1...numberOfFrames{
            let rows = numberOfFrames % cols == 0 ? numberOfFrames / cols : numberOfFrames/cols + 1
            let calculatedframeDimension = GridDimensions(
                cols: cols,
                rows: rows,
                frameSize: CGSize(width: bounds.width/CGFloat(cols), height: bounds.height/CGFloat(rows))
            )
            
            if let bestFrameDimension = bestGridDimensions, bestFrameDimension > calculatedframeDimension{
                return
            }else{
                self.bestGridDimensions = calculatedframeDimension
            }
        }
        return
    }
    
    //GridDimensions：
    //cols, rows, frameSize(每个小格子的size，是一个CGSize类型), aspectRatio
    struct GridDimensions: Comparable{
        static func <(lhs: SetGrid.GridDimensions, rhs: SetGrid.GridDimensions) -> Bool{
            return lhs.isCloserToIdeal(aspectRatio: rhs.aspectRatio)
        }
        
        static func ==(lhs: SetGrid.GridDimensions, rhs: SetGrid.GridDimensions) -> Bool {
            return lhs.cols == rhs.cols && lhs.rows == rhs.rows
        }
        
        var cols: Int
        var rows: Int
        var frameSize: CGSize
        var aspectRatio: CGFloat {
            return frameSize.width/frameSize.height
        }
        
        func isCloserToIdeal(aspectRatio: CGFloat) -> Bool {
            return (SetGrid.idealAspectRatio - aspectRatio).abs < (SetGrid.idealAspectRatio - self.aspectRatio).abs
        }
    }
    
    
    
    
    }
extension CGFloat {
    var abs: CGFloat {
        return self<0 ? -self: self
    }
}
