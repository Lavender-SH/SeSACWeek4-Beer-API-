////
////  TranslateAPIManager.swift
////  SeSACWeek4
////
////  Created by 이승현 on 2023/08/11.
////
//
//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class TranslateAPIManager {
//
//    static let shared = TranslateAPIManager()
//    private init() { }
//    func callRequeset(text: String, resultString: @escaping (String) -> Void) {
//        //번역기 기능
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = ["X-Naver-Client-Id": "gr8TalCevSearBnPjsYj", "X-Naver-Client-Secret": "GQfnEYG67q"]
//        let sourceLanguage = sourceLanguages[pickerView.selectedRow(inComponent: 0)]
//        let targetLanguage = targetLanguages[pickerView.selectedRow(inComponent: 1)]
//        let parameters = [
//            "source": sourceLanguage,
//            "target": targetLanguage,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                let data = json["message"]["result"]["translatedText"].stringValue
//                resultString(data)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        //언어감지 기능
//        let langDetectionURL = "https://openapi.naver.com/v1/papago/detectLangs"
//        let langDetectionHeader: HTTPHeaders = ["X-Naver-Client-Id": "J6WmDBqkZmdxNqqXVBdX", "X-Naver-Client-Secret": "JUxmM8Smam"]
//        let langDetectionParameters = ["query": originalTextView.text ?? ""]
//
//        AF.request(langDetectionURL, method: .post, parameters: langDetectionParameters, headers: langDetectionHeader).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                let detect = json["langCode"].stringValue
//                self.langCodeLabel.text = detect
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    }
//
//
//
//
//
//}
