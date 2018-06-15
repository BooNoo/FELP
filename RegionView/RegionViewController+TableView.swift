//
//  RegionViewController+TableView.swift
//  coffeMachine_app
//
//  Created by Vladimir Mikhaylov on 22.05.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import UIKit

extension RegionViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCellId", for: indexPath) as! RegionCell
        cell.name.text = regions[indexPath.row].name
        cell.selectionStyle = .none
        if (regions[indexPath.row].id == store.regionId) {
            cell.choseImage.isHidden = false
        } else {
            cell.choseImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (store.regionId != regions[indexPath.row].id) {
            let cartItems = realmController.GetAllCartItem().count
            if (cartItems > 0) {
                addAlertForClearCart(regionId: regions[indexPath.row].id)
            } else {
                storeController.setRegion(regionId: regions[indexPath.row].id)
            }
        }
    }
    
}
