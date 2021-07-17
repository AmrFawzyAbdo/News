//
//  APIClient.swift
//  News
//
//  Created by RKAnjel on 7/15/21.
//

import Foundation
import Alamofire


class APIClient {

    //MARK:- Get news
    func getNews(page: Int = 1, onSuccess: @escaping ([Article]) -> Void, onError: @escaping (_ error: String)-> Void) {
        AF.request(URL(string: Constants.ProductionServer.baseURL + Constants.APIKey.apiKey + "&page=\(page)")!, method: .get ,encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(NewsModel.self, from: jsonData)
                    print(data)
                    if data != nil {
                        onSuccess(data.articles!)
                    } else {
                        onError(data.status!)
                    }
                } catch {
                    print("ParseError",error.localizedDescription)
                    onError(error.localizedDescription)
                }
                break
            case .failure(let error):
                print("Request error: \(error)")
                onError(error.localizedDescription)
                break
            }
        }
    }



    //MARK:- Get searched news
    func getNewsSearch(page: Int = 1,qInTitle:String, onSuccess: @escaping ([Article]) -> Void, onError: @escaping (_ error: String)-> Void) {

        AF.request(URL(string: Constants.ProductionServer.searchBaseURL + "qInTitle=\(qInTitle)&sortBy=publishedAt&apiKey=" + Constants.APIKey.apiKey + "&page=\(page)")!, method: .get ,encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(NewsModel.self, from: jsonData)
                    print(data)
                    if data != nil {
                        onSuccess(data.articles!)
                    } else {
                        onError(data.status!)
                    }
                } catch {
                    print("ParseError",error.localizedDescription)
                    onError(error.localizedDescription)
                }
                break
            case .failure(let error):
                print("Request error: \(error)")
                onError(error.localizedDescription)
                break
            }
        }
    }
}
