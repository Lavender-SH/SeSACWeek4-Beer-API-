//
//  BeerApiViewController.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class BeerApiViewController: UIViewController {
    
    
    @IBOutlet weak var BeerImage: UIImageView!
    @IBOutlet weak var BeerLabel: UILabel!
    @IBOutlet weak var BeerText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
    }
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonArray = JSON(value).arrayValue
                
                if let beer = jsonArray.first {
                    if let imageUrl = beer["image_url"].string,
                       let name = beer["name"].string,
                       let description = beer["description"].string {
                        
                        if let url = URL(string: imageUrl) {
                            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                self.BeerImage.image = image
                            }
                        }
                        
                        self.BeerLabel.text = name
                        self.BeerText.text = description
                    }
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}






