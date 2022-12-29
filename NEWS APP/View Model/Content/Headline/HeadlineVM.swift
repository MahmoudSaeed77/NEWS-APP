//
//  HeadlineVM.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import Foundation
import Alamofire
import MOLH

class HeadlineVM {
    
    
    //MARK: Varibales
    private weak var view: HeadlineVC!
    
    private var news = [Articles]()
    
    var getArticlesCount: Int {
        return self.news.count
    }
    
    var getArticlesData: [Articles] {
        return self.news
    }
    
    var page: Int = 1
    
    var totalResults: Int = 0
    
    
    //MARK: Initialization
    init(view: HeadlineVC) {
        self.view = view
        self.getHeadLine(page: self.page)
    }
    
    
    
    //MARK: API Requests
    func getHeadLine(page: Int) {
        var params: Parameters = [:]
        
        params["pageSize"] = 15
        params["page"] = page
        
        let url = "\(URLs.headlineURL)\(MOLHLanguage.currentAppleLanguage())"
        
        RequestManager.shared.request(urslString: url, method: .get, params: params) { [weak self] (data: HomeNewsModel?, err) in
            guard self?.view != nil else {return}
            guard err == nil else {
                if let error = err {
                    self?.gettingHeadlineFailed(error: error.localizedDescription)
                }
                return
            }
            
            if let response = data {
                self?.gettingHeadlineSuccess(data: response)
            }
            
        }
    }
    
    
    //MARK: Actions Functions
    private func gettingHeadlineFailed(error: String) {
        self.view.failedGettingData(error: error)
    }
    
    private func gettingHeadlineSuccess(data: HomeNewsModel) {
        guard data.articles?.isEmpty == false else {return}
        data.articles?.forEach({ [weak self] article in
            self?.news.append(article)
        })
        self.totalResults = data.totalResults ?? 0
        self.view.reloadCollectionView()
        self.page += 1
    }
}
