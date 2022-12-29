//
//  HeadlineExtensions.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import UIKit

extension HeadlineVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2) - 20, height: 320)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.openURL(url: self.viewModel.getArticlesData[indexPath.item].url ?? "")
    }
}
extension HeadlineVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getArticlesCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineCell", for: indexPath) as! HeadlineCell
        cell.configCell(data: self.viewModel.getArticlesData[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel.getArticlesCount - 1) {
            if self.viewModel.totalResults != self.viewModel.getArticlesCount {
                self.viewModel.getHeadLine(page: self.viewModel.page)
            }
        }
    }
}
