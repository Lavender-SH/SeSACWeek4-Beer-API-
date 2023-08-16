//
//  AsyncViewController.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {
    
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        first.backgroundColor = .blue
        print("1")
        
        DispatchQueue.main.async {
            print("2")
            self.first.layer.cornerRadius = self.first.frame.width / 2
        }
       
    }
    
    //sync async serial concurrent
    //UI Freezing
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.first.image = UIImage(data: data)
            }
        }
        
        
        
        
        
    }
    


}
