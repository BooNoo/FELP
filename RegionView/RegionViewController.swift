//
//  RegionController.swift
//  coffeMachine_app
//
//  Created by Vladimir Mikhaylov on 22.05.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import UIKit
import RealmSwift

class RegionViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    lazy var closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.setImage(UIImage(named: "button_check"), for: .normal)
        button.setImage(UIImage(named: "button_check_white"), for: .disabled)
        return button
    }()
    
    lazy var tableView: UITableView = {
        var tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(RegionCell.self, forCellReuseIdentifier: "RegionCellId")
        tv.tableFooterView = UIView()
        return tv
    }()
    
    let topInfoView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let infoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let realmController = RealmController()
    let storeController = StoreController()
    var store: Store = Store()
    var storeToken : NotificationToken?
    var regions = [Region]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autolayout()
        loadData()
        setLabel()
    }
    
    func autolayout() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(topInfoView)
        view.addSubview(tableView)
        
        topInfoView.addSubview(infoLabel)
        
        if #available(iOS 11.0, *) {
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
            topInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
            topInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        }
        
        NSLayoutConstraint.activate([
            
            topInfoView.heightAnchor.constraint(equalToConstant: 80),
            topInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            topInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            
            infoLabel.topAnchor.constraint(equalTo: topInfoView.topAnchor, constant: 8),
            infoLabel.bottomAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: -8),
            infoLabel.leftAnchor.constraint(equalTo: topInfoView.leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: topInfoView.rightAnchor, constant: -8),
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -16),
            
            closeButton.heightAnchor.constraint(equalToConstant: 80),
            closeButton.widthAnchor.constraint(equalToConstant: 80),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            
            ])
    }
    
    func loadData() {
        regions = realmController.GetNotDeletedRegions()
        setStore()
        updateData()
    }
    
    func setStore() {
        guard let unwarpedStore = storeController.get()  else { return }
        store = unwarpedStore
        setNotification(store: store)
    }
    
    func setLabel() {
        infoLabel.text = "Укажите ваш регион, чтобы мы сформировали общее меню для вас:"
    }
    
    func updateData() {
        self.tableView.reloadData()
        if (store.regionId == "") {
            closeButton.isEnabled = false
        } else {
            closeButton.isEnabled = true
        }
    }
    
    func setNotification(store: Store) {
        storeToken = store.observe({ change in
            switch change {
            case .change(_):
                self.updateData()
            case .error(let error):
                print("An error occurred: \(error)")
            case .deleted:
                print("The object was deleted.")
            }
        })
    }
    
    func addAlertForClearCart(regionId: String) {
        let alertController = UIAlertController(title: "Ваша корзина будет очищена", message: "Очистить корзину?", preferredStyle: UIAlertControllerStyle.alert)
        let DestructiveAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
        }
        let okAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            self.realmController.clearCart()
            if (self.store.regionId != regionId) {
                self.storeController.setRegion(regionId: regionId)
            }
            NotificationCenter.default.post(name: Notification.Name.cartIsUpdate, object: nil)
        }
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        storeToken?.invalidate()
    }
}
