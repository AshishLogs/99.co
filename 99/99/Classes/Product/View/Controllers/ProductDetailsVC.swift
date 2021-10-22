//
//  ProductDetailsVC.swift
//  99
//
//  Created by MegaMind on 22/10/21.
//

import UIKit
import Combine

class ProductDetailsVC: UIViewController {

    var model : ProductDetailsModel?
    
    var disposeBags = Set<AnyCancellable>()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        header()
    }
    
    func registerCells() {
        self.tableview.register(UINib.init(nibName: String(describing: PoductDetailHighlightsTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: PoductDetailHighlightsTableViewCell.self))
        self.tableview.register(UINib.init(nibName: String(describing: ProductDetailsTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: ProductDetailsTableViewCell.self))
        self.tableview.register(UINib.init(nibName: String(describing: ProductDetailsDescriptionTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: ProductDetailsDescriptionTableViewCell.self))
    }
    
    func header() {
        guard let urlString = model?.photo else { return }
        let imageView = UIImageView.init(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 4.0))
        imageView.contentMode = .scaleAspectFill
        imageView.setImage(URL(string: urlString))
        
        let view = UIView.init(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height / 4.0 + 30.0)))
        view.addSubview(imageView)
        self.tableview.tableHeaderView = view
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        debugPrint(String(describing: ProductDetailsVC.self))
    }

}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension ProductDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: PoductDetailHighlightsTableViewCell.self)) as? PoductDetailHighlightsTableViewCell else { return UITableViewCell() }
            cell.viewMap.sink { [weak self] (value) in
                guard let lattitude = self?.model?.address?.mapCoordinates?.lat,
                      let longitude = self?.model?.address?.mapCoordinates?.lng else { return }
                let url = "http://maps.apple.com/maps?saddr=\(lattitude),\(longitude)"
                guard let mapURL = URL.init(string: url) else { return }
                UIApplication.shared.open(mapURL, options: [:], completionHandler: nil)
                self?.disposeBags.removeAll()
            }.store(in: &disposeBags)
            cell.wrapView(model: model)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ProductDetailsTableViewCell.self)) as? ProductDetailsTableViewCell else { return UITableViewCell() }
            cell.wrapView(model: model)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ProductDetailsDescriptionTableViewCell.self)) as? ProductDetailsDescriptionTableViewCell else { return UITableViewCell() }
            cell.wrapView(desc: model?.detailsDescription)
            return cell
        }
    }
    
}
