//
//  KakaoAPIManager.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON
// MARK: - Welcome
struct Video: Codable {
    let documents: [Document]
//    let ds, g: [JSONAny]
//    let m: M
//    let meta: Meta//
}

// MARK: - Document
struct Document: Codable {
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime
        case playTime = "play_time"
        case thumbnail, title, url
    }
}

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    
    private init() { }
    
    func callRequest(query: String, page: Int, completionHandler: @escaping ([Document]) -> Void) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let text else { return }
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=30&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK df79323b47aec35f08533de4cce84ee7"]
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Video.self){response in
            switch response.result {
            case .success(let value):
                completionHandler(value.documents)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}




//func callRequest(query: String, page: Int) {
//
//    let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//    guard let text else { return }
//    let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=30&page=\(page)"
//    let header: HTTPHeaders = ["Authorization": "KakaoAK df79323b47aec35f08533de4cce84ee7"]
//
//    AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Video.self) { result in
//        if let err = result.error {
//            print(err.localizedDescription)
//        } else {
//            print(result.value)
//        }
//
//    }
//}
//
//
//
//
//
//    let header: HTTPHeaders = ["Authorization": "KakaoAK df79323b47aec35f08533de4cce84ee7"]
//
//    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
//
//        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let url = type.requestURL + text
//        //"https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=30&page=\(page)"
//
//            print(url)
//            AF.request(url, method: .get, headers: header).validate(statusCode:  200...500).responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    completionHandler(json)
//
//
//
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
//
//        }
////    }
