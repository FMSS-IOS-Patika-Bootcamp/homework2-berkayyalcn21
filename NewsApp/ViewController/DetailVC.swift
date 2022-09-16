//
//  DetailVC.swift
//  NewsApp
//
//  Created by Berkay on 16.09.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescLabel: UITextView!
    var newsData: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newsData != nil {
            imageView.image = UIImage(named: newsData!.newsImageView)
            ownerLabel.text = newsData?.newsOwner
            newsTitle.text = newsData?.newsTitle
            newsDescLabel.text = newsData?.newsDesc
        }
    }
    
    @IBAction func newsDetailButtonTapped(_ sender: Any) {
        if newsData != nil {
            let webVC = storyboard?.instantiateViewController(withIdentifier: "WebKitVC") as! WebKitVC
            webVC.url = newsData?.newsUrl
            present(webVC, animated: true)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailVC: DataTransferToDetails {
    
    func newsData(news: NewsModel) {
        self.newsData = news
        print(news.newsTitle)
    }
}
