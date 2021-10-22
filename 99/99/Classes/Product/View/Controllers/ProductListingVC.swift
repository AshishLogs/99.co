//
//  ProductListingVC.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import UIKit
import Combine

class ProductListingVC: UIViewController {
    
    let viewModel = ProductListViewModel()
    
    var lists : ProductLists = []
    
    var disposeBags = Set<AnyCancellable>()

    var titleLabel : UILabel {
        let title = UILabel(frame: .init(x: 0, y: 0, width: 80.0, height: 22))
        title.text = "Search Results"
        title.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0)
        title.textColor = UIColor(red: 26.0/255.0, green: 34.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        return title
    }

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellName = String(describing: ProductListCell.self)
        self.tableview.register(UINib.init(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)

        self.navigationItem.titleView = titleLabel
        
        viewModel.getProductList()

        viewModel.products.sink { [weak self] (value) in
            self?.lists = value
            self?.tableview.reloadData()
            self?.disposeBags.removeAll()
        }.store(in: &disposeBags)
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource
extension ProductListingVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductListCell.self)) as? ProductListCell
        cell?.wrapView(model: lists[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.lists[indexPath.row].id
        self.viewModel.getProductDetails(id: "\(id)")
        viewModel.productDetail.sink { [weak self] (value) in
            guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: String(describing: ProductDetailsVC.self)) as? ProductDetailsVC else { return }
            vc.model = value
            vc.modalPresentationStyle = .overFullScreen
            self?.navigationController?.present(vc, animated: true, completion: nil)
            self?.disposeBags.removeAll()
        }.store(in: &disposeBags)
    }
    
}
