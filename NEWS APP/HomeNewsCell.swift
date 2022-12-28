//
//  HomeNewsCell.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit

class HomeNewsCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configCell(data: Articles) {
        self.newsImageView.loadImageWithIndicator(url: data.urlToImage ?? "")
        self.authorLbl.text = data.author ?? ""
        self.titleLbl.text = data.title ?? ""
        self.dateLbl.text = data.publishedAt ?? ""
        self.descriptionTextView.setHTMLFromString(text: data.description ?? "")
    }
}
