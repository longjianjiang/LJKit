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
        let label = LJLabel(insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.verticalTextAligment = .top
        label.backgroundColor = UIColor.orange
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:This is a dynamic programming[1] question. Usually, solving and fully understanding a dynamic programming problem is a 4 step process:=>>>>>>>>>>>>>>>"
        return label
    }()
    //(0.0, 0.0, 335.0, 150.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        customLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width-40, height: 180)
        view.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            customLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 90)
        ])

        print(customLabel.getLabelTextSizeWith(CGSize(width: 300.0, height: 10000.0)))
    }


}

