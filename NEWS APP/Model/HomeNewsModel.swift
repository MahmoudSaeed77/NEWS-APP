//
//  HomeNewsModel.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import Foundation

struct HomeNewsModel : Codable {
    var status : String?
    var totalResults : Int?
    var articles : [Articles]?
}

struct Articles : Codable {
    var source : Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
}
struct Source : Codable {
    var id : String?
    var name : String?
}
