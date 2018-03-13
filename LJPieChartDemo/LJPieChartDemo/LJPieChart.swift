//
//  LJPieChart.swift
//  LJPieChartDemo
//
//  Created by zl on 2018/3/13.
//  Copyright © 2018年 longjianjiang. All rights reserved.
//

import UIKit


let kLJPieChartTitleKey = "kLJPieChartTitleKey"
let kLJPieChartNumberKey = "kLJPieChartNumberKey"
let kLJPieChartColorKey = "kkLJPieChartColorKey"

enum LJPieChartType {
    case arc
    case round
}


class LJPieChart: UIView {
    //MARK: constant value
    let kpieChartElementRoundWidth: CGFloat = 50.0
    let kMinimumPercent: CGFloat = 0.05
    let kSmallCircleBetweenArcMargin: CGFloat = 10.0
    let kBrokenLineWidth: CGFloat = 10.0
    let kLineMessageBetweenBrokenLinePointMargin: CGFloat = 10.0
    let kLineMessageTextHeight: CGFloat = 20
    
    
    //MARK: private property
    
    /// pie chart's radius
    private var pieChartRadius: CGFloat!
    
    /// when type is round, round's width
    private var pieChartElementRoundWidth: CGFloat!
    
    /// pie chart's datasource
    private var pieChartDataSource: [[String: Any]]!
    
    //MARK: public method
    
    /// config pie chart use following data;
    ///
    /// - Parameters:
    ///   - type: pie chart's type;
    ///   - dataSource: data that use offered key to draw pie chart
    ///   - radius: pie chart's radius
    func setPieChartType(_ type: LJPieChartType, dataSource: [[String: Any]], radius: CGFloat) {
        pieChartElementRoundWidth = type == .arc ? 0 : kpieChartElementRoundWidth
        pieChartDataSource = dataSource
        pieChartRadius = radius
        
        setNeedsDisplay()
    }
    
    //MARK: draw method
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        
        let total = getTotalNumberAddPI()
        let center = CGPoint(x: frame.size.width * 0.5,
                             y: frame.size.height * 0.5)
        var startAngle: CGFloat = 0
        
        
        for (idx, item) in pieChartDataSource.enumerated() {
            let value = item[kLJPieChartNumberKey] as? CGFloat
            
            if let numberValue = value {
                
                let endAngle = startAngle + getCanShowLineMessageValue(numberValue) * total
                
                drawArcWithContext(ctx!, point: center, start: startAngle, end: endAngle, idx: idx)
                
                startAngle = endAngle
                
            }
        }
        
