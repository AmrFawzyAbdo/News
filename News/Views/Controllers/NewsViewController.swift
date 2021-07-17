//
//  NewsViewController.swift
//  News
//
//  Created by RKAnjel on 7/15/21.
//

import UIKit
import Kingfisher

enum screenStyle {
    case search
    case all
}

class NewsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var tryBtn: UIButton!

    //MARK:- Variables
    var news = [Article]()
    var currentPage = 1
    var totalPages = 5
    var currentStyle : screenStyle = .all
    var fromScrolling : Int?

    //MARK:- Constants
    let refreshControl = UIRefreshControl()
    let progressHUD = ProgressHUD(text: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        radius()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }

    func radius() {
        tryBtn.layer.cornerRadius = 10
    }

    override func viewWillAppear(_ animated: Bool) {
        getAllNews()
    }

    
    @objc func refresh(_ sender: AnyObject) {
        callWhichAPI()
        refreshControl.endRefreshing()
    }

    
    //MARK:- Search button
    @IBAction func search(_ sender: Any) {
        currentStyle = .search
        callWhichAPI()
    }

    //MARK:- Get news according to current state
    func callWhichAPI(){

        if searchTF.text != "" {
            if fromScrolling == 3 {
                getSearchedNews()
                fromScrolling = 0
            }else{
            currentPage = 1
            totalPages = 5
            self.news.removeAll()
            self.tableView.reloadData()
            currentStyle = .search
            getSearchedNews()
            }
        }
        else{
            if fromScrolling == 2 {
                getAllNews()
                fromScrolling = 0
            }else{
            currentPage = 1
            totalPages = 5
            self.news.removeAll()
            self.tableView.reloadData()
            currentStyle = .all
            getAllNews()
        }
        }

    }
    
    //MARK:- Get all news
    func getAllNews(){
        self.view.addSubview(progressHUD)

        if Reachability.isConnectedToNetwork(){
            noInternetView.isHidden = true
            tableView.isHidden = false


        APIClient().getNews(page: self.currentPage){ (res) in
            self.progressHUD.removeFromSuperview()

            self.news.append(contentsOf: res)
            self.tableView.reloadData()
            
            self.currentPage += 1
            
        } onError: { (error) in
            self.progressHUD.removeFromSuperview()
            self.showAlertController(title: "Error!", message: error, actions: [])
        }
        }else{
            self.progressHUD.removeFromSuperview()
            tableView.isHidden = true
            noInternetView.isHidden = false
        }
    }
    
    //MARK:- Get searched news
    func getSearchedNews(){
        self.view.addSubview(progressHUD)

        if Reachability.isConnectedToNetwork(){
            noInternetView.isHidden = true
            tableView.isHidden = false


        APIClient().getNewsSearch(page: self.currentPage, qInTitle: searchTF.text ?? "") { (res) in

            self.progressHUD.removeFromSuperview()

            if res.count == 0 {
                self.showToast(message: "No data founded", font: .systemFont(ofSize: 16))
            }else{
                self.news.append(contentsOf: res)
                self.tableView.reloadData()
                
                self.currentPage += 1
                
            }
        } onError: { (error) in
            self.progressHUD.removeFromSuperview()
            self.showAlertController(title: "Error!", message: error, actions: [])
        }
        }else{
            self.progressHUD.removeFromSuperview()
            tableView.isHidden = true
            noInternetView.isHidden = false
        }
    }

    
    @IBAction func tryAgain(_ sender: Any) {
        if currentStyle == .all{
        getAllNews()
        }else{
            getSearchedNews()
        }
    }
    
    
}

//MARK:- TableView datasource and delegate
extension NewsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        let urlEnds = news[indexPath.row].urlToImage
        let lastThree = urlEnds?.contains("jpg")

        if news[indexPath.row].urlToImage == nil || lastThree != true {
            cell.newsImage?.image = UIImage(named: "newsImage")
        }else{
            cell.newsImage.kf.indicatorType = .activity
            cell.newsImage.kf.setImage(with: URL(string: news[indexPath.row].urlToImage ?? ""))
        }
        cell.titleLbl.text = "Title: \(news[indexPath.row].title ?? "")"
        cell.sourceLbl.text = "Source: \(news[indexPath.row].author ?? "")"
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        newViewController.passedNews = news[indexPath.row]
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }


    //MARK:- For pagination setup
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if currentStyle == .all {
            let count = self.news.count
            if indexPath.row == count - 3 {
                if currentPage <= self.totalPages {
                    fromScrolling = 2
                    callWhichAPI()
                }
            }
        }else{
            let count = self.news.count
            if indexPath.row == count - 3 {
                if currentPage <= self.totalPages {
                    fromScrolling = 3
                    callWhichAPI()
                }
            }
        }
    }
    
    
    
}

