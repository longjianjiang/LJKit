//
//  ViewController.swift
//  LJPieChartDemo
//
//  Created by zl on 2018/3/13.
//  Copyright © 2018年 longjianjiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let chart = LJPieChart()
        chart.backgroundColor = UIColor.white
        chart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chart)
        
        chart.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        chart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
       
        let dict = [ [kLJPieChartNumberKey: (CGFloat)(10.0),
                      kLJPieChartTitleKey: "A",
                      kLJPieChartColorKey: UIColor.red],
                     
                     [kLJPieChartNumberKey: (CGFloat)(6.0),
                      kLJPieChartTitleKey: "B",
                      kLJPieChartColorKey: UIColor.green],
                     
                     [kLJPieChartNumberKey: (CGFloat)(2.0),
                      kLJPieChartTitleKey: "C",
                      kLJPieChartColorKey: UIColor.yellow],

                     [kLJPieChartNumberKey: (CGFloat)(3.0),
                      kLJPieChartTitleKey: "D",
                      kLJPieChartColorKey: UIColor.orange],

                     [kLJPieChartNumberKey: (CGFloat)(5.0),
                      kLJPieChartTitleKey: "E",
                      kLJPieChartColorKey: UIColor.purple]
                  ]
        
        chart.setPieChartType(.arc, dataSource: dict, radius: 80)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

