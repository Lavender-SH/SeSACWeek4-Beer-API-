//
//  KakaoAPIManager.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static   let shared = KakaoAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK df79323b47aec35f08533de4cce84ee7"]
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (JSON) -> () ) {
            
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text
        //"https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=30&page=\(page)"
           
            print(url)
            AF.request(url, method: .get, headers: header).validate(statusCode:  200...500).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completionHandler(json)
                    

                    
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }

