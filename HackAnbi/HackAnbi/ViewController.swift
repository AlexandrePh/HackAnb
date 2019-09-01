//
//  ViewController.swift
//  HackAnbi
//
//  Created by Alexandre Philippi on 01/09/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    let pieChartView:PieChartView = {
       let chart = PieChartView()
        
        return chart
    }()
    let lineChartView:LineChartView = {
        let view  = LineChartView()
        
       
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubviewsUsingAutoLayout(pieChartView,lineChartView)
        setupLayout()
        setupLineChartView(vec: dados)
        setupPieChartView(x:dados.last!)
        
    }
    func setupLayout(){
        let layoutGuide = view.safeAreaLayoutGuide
        pieChartView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 20).isActive = true
        
        pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pieChartView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 0).isActive = true
        pieChartView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: 0).isActive = true
        pieChartView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        lineChartView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 20).isActive = true
        
        lineChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lineChartView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 0).isActive = true
        lineChartView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: 0).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    func setupLineChartView(vec:[CompiladoSuitability]){
        
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        var dataEntries3: [ChartDataEntry] = []
        var data = LineChartData()
        lineChartView.delegate = self
        for i in 0..<vec.count {
            let dataEntry1 = ChartDataEntry(x: Double(i) , y: Double(vec[i].arrojadoVolCotas))
            dataEntries1.append(dataEntry1)
            let dataEntry2 = ChartDataEntry(x: Double(i) , y: Double(vec[i].moderadoVolCotas))
            dataEntries2.append(dataEntry2)
            let dataEntry3 = ChartDataEntry(x: Double(i) , y: Double(vec[i].conservadorVolCotas))
            dataEntries3.append(dataEntry3)
            
            
        }
//        lineChartView.co
        let linSetData = LineChartDataSet(values: dataEntries1, label: "arrojado")
        
        let linSetData2 = LineChartDataSet(values: dataEntries2, label: "moderado")
        let linSetData3 = LineChartDataSet(values: dataEntries3, label: "conservador")
        
        linSetData.colors = [.red]
        linSetData2.colors = [.yellow]
        linSetData3.colors = [.green]
        
        data.addDataSet(linSetData)
        data.addDataSet(linSetData2)
        data.addDataSet(linSetData3)
        
        
        
        lineChartView.data = data
        
    }
    
    func setupPieChartView(x:CompiladoSuitability) {
        var dataEntries: [ChartDataEntry] = []
        
        pieChartView.holeRadiusPercent = 0.3
        let dataEntry1 = PieChartDataEntry(value: Double(x.arrojadoVolCotas), label: "arrojado", data:  "arrojado" as AnyObject)
        let dataEntry2 = PieChartDataEntry(value: Double(x.moderadoVolCotas), label: "moderado", data:  "moderado" as AnyObject)
        let dataEntry3 = PieChartDataEntry(value: Double(x.arrojadoVolCotas), label: "conservador", data:  "conservador" as AnyObject)
        dataEntries.append(dataEntry1)
        dataEntries.append(dataEntry2)
        dataEntries.append(dataEntry3)
        
        pieChartView.backgroundColor = .clear
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = [.green,.yellow,.red]
        pieChartView.holeColor = .clear
        pieChartView.entryLabelColor = .black
        
        pieChartDataSet.valueLineColor = .black
        pieChartDataSet.entryLabelColor = .black
        pieChartDataSet.valueColors = [.black]
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        pieChartView.usePercentValuesEnabled = true
        
        // 4. Assign it to the chart's data
        pieChartView.data = pieChartData
    }
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    


}

extension ViewController : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        if chartView is LineChartView{
            
            for dado in dados {
                print(entry.x)
                if Double(dado.tempo.mes) == entry.x {
                    setupPieChartView(x:dado)
                }
            }
            
        }
    }
}

