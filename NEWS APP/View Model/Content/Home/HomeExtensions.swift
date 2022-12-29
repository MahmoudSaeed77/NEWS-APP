//
//  HomeExtensions.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import UIKit

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigateToDetailsController(article: self.viewModel.getArticlesData[indexPath.row])
    }
}
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getArticlesCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewsCell") as! HomeNewsCell
        cell.configCell(data: self.viewModel.getArticlesData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel.getArticlesCount - 1) {
            if self.viewModel.totalResults != self.viewModel.getArticlesCount {
                self.viewModel.getHomeNews(page: self.viewModel.page)
            }
        }
    }
}
