//
//  HeadlineVC.swift
//  NEWS APP
//
//  Created by Mahmoud Saeed on 29/12/2022.
//

import UIKit
import MOLH

class HeadlineVC: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var languageBtn: UIBarButtonItem!
    
    //MARK: Varibales
    var viewModel: HeadlineVM!
    
    private var refresh = UIRefreshControl()
    
    
    //MARK: Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HeadlineVM(view: self)
        self.configLang()
        self.configureNavigationBar()
        self.configureCollectionView()
        self.configureRefreshControl()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endRefresh()
    }
    
    //MARK: Functions
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    fileprivate func configureRefreshControl() {
        self.collectionView.refreshControl = self.refresh
        self.refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Headline".localize
        self.navigationController?.title = "Headline".localize
    }
    
    private func endRefresh() {
        self.refresh.endRefreshing()
    }
    
    @objc func refreshAction() {
        self.viewModel.getHeadLine(page: 1)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.endRefresh()
            self?.collectionView.reloadData()
        }
    }
    
    func failedGettingData(error: String) {
        self.alert(message: error) {
            self.endRefresh()
        }
    }
    
    
    //MARK: Actions
    @IBAction func languageAction(_ sender: UIBarButtonItem) {
        self.changeLanguageAction()
    }
    
}
