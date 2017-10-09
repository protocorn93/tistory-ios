//
//  ViewController.swift
//  tistory_tableview_positng_example
//
//  Created by 이동건 on 2017. 10. 5..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var dataList = [[String:String]]()
    var weather:[String] = ["cloud", "snowflake", "sun", "umbrella", "wind"]
    /*
     보다 편리하게 사용하기 위해 날씨의 종류를 날씨 아이콘 파일명과 일치시켰습니다.
     */
    var area:[String] = ["서울", "뉴욕", "도쿄", "런던", "다낭", "바르셀로나", "파리", "샌프란시스코", "보라카이", "모스크바", "베를린"]

    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for index in 0...area.count-1 {
            dataList.append( [ "area":area[index], "weather":weather[index % weather.count] ] )
        }
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        
        let currentRowOfList = dataList[indexPath.row]
        let currentWeatherInfo = currentRowOfList["weather"]
        
        cell.textLabel?.text = currentRowOfList["area"]
        cell.detailTextLabel?.text = currentWeatherInfo
        
        switch currentWeatherInfo! {
        case "cloud":
            cell.imageView?.image = UIImage(named: "cloud.png")
        case "sun":
            cell.imageView?.image = UIImage(named: "sun.png")
        case "snowflake":
            cell.imageView?.image = UIImage(named: "snowflake.png")
        case "umbrella":
            cell.imageView?.image = UIImage(named: "umbrella.png")
        case "wind":
            cell.imageView?.image = UIImage(named: "wind.png")
        default:
            print("No Match Image")
        }
        return cell
    }
}

