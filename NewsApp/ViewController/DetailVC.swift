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
        
        // Data transfer fetch data control
        if newsData != nil {
            imageView.image = UIImage(named: newsData!.newsImageView)
            ownerLabel.text = newsData?.newsOwner
            newsTitle.text = newsData?.newsTitle
            newsDescLabel.text = newsData?.newsDesc
        }
    }
    
    // Go to url site
    @IBAction func newsDetailButtonTapped(_ sender: Any) {
        if newsData != nil {
            let webVC = storyboard?.instantiateViewController(withIdentifier: "WebKitVC") as! WebKitVC
            webVC.url = newsData?.newsUrl
            present(webVC, animated: true)
        }
    }
    
    // Back to home page
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// Data transfer protocol implement
extension DetailVC: DataTransferToDetails {
    
    func newsData(news: NewsModel) {
        self.newsData = news
        print(news.newsTitle)
    }
}
