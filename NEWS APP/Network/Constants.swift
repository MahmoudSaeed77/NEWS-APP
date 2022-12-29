//
//  Constants.swift
//  EASYCARCLIENT
//
//  Created by Mahmoud Saeed on 01/12/2022.
//

import Foundation
import Alamofire

struct URLs {
    
    
    public static var baseURL = "https://newsapi.org/v2/"
    
//    public static var apiKey = "6a44c8208985423aa11c56081abc858b"
    public static var apiKey = "db134fba0c9546028b6b834a5c925011"
    public static var homeURL = "\(baseURL)everything?q=bitcoin&apiKey=\(apiKey)&language="
    public static var headlineURL = "\(baseURL)top-headlines?country=us&apiKey=\(apiKey)&language="
    
    //MARK:- Headers
    public static func userHeader() -> HTTPHeaders {
        var header = HTTPHeaders()
        header = [
            "Accept":"application/json",
            "language":"\(UserDefaults.standard.value(forKey: "lang") as? String ?? "en")"
        ]
        return header
    }
}
