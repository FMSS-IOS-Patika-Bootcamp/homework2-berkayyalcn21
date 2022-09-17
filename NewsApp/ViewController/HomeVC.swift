//
//  HomeVC.swift
//  NewsApp
//
//  Created by Berkay on 16.09.2022.
//

import UIKit

// Data transfer HomeVC to DetailVC
protocol DataTransferToDetails {
    func newsData(news: NewsModel)
}

class HomeVC: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    // For category collectionView
    let categories: [String] = ["Tümü", "Politika", "Spor", "Teknoloji", "Bilim"]
    private let categoryCellIdentifier = "categoryCellIdentifier"
    private let newsCellIdentifier = "newsCellIdentifier"
    var index = 0
    var dataTransfer: DataTransferToDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        registerCells()
    }
    
    // CollectionView cells register
    private func registerCells() {
        categoryCollectionView.register(.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: categoryCellIdentifier)
        newsCollectionView.register(.init(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: newsCellIdentifier)
    }
}

// CollectionView Delegate Implement
extension HomeVC: UICollectionViewDelegate {
    // When tapped to cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            index = indexPath.row
            collectionView.reloadData()
        }else {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = story.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            detailVC.modalPresentationStyle = .fullScreen
            dataTransfer = detailVC
            dataTransfer?.newsData(news: News.newsList[indexPath.row])
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// CollectionView DataSource Implement
extension HomeVC: UICollectionViewDataSource {
    
    // As many rows as the number of lists
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }
        return News.newsList.count
    }
    
    // Line content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.categoryLabel.text = category
            if indexPath.row == index {
                cell.bgView.backgroundColor = UIColor(named: "Bg Color")
                cell.bgView.alpha = 1
                cell.categoryLabel.textColor = .white
            }else {
                cell.categoryLabel.textColor = UIColor(named: "CategoryTextColor")
                cell.bgView.alpha = 0
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellIdentifier, for: indexPath) as! NewsCollectionViewCell
        let news = News.newsList[indexPath.row]
        cell.imageView.image = UIImage(named: news.newsImageView)
        cell.newsTitle.text = news.newsTitle
        cell.newsDate.text = news.newsDate
        return cell
    }
}

// CollectionView size settings
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    // Edge dimensions size settings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView {
            return .zero
        }
        return UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 15)
    }
    
    // Binary alignment size settings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return .init(width: 90, height: 41)
        }
        return .init(width: (collectionView.frame.width - 40) / 2, height: 223)
    }
    
    // Line gap size settings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return .zero
        }
        return 30
    }
}
