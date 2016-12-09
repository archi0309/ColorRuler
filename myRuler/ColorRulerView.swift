//
//  ColorRulerView.swift
//  myRuler
//
//  Created by Kochi Lin on 12/3/16.
//  Copyright © 2016 Kochi Lin. All rights reserved.
//
import UIKit

@IBDesignable
class ColorRulerView: UIView {
  
  var datas = Array(1...271)
  var BigValue =  30
  
  
  override func drawRect(rect: CGRect) {
    
    //Craete Color Ruler
    let colors = [UIColor.blackColor().CGColor,UIColor.greenColor().CGColor,UIColor.orangeColor().CGColor,UIColor.redColor().CGColor]
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let colorLocations:[CGFloat] = [0.0, 0.25, 0.75, 1.0]
    let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x:rect.width, y:0)
    
    let ctx  = UIGraphicsGetCurrentContext()
    
    CGContextSaveGState(ctx)
    
    CGContextAddRect(ctx, CGRectMake(0, rect.height*0.3, rect.width, rect.height))
    
    CGContextClosePath(ctx)
    CGContextClip(ctx)
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint,endPoint, .DrawsAfterEndLocation)
    CGContextRestoreGState(ctx)
    
    
    //create Red line
    let redLine = UIBezierPath()
    redLine.moveToPoint(CGPointMake(0,rect.height*0.05))
    redLine.addLineToPoint(CGPointMake(rect.width,rect.height*0.05))
    UIColor.redColor().setStroke()
    redLine.lineWidth =  2
    redLine.stroke()
    
    
    //    calculate the x
    //    maybe change margin into left margin or right margin to meet user requirement if needed.
    let margin = CGFloat(15)
    let columnXPoint  = { (column:Int) -> CGFloat in
      let gap = (rect.width - margin*2-4) / CGFloat((self.datas.count - 1))
      var x = CGFloat(column) * gap
      x = x+margin + 2
      return x
    }
    
    for i in 0..<datas.count {
      //calculate ruler point and long ruler length by "y: rect.height*0.4"
      var point = CGPoint(x: columnXPoint(i), y: rect.height*0.4)
      point.x = point.x-5.0/2
      point.y = point.y-5.0/2
      
      //create label
      let rulerLabel = UILabel()
      rulerLabel.textColor = UIColor.whiteColor()
      rulerLabel.frame = CGRectMake(point.x, rect.height*0.6, 20, 20)
      rulerLabel.numberOfLines = 1
      rulerLabel.baselineAdjustment = .AlignCenters
      rulerLabel.adjustsFontSizeToFitWidth = true
      let content = NSMutableAttributedString(string:String(i), attributes: [
        NSFontAttributeName: UIFont(name:"Helvetica-Light", size:12)!
        ])
      rulerLabel.backgroundColor = UIColor.clearColor()
      rulerLabel.textAlignment = .Center
      rulerLabel.attributedText = content
      
      switch (i%6,i%30) {
      //create long Ruler
      case (_,0):
        let longRuler  = UIBezierPath()
        longRuler.moveToPoint(CGPointMake(rulerLabel.center.x, rect.height*0.3))
        longRuler.addLineToPoint(CGPointMake(rulerLabel.center.x,rect.height*0.6))
        UIColor.whiteColor().setStroke()
        longRuler.lineWidth = 2
        longRuler.stroke()
        addSubview(rulerLabel)
      //create short Ruler
      case(0,_):
        var point = CGPoint(x: columnXPoint(i), y: rect.height*0.3)
        point.x = point.x-5.0/2
        point.y = point.y-5.0/2
        
        //create short Ruler
        let longRuler  = UIBezierPath()
        longRuler.moveToPoint(CGPointMake(rulerLabel.center.x,rect.height*0.35))
        longRuler.addLineToPoint(CGPointMake(rulerLabel.center.x,rect.height*0.55))
        UIColor.whiteColor().setStroke()
        longRuler.lineWidth = 5
        longRuler.stroke()
        
      default:
        break
      }
      
      if(i == BigValue){
        //create triangle indicator by Big value
        let path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(rulerLabel.center.x-5, 0))
        path.addLineToPoint(CGPointMake(rulerLabel.center.x+5 , 0))
        path.addLineToPoint(CGPoint(x:rulerLabel.center.x, y:rect.height/2.5))
        path.closePath()
        path.lineWidth = 0.5
        
        let fillColor = UIColor.redColor()
        fillColor.set()
        path.fill()
        path.stroke()
        
      }
    }
    
  }
  
  
}