        addCenterCircle()
    }
    
    /// if pie chart's type is round, then draw a circle in chart's center
    func addCenterCircle() {
        let center = CGPoint(x: frame.size.width / 2.0,
                             y: frame.size.height / 2.0)
        
        let path = UIBezierPath.init(arcCenter: center,
                                     radius: pieChartElementRoundWidth,
                                     startAngle: 0.0,
                                     endAngle: CGFloat(Double.pi * 2),
                                     clockwise: true)
        
        UIColor.white.set()
        path.fill()
        path.stroke()
    }
    
    /// draw arc
    func drawArcWithContext(_ ctx: CGContext,
                            point: CGPoint,
                            start: CGFloat,
                            end: CGFloat,
                            idx: Int)  {
        
        let color = pieChartDataSource[idx][kLJPieChartColorKey] as? UIColor

        if let fillColor = color {
            ctx.setFillColor(fillColor.cgColor)
        }
        
        ctx.move(to: point)
        
        // anticlockwise is specified for the arc
        ctx.addArc(center: point, radius: pieChartRadius, startAngle: start, endAngle: end, clockwise: false)
        
        ctx.fillPath()
        
        let angle = (start + end) / 2.0
        let x = frame.size.width / 2.0 + (pieChartRadius + kSmallCircleBetweenArcMargin) * cos(angle)
        let y = frame.size.height / 2.0 + (pieChartRadius + kSmallCircleBetweenArcMargin) * sin(angle)
        
        drawSmallCircleAndLineMessageWithContext(ctx,
                                                 position: CGPoint(x: x, y: y),
                                                 angle: angle,
                                                 idx: idx)
    }
    
    /// draw small circle and message line
    func drawSmallCircleAndLineMessageWithContext(_ ctx: CGContext,
                                                  position: CGPoint,
                                                  angle: CGFloat,
                                                  idx: Int) {
        
        let kLineMessageStrFont = UIFont.systemFont(ofSize: 11)
        let kLineMessageStrTextColor = UIColor.gray
        let color = pieChartDataSource[idx][kLJPieChartColorKey] as? UIColor
        var kLineMinimumWidth: CGFloat = 60.0
        
        let smallCircleCenterX = position.x
        let smallCircleCenterY = position.y;
        
        let lineStartPointX = smallCircleCenterX + kBrokenLineWidth * cos(angle)
        let lineStartPointY = smallCircleCenterY + kBrokenLineWidth * sin(angle)
        
        var lineEndPointX: CGFloat!
        var lineEndPointY: CGFloat!
        
        var numberStartX: CGFloat!
        var numberStartY: CGFloat!
        
        var textStartX: CGFloat!
        var textStartY: CGFloat!
        
        var numberStr: NSString = ""
        var msg: NSString = ""
        if let number: CGFloat = pieChartDataSource[idx][kLJPieChartNumberKey] as? CGFloat,
            let text: String = pieChartDataSource[idx][kLJPieChartTitleKey] as? String {
            numberStr = "\(number)" as NSString
            msg = text as NSString
        }
        let numberStrSize = numberStr.size(withAttributes: [NSAttributedStringKey.font: kLineMessageStrFont])
        let msgSize = msg.size(withAttributes: [NSAttributedStringKey.font: kLineMessageStrFont])
        
        var lineWidth: CGFloat = 0
        var lineMaxWidth = numberStrSize.width > msgSize.width ? numberStrSize.width : msgSize.width
        
        if UIScreen.main.bounds.size.width == 320 {
            kLineMinimumWidth = 40
        }
        
        if lineMaxWidth < kLineMinimumWidth {
            lineWidth = kLineMinimumWidth
            lineMaxWidth = kLineMinimumWidth
        } else {
            if lineMaxWidth + kLineMessageBetweenBrokenLinePointMargin > frame.size.width / 2.0 {
                lineMaxWidth = frame.size.width / 2.0
            }
            
            lineWidth = lineMaxWidth + kLineMessageBetweenBrokenLinePointMargin
        }
        
        
        // calculate message line end point and text point
        if smallCircleCenterX > self.frame.size.width / 2 {
            lineEndPointX = lineStartPointX + lineWidth;
            lineEndPointY = lineStartPointY;
            
            numberStartX = lineEndPointX - numberStrSize.width;
            numberStartY = lineEndPointY - numberStrSize.height;
            
            textStartX = lineStartPointX; // 文字右对齐
            textStartY = lineEndPointY;
        } else {
            lineEndPointX = lineStartPointX - lineWidth;
            lineEndPointY = lineStartPointY;
            
            numberStartX = lineEndPointX ;
            numberStartY = lineEndPointY - numberStrSize.height;
            
            textStartX = lineEndPointX;
            textStartY = lineEndPointY;
        }
        
        
        // draw small circle
        let smallCirclePath = UIBezierPath.init(arcCenter: CGPoint(x: smallCircleCenterX, y: smallCircleCenterY),
                                                radius: 4,
                                                startAngle: 0,
                                                endAngle: .pi * 2,
                                                clockwise: true)
        color?.set()
        smallCirclePath.fill()
        smallCirclePath.stroke()
        
        // draw message line
        ctx.beginPath()
        ctx.move(to: CGPoint(x: smallCircleCenterX, y: smallCircleCenterY))
        ctx.addLine(to: CGPoint(x: lineStartPointX, y: lineStartPointY))
        ctx.addLine(to: CGPoint(x: lineEndPointX, y: lineEndPointY))
        ctx.setLineWidth(1)
        ctx.setFillColor((color?.cgColor)!)
        ctx.strokePath()
        
 
        // draw number str above message line
        numberStr.draw(at: CGPoint(x: numberStartX, y: numberStartY),
                       withAttributes: [NSAttributedStringKey.font: kLineMessageStrFont,
                                        NSAttributedStringKey.foregroundColor: kLineMessageStrTextColor])
        
        // draw msg str below message line
        let paragraph = NSMutableParagraphStyle()
        if lineEndPointX < frame.size.width / 2.0 {
            paragraph.alignment = .left
        } else {
            paragraph.alignment = .right
        }
       
        msg.draw(in: CGRect(x: textStartX, y: textStartY, width: lineWidth, height: kLineMessageTextHeight) ,
                 withAttributes: [NSAttributedStringKey.font: kLineMessageStrFont,
                                  NSAttributedStringKey.paragraphStyle: paragraph,
                                  NSAttributedStringKey.foregroundColor: kLineMessageStrTextColor])
    }
    
    //MARK: helper method
    
    /// get the sum of the kLJPieChartNumberKey at every dict in datasource
    func getTotalFromDataSource() -> CGFloat {
        var total: CGFloat = 0
        for item in pieChartDataSource {
            let value = item[kLJPieChartNumberKey] as? CGFloat
            if let numberValue = value {
                total += numberValue
            }
        }
        return total
    }
    
    /// PI * 2 divide the total number
    func getTotalNumberAddPI() -> CGFloat {
        return 2 * .pi / getTotalFromDataSource()
    }
    
    
    /// when the ratios differ too much, increase the smaller number appropriately so that the message line do not overlap
    func getCanShowLineMessageValue(_ value: CGFloat) -> CGFloat {
        if value / getTotalFromDataSource() < kMinimumPercent {
            return value * 3
        }
        
        return value
    }
    
}
