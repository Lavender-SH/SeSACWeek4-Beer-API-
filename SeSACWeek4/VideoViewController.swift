//
//  VideoViewController.swift
//  SeSACWeek4
//
//  Created by 이승현 on 2023/08/08.
//
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class VideoViewController: UIViewController {
    
    var networkManager = KakaoAPIManager.shared
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoTableView: UITableView!
    
    var videoList: [Document] = []
    var page = 1
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.rowHeight = 140
        videoTableView.prefetchDataSource = self
        
        
        searchBar.delegate = self
        setupDatas(query: "아이유", page:  1)
    }
    
    func setupDatas(query: String, page: Int) {
        networkManager.callRequest(query: query, page: page) { documents in
            self.videoList.append(contentsOf: documents)
            dump(self.videoList)
            self.videoTableView.reloadData()
            }
        }
    }


extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1 //새로운 검색어이기 때문에 page를 1로 변경
        videoList.removeAll()
        guard let query = searchBar.text else { return }
        setupDatas(query: query, page: page)
        
    }
}


//UITableViewDataSourcePrefetching: iOS이상 사용 가능한 프로토콜, cellForRowAt 메서드가 호출되기 전에 미리 호출됨
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        return cell
    }
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    //page count에 대한 체크
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            //마지막 셀까지 왔다고 인지
            //딱딱 맞게 마지막 셀 직전에 실행되는건 아닌 것 처럼 보임
            if videoList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                //callRequest(query: query, page: page)
                //networkManager.callRequest(query: searchBar.text!, page: page)
                setupDatas(query: searchBar.text!, page: page)
                
            }
        }
        
    }
    //취소 기능: 직접 취소하는 기능을 구현해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("=====취소: \(indexPaths)")
    }
}






//        KakaoAPIManager.shared.callRequest(type: .video, query: query) { json in
//            print("=======\(json)")
        //afeb92145464v7421499bdc8fd7417c4
//        AF.request(url, method: .get, headers: header).validate(statusCode:  200...500).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
////                print("JSON: \(json)")
////                print(response.response?.headers)
////                print(response.response?.statusCode)
//
//                let statusCode = response.response?.statusCode ?? 500
//                if statusCode == 200 {
//
//                    self.isEnd = json["meta"]["is_end"].boolValue
//
//                    for item in json["documents"].arrayValue {
//                        let author = item["author"].stringValue
//                        let date = item["datetime"].stringValue
//                        let time = item["play_time"].intValue
//                        let thumbnail = item["thumbnail"].stringValue
//                        let title = item["title"].stringValue
//                        let link = item["url"].stringValue
//
//                        let data = Video(author: author, datetime: date, time: time, thumbnail: thumbnail, title: title, link: link)
//                        self.videoList.append(data)
//                    }
//                    print(self.videoList)
//                    self.videoTableView.reloadData()
//                }
//                else {
//                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요!!")
//                }
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }

//    func callRequest(query: String, page: Int) {
//
//        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        guard let text else { return }
//        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=30&page=\(page)"
//        let header: HTTPHeaders = ["Authorization": "KakaoAK df79323b47aec35f08533de4cce84ee7"]
//        print(url)
//
//        //        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Video.self) { response, err in
//        //            if let err = err {
//        //                print(err.localizedDescription)
//        //            }
//        //            guard let value = response.value else { return }
//        //            print("responseDecodable:", value)
//        //
//        //        }
//
//        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Video.self) { result in
//            if let err = result.error {
//                print(err.localizedDescription)
//            } else {
//                print(result.value)
//            }
//
//        }
//    }
