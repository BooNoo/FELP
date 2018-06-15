//
//  RegionCell.swift
//  coffeMachine_app
//
//  Created by Vladimir Mikhaylov on 22.05.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {
    
    let name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let choseImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20))
        var img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.cMachineRed.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            let rectangle = CGRect(x: 0, y: 0, width: 20, height: 20)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(name)
        addSubview(choseImage)
        NSLayoutConstraint.activate([
            
            choseImage.heightAnchor.constraint(equalToConstant: 10),
            choseImage.widthAnchor.constraint(equalToConstant: 10),
            choseImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            choseImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            name.leftAnchor.constraint(equalTo: choseImage.rightAnchor, constant: 16),
            name.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            ])
    }
    
}
