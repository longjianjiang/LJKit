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
                            insets: UIEdgeInsetsMake(50, 5, 0, 10))
        label.verticalTextAligment = .top
        label.backgroundColor = UIColor.orange
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(customLabel)
        
        
    }


}

