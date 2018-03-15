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
        
       
        let ele1 = LJPieChartElement(color: .red, number: 100, title: "AAA")
        let ele2 = LJPieChartElement(color: .cyan, number: 5, title: "BBB")
        let ele3 = LJPieChartElement(color: .brown, number: 250, title: "CCC")
        let ele4 = LJPieChartElement(color: .orange, number: 70.0, title: "DDD")
        let ele5 = LJPieChartElement(color: .purple, number: 300, title: "EEE")
        
        let dataSource = [ele1, ele2, ele3, ele4, ele5]
        
        chart.setPieChartType(.arc, dataSource: dataSource, radius: 80)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

