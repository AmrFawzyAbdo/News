//
//  NewsDetailsViewController.swift
//  News
//
//  Created by RKAnjel on 7/15/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var articleDetailsImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var authLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var openUrlBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sourceHeaderLbl: UILabel!
    
    //MARK:- Variables
    var passedNews : Article?
    var imagesss : UIImage?
    var lastImageView:UIImageView?
    var originalFrame:CGRect!
    var isDoubleTap:ObjCBool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        radius()
        //MARK:- Tap image
        articleDetailsImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showZoomImageView(tap:)))
        self.articleDetailsImage.addGestureRecognizer(tap)
    }
    
    //MARK:- Set data to textfields and image
    func setData() {
        titleLbl.text = "Title: \(passedNews?.title ?? "")"
        descLbl.text = "Description: \(passedNews?.articleDescription ?? "") "
        authLbl.text = "Author: \(passedNews?.author ?? "")"
        sourceLbl.text = "Source: \(passedNews?.source?.name ?? "")"
        contentLbl.text = "Content: \(passedNews?.content ?? "")"
        dateLbl.text = "Date: \(passedNews?.publishedAt ?? "")"
        
        let urlEnds = passedNews?.urlToImage
        
        let lastThree = urlEnds?.contains("jpg")
        
        if passedNews?.urlToImage == nil || lastThree != true{
            articleDetailsImage.image = UIImage(named: "newsImage")
        }else{
            articleDetailsImage.kf.indicatorType = .activity
            articleDetailsImage.kf.setImage(with: URL(string: passedNews?.urlToImage ?? ""))
        }
        sourceHeaderLbl.text = passedNews?.source?.name
    }
    
    //MARK:- Set corner radius for btn and view
    func radius() {
        articleDetailsImage.layer.cornerRadius = 10
        openUrlBtn.layer.cornerRadius = 10
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 59
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    //MARK:- Open image in whole screen
    @objc func showZoomImageView( tap : UITapGestureRecognizer) {
        let bgView = UIScrollView.init(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.black
        let tapBg = UITapGestureRecognizer.init(target: self, action: #selector(tapBgView(tapBgRecognizer:)))
        bgView.addGestureRecognizer(tapBg)
        let picView = tap.view as! UIImageView//view cast uiimageView
        let imageView = UIImageView.init()
        imageView.image = picView.image;
        imageView.frame = bgView.convert(picView.frame, from: self.view)
        bgView.addSubview(imageView)
        UIApplication.shared.keyWindow?.addSubview(bgView)
        self.lastImageView = imageView
        self.originalFrame = imageView.frame
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIView.AnimationOptions.beginFromCurrentState,
            animations: {
                var frame = imageView.frame
                frame.size.width = bgView.frame.size.width
                frame.size.height = frame.size.width * ((imageView.image?.size.height)! / (imageView.image?.size.width)!)
                frame.origin.x = 0
                frame.origin.y = (bgView.frame.size.height - frame.size.height) * 0.5
                imageView.frame = frame
            }, completion: nil
        )
        
    }
    
    @objc func tapBgView(tapBgRecognizer:UITapGestureRecognizer)
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.lastImageView?.frame = self.originalFrame
            tapBgRecognizer.view?.backgroundColor = UIColor.clear
        }) { (finished:Bool) in
            tapBgRecognizer.view?.removeFromSuperview()
            self.lastImageView = nil
        }
    }
    
    
    
    
    //MARK:- Back button
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Open source url
    @IBAction func openURL(_ sender: Any) {
        guard let url = URL(string: passedNews?.url ?? "") else {
            return 
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
}
