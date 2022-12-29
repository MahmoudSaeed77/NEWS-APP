//
//  HomeVC.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit
import MOLH

class HomeVC: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageBtn: UIBarButtonItem!
    
    //MARK: Varibales
    var viewModel: HomeVM!
    
    private var refresh = UIRefreshControl()
    
    
    //MARK: Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeVM(view: self)
        self.configLang()
        self.configureTableView()
        self.configureRefreshControl()
        self.configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endRefresh()
    }
    
    
    //MARK: Functions
    private func configureTableView() {
        self.tableView.register(UINib(nibName: "HomeNewsCell", bundle: .main), forCellReuseIdentifier: "HomeNewsCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    fileprivate func configureRefreshControl() {
        self.tableView.refreshControl = self.refresh
        self.refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home".localize
        self.navigationController?.title = "Home".localize
    }
    
    private func endRefresh() {
        self.refresh.endRefreshing()
    }
    
    @objc func refreshAction() {
        self.viewModel.getHomeNews(page: 1)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.endRefresh()
            self?.tableView.reloadData()
        }
    }
    
    func failedGettingData(error: String) {
        self.alert(message: error) {
            self.endRefresh()
        }
    }
    
    func navigateToDetailsController(article: Articles) {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
            vc.articleData = article
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: Actions
    @IBAction func languageAction(_ sender: UIBarButtonItem) {
        self.changeLanguageAction()
    }
    
}
