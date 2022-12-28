//
//  HomeVC.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeVM(view: self)
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.tableView.register(UINib(nibName: "HomeNewsCell", bundle: .main), forCellReuseIdentifier: "HomeNewsCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failedGettingData(error: String) {
        self.alert(message: error) {
            
        }
    }
}
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
