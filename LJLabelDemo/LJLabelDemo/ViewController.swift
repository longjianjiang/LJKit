//
//  ViewController.swift
//  LJLabelDemo
//
//  Created by longjianjiang on 2017/3/15.
//  Copyright © 2017年 Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var customLabel: LJLabel = {
        let label = LJLabel(frame:  CGRect(x: 0, y: 20, width: 300, height: 190),
                            insets: UIEdgeInsetsMake(0, 0, 0, 0))
        label.verticalTextAligment = .top
        label.backgroundColor = UIColor.orange
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(customLabel)
    
        print(customLabel.getLabelTextSizeWith(CGSize(width: 300.0, height: 10000.0)))
    }


}

