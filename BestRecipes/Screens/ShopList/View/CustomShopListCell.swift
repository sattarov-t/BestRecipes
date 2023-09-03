//
//  CustomShopListCell.swift
//  BestRecipes
//
//  Created by Анастасия Рыбакова on 03.09.2023.
//

import UIKit

class CustomShopListCell: UITableViewCell {
    

    
// MARK: - User Interface
    
    private lazy var ingrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var ingrNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ingredient name"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ingrAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "200 gr"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    

    
    

// MARK: - Override required methodes
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

// MARK: - methode to put information into the cell
    func setDataIntocell(imageName: String, name: String, amount: String) {
        ingrImageView.image = UIImage(named: imageName)
        ingrNameLabel.text = name
        ingrAmountLabel.text = amount
    }
   
    
}



// MARK: - extensions _ setup cell and constraints
extension CustomShopListCell {
    private func setupCell() {
        self.backgroundColor = .systemGray6
        
        self.addSubview(ingrImageView)
        self.addSubview(ingrNameLabel)
        self.addSubview(ingrAmountLabel)
    }
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            ingrImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingrImageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            ingrImageView.heightAnchor.constraint(equalToConstant: 60),
            ingrImageView.widthAnchor.constraint(equalToConstant: 60),
            

            ingrAmountLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            ingrAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ingrNameLabel.leadingAnchor.constraint(equalTo: ingrImageView.trailingAnchor, constant: 10),
            ingrNameLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            ingrNameLabel.trailingAnchor.constraint(equalTo: ingrAmountLabel.leadingAnchor, constant: -20),
                                                   
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}