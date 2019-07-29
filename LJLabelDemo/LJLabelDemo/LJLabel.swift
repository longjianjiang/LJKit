//
//  LJLabel.swift
//  LJLabelDemo
//
//  Created by longjianjiang on 2017/3/7.
//  Copyright © 2017年 Jiang. All rights reserved.
//

import UIKit

public enum LJLabelVerticalTextAlignment {
    case center
    case top
    case bottom
}

public class LJLabel: UILabel {

    //MARK: property
    private var insets: UIEdgeInsets
    public var verticalTextAligment: LJLabelVerticalTextAlignment = .top
    
    //MARK: helpful method
    public func getLabelTextSizeWith(_ constraint: CGSize) -> CGSize {
        let context = NSStringDrawingContext()
        if let text = self.text {
            let labelTextRect = (text as NSString).boundingRect(with: constraint,
                                                                      options: .usesLineFragmentOrigin,
                                                                      attributes: [NSAttributedString.Key.font : self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)],
                                                                      context: context).size
            return CGSize(width: ceil(labelTextRect.width),
                          height: ceil(labelTextRect.height))
        }
        
        return CGSize.zero
    }

    //MARK: getter and setter
    @IBInspectable public var topInset: CGFloat {
        set {
            insets.top = newValue
        }
        get {
            return insets.top
        }
    }
    
    @IBInspectable public var leftInset: CGFloat {
        set {
            insets.left = newValue
        }
        get {
            return insets.left
        }
    }
    
    @IBInspectable public var rightInset: CGFloat {
        set {
            insets.right = newValue
        }
        get {
            return insets.right
        }
    }

    @IBInspectable public var bottomInset: CGFloat {
        set {
            insets.bottom = newValue
        }
        get {
            return insets.bottom
        }
    }

    //MARK: init method
    public init(insets: UIEdgeInsets = .zero) {
        self.insets = insets

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: draw method
    private func getUpdatedRect(_ rect: CGRect) -> CGRect {
        let insetsRect = rect.inset(by: insets)
        return CGRect(x: insetsRect.minX, y: insets.top, width: rect.width+insets.left+insets.right, height: rect.height+insets.top+insets.bottom)
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        if insets.top < 0 || insets.right < 0 || insets.bottom < 0 || insets.left < 0 {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }

        return super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
    }
    
    override public func drawText(in rect: CGRect) {
        var insetsRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        
        if rect.height > insetsRect.height+insets.top+insets.bottom {
            let margin = (rect.size.height - insetsRect.size.height) - insets.top - insets.bottom
            switch verticalTextAligment {
            case .top:
                insetsRect.origin.y += 0
            case .bottom:
                insetsRect.origin.y += margin
            case .center:
                insetsRect.origin.y += margin / 2.0
            }
        }

        // if use autolayout, then set vertical inset, we just ignore inset,
        // if not content will not be displayed completely.
        if insetsRect.minY == -0 || insetsRect.minY < insets.top {
            print("no more space to display")
            super.drawText(in: rect)
            return
        }
        
        super.drawText(in: insetsRect)
    }

}
