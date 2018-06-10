//
//  APIService.swift
//  Advanced Generics
//
//  Created by 이동건 on 10/06/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import Foundation
import Alamofire

enum APIUrl:String {
    case homeFeed = "https://api.letsbuildthatapp.com/youtube/home_feed"
    case courseDetail = "https://api.letsbuildthatapp.com/youtube/course_detail?id="
}

class APIService {
    static let shared = APIService()
    private init(){}
    
    func fetch<T: Decodable>(url:URL?, completion: @escaping (T)->()){
        guard let url = url else {return}
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {return}
            do{
                guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {return}
                completion(decodeData)
            }
        }
    }
    
    func fetchHomeFeed(url:URL?, completion: @escaping (HomeFeed)->()) {
        guard let url = url else {return}
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {return}
            do{
                guard let homeFeeds = try? JSONDecoder().decode(HomeFeed.self, from: data) else {return}
                completion(homeFeeds)
            }
        }
    }
    
    func fetchCourseDetails(url: URL?, completion: @escaping ([CourseDetail])->()) {
        guard let url = url else {return}
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {return}
            do{
                guard let courseDetails = try? JSONDecoder().decode([CourseDetail].self, from: data) else {return}
                completion(courseDetails)
            }
        }
    }
}
