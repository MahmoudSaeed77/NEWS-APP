//
//  HeadlineCell.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import UIKit

class HeadlineCell: UICollectionViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configLang()
        self.contentView.layer.borderColor = UIColor.separator.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 16
    }
    
    func configCell(data: Articles) {
        self.newsImageView.loadImageWithIndicator(url: data.urlToImage ?? "")
        self.authorLbl.text = data.author ?? ""
        self.titleLbl.text = data.title ?? ""
    }
}
