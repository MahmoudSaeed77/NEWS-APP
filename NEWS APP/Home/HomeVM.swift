//
//  HomeVM.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import Foundation
import Alamofire

class HomeVM {
    
    private weak var view: HomeVC!
    
    private var news = [Articles]()
    
    
    var getArticlesCount: Int {
        return self.news.count
    }
    
    var getArticlesData: [Articles] {
        return self.news
    }
    
    var page: Int = 1
    var totalResults: Int = 0
    
    init(view: HomeVC) {
        self.view = view
        self.getHomeNews(page: self.page)
    }
    
    
    func getHomeNews(page: Int) {
        var params: Parameters = [:]
        
        params["pageSize"] = 15
        params["page"] = page
        
        RequestManager.shared.request(urslString: URLs.homeURL, method: .get, params: params) { [weak self] (data: HomeNewsModel?, err) in
            guard self?.view != nil else {return}
            guard err == nil else {
                if let error = err {
                    self?.gettingNewsFailed(error: error.localizedDescription)
                }
                return
            }
            
            if let response = data {
                self?.gettingNewsSuccess(data: response)
            }
            
        }
    }
    
    private func gettingNewsFailed(error: String) {
        self.view.failedGettingData(error: error)
    }
    
    private func gettingNewsSuccess(data: HomeNewsModel) {
        guard data.articles?.isEmpty == false else {return}
        data.articles?.forEach({ [weak self] article in
            self?.news.append(article)
        })
        self.totalResults = data.totalResults ?? 0
        self.view.reloadTableView()
        self.page += 1
    }
}
