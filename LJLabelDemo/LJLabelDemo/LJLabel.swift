//
//  LJLabel.swift
//  LJLabelDemo
//
//  Created by longjianjiang on 2017/3/7.
//  Copyright © 2017年 Jiang. All rights reserved.
//

import UIKit


enum LJLabelVerticalTextAlignment {
    case center
    case top
    case bottom
}

class LJLabel: UILabel {

    //MARK: property
    open var insets = UIEdgeInsets.zero
    open var verticalTextAligment: LJLabelVerticalTextAlignment = .top
    
    //MARK: helpful method
    func getLabelTextSizeWith(_ constraint: CGSize) -> CGSize {
        let context = NSStringDrawingContext()
        if let text = self.text {
            let labelTextRect = (text as NSString).boundingRect(with: constraint,
                                                                      options: .usesLineFragmentOrigin,
                                                                      attributes: [NSFontAttributeName : self.font],
                                                                      context: context).size
            return CGSize(width: ceil(labelTextRect.width),
                          height: ceil(labelTextRect.height))
        }
       
        return CGSize.zero
        
    }
    //MARK: getter and setter
    @IBInspectable open var topInset: CGFloat {
        set {
            insets.top = newValue
        }
        get {
            return insets.top
        }
    }
    
    @IBInspectable open var leftInset: CGFloat {
        set {
            insets.left = newValue
        }
        get {
            return insets.left
        }
    }
    
    @IBInspectable open var rightInset: CGFloat {
        set {
            insets.right = newValue
        }
        get {
            return insets.right
        }
    }

    @IBInspectable open var bottomInset: CGFloat {
        set {
            insets.bottom = newValue
        }
        get {
            return insets.bottom
        }
    }

    //MARK: init method
    convenience public init(insets: UIEdgeInsets) {
        self.init()
        self.insets = insets
    }
    
    convenience init(frame: CGRect, insets: UIEdgeInsets) {
        self.init(frame: frame)
        self.insets = insets
    }
    
    //MARK: draw method
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
//        return UIEdgeInsetsInsetRect(rect, insets)
//
//        switch verticalTextAligment {
//        case .top:
//            insetsRect.origin.y = bounds.origin.y + insets.top
//        case .bottom:
//            insetsRect.origin.y = bounds.origin.y + insets.top + bounds.size.height - insetsRect.size.height
//        default:
//            insetsRect.origin.y = bounds.origin.y + insets.top + (bounds.size.height - insetsRect.size.height) / 2.0
//        }
//        
//        return insetsRect
        
    }
    
    override func drawText(in rect: CGRect) {
        var insetsRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        
        switch verticalTextAligment {
        case .top:
            insetsRect.origin.y += 0
        case .bottom:
            insetsRect.origin.y += rect.size.height - insetsRect.size.height
        default:
            insetsRect.origin.y += (rect.size.height - insetsRect.size.height) / 2.0
        }
        super.drawText(in: insetsRect)
    }
}
