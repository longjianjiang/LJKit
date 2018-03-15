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
        
       
        let ele1 = LJPieChartElement(color: .red, number: 100.01, title: "通讯")
        let ele2 = LJPieChartElement(color: .cyan, number: 237.35, title: "交通出行")
        let ele3 = LJPieChartElement(color: .brown, number: 360, title: "生活日用")
        let ele4 = LJPieChartElement(color: .orange, number: 108.27, title: "其他")
        let ele5 = LJPieChartElement(color: .purple, number: 291.52, title: "饮食")
        
        let dataSource = [ele1, ele2, ele3, ele4, ele5]
        
        chart.setPieChartType(.round, dataSource: dataSource, radius: 80, roundWidth: 35)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

