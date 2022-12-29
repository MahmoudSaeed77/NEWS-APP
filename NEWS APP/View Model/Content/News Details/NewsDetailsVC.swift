//
//  NewsDetailsVC.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var authorAndSourceLbl: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var contentView: UITextView!
    
    //MARK: Varibales
    var articleData: Articles?
    
    
    //MARK: Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLang()
        self.UI()
    }
    
    
    //MARK: Functions
    private func UI() {
        if let article = self.articleData {
            self.title = article.title ?? ""
            self.newsImageView.loadImageWithIndicator(url: article.urlToImage ?? "")
            self.dateLbl.text = "\("Published".localize) \(article.publishedAt ?? "")"
            self.authorAndSourceLbl.text = "\("By".localize) \(self.articleData?.author ?? ""), \(self.articleData?.source?.name ?? "")"
            self.descriptionView.setHTMLFromString(text: article.description ?? "")
            self.contentView.setHTMLFromString(text: article.content ?? "")
        }
    }
    
    
    //MARK: Actions
    @IBAction func openNewsURLAction(_ sender: UIButton) {
        if let articleStringURL = self.articleData?.url {
            self.openURL(url: articleStringURL)
        }
    }
}
