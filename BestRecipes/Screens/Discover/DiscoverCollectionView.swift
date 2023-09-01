//
//  DiscoverCollectionView.swift
//  BestRecipes
//
//  Created by Владимир on 31.08.2023.
//

import UIKit

class DiscoverCollectionView: UIView {
    
    var collectionView: UICollectionView!
    var navController: UINavigationController!
    let bookmarksManager = BookmarksManager.shared
    
    var recipes: [RecipeInfoForCell] = []
    
    
    init(frame: CGRect, navController: UINavigationController) {
        self.navController = navController
        super.init(frame: frame)
        configureCollection()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        recipes = bookmarksManager.getBookmarks()
        self.collectionView.reloadData()
    }
    
    
    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: DiscoverCell.discoverIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
    }
    
    
    private func setupConstraints() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



extension DiscoverCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCell.discoverIdentifier, for: indexPath) as? DiscoverCell else {
            return UICollectionViewCell()
        }
        cell.liked = true
        cell.favouriteButton.setImage(UIImage(named: "bookmarkSelect"), for: .normal)
        cell.configureCell(recipes[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 20, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController()
        self.navController.pushViewController(recipeDetailVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
