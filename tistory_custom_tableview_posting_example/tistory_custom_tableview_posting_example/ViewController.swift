//
//  ViewController.swift
//  tistory_custom_tableview_posting_example
//
//  Created by 이동건 on 2017. 10. 9..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataList = [[String:String]]()
    
    var city = ["Seoul", "New York", "Tokyo", "Barcelona", "Danang", "London", "Dallas", "Atlanta", "Moscow", "Berlin", "Paris", "Dubai", "Busan"]
    var weather = ["구름 많음", "번개", "눈", "비", "맑음"]
    var imgs = ["clouds.png", "lightning.png", "snowflake.png", "rain.png", "sun.png"]
    
    @IBOutlet weak var customCellTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...city.count - 1 {
            dataList.append(["city":city[index], "weather":weather[index % weather.count], "img":imgs[index % imgs.count]])
        }
        customCellTableView.delegate = self
        customCellTableView.dataSource = self
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CustomCell
        
        var currentCellWeather = dataList[indexPath.row]
        cell.areaLabel.text = currentCellWeather["city"]
        cell.weatherLabel.text = currentCellWeather["weather"]
        cell.weatherImgView.image = UIImage(named: currentCellWeather["img"]!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
}

