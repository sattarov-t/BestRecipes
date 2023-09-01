//
//  CategoriesCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class CategoriesCollectionView: UIView {

    var collectionView: UICollectionView!
    let bookmarksManager = BookmarksManager.shared

    weak var parentViewController: HomeViewController?

  var recipes: [Recipe] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  var recipeFullInfo: [RecipeInfoForCell] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        addSubview(collectionView)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Extensions
extension CategoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeFullInfo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let selectedRecipe = recipeFullInfo[indexPath.row]
        if bookmarksManager.bookmarksArray.contains(selectedRecipe) {
            cell.liked = true
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        cell.configureCell(recipeFullInfo[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let parentViewController = parentViewController else {
//            return
//        }
//
//        let selectedArticle = recipes[indexPath.row]
//        let vc = DetailedViewController()
//        vc.configureScreen(selectedArticle: selectedArticle)
//        vc.modalPresentationStyle = .fullScreen
//        parentViewController.present(vc, animated: true)
//    }
}
