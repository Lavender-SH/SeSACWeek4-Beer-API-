//
//  PapagoViewController.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class PapagoViewController: UIViewController {
    
    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var langCodeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    let sourceLanguages = ["ko", "en", "ja"]
    let targetLanguages = ["en", "ja", "fr"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }
    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        //번역기 기능
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = ["X-Naver-Client-Id": "gr8TalCevSearBnPjsYj", "X-Naver-Client-Secret": "GQfnEYG67q"]
        let sourceLanguage = sourceLanguages[pickerView.selectedRow(inComponent: 0)]
        let targetLanguage = targetLanguages[pickerView.selectedRow(inComponent: 1)]
        let parameters = [
            "source": sourceLanguage,
            "target": targetLanguage,
            "text": originalTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
            case .failure(let error):
                print(error)
            }
        }
        
        //언어감지 기능
        let langDetectionURL = "https://openapi.naver.com/v1/papago/detectLangs"
        let langDetectionHeader: HTTPHeaders = ["X-Naver-Client-Id": "J6WmDBqkZmdxNqqXVBdX", "X-Naver-Client-Secret": "JUxmM8Smam"]
        let langDetectionParameters = ["query": originalTextView.text ?? ""]
        
        AF.request(langDetectionURL, method: .post, parameters: langDetectionParameters, headers: langDetectionHeader).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let detect = json["langCode"].stringValue
                self.langCodeLabel.text = detect
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//피커뷰 프로토콜 정의
extension PapagoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? sourceLanguages.count : targetLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? sourceLanguages[row] : targetLanguages[row]
    }
}


