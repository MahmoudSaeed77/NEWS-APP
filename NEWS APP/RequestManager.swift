//
//  RequestManager.swift
//  EASYCARCLIENT
//
//  Created by Mahmoud Saeed on 01/12/2022.
//

import Foundation
import Alamofire


enum MultipartRequestType {
    case dataOnly
    case imagesOnly
    case bothDataAndImages
}
class RequestManager {
    
    public static let shared = RequestManager()
    
    func request<T: Codable>(urslString: String, method: HTTPMethod, params: Parameters, completion: @escaping(_ data: T?, _: Error?) -> Void) {
        AF.request(urslString, method: method, parameters: params, headers: URLs.userHeader()).responseDecodable(of: T.self) { response in
            debugPrint(response)
            
            guard let data = response.data else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(json, nil)
                } catch let err {
                    completion(T.self as? T, err)
                }
            case .failure(let err):
                completion(nil , err)
            }
        }
    }
    
    func requestWithCustomHeader<T: Codable>(urslString: String, method: HTTPMethod, headers: HTTPHeaders, params: Parameters, completion: @escaping(_ data: T?, _: Error?) -> Void) {
        AF.request(urslString, method: method, parameters: params, headers: headers).responseDecodable(of: T.self) { response in
            debugPrint(response)
            
            guard let data = response.data else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(json, nil)
                } catch let err {
                    completion(T.self as? T, err)
                }
            case .failure(let err):
                completion(nil , err)
            }
        }
    }
    
    func multiPartRequest<T: Codable>(urslString: String, method: HTTPMethod, params: Parameters, image: [UIImage?], imageParamName: String?, data: [Data?], dataParamName: String?, requestType: MultipartRequestType, completion: @escaping(_ data: T?, _: Error?) -> Void) {
        let request = AF.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
            switch requestType {
            case .dataOnly:
                data.forEach { d in
                    if let pdfData = d {
                        multipartFormData.append(pdfData, withName: dataParamName ?? "", fileName: "\(dataParamName ?? "").pdf", mimeType: "pdf/ebub")
                    }
                }
            case .imagesOnly:
                image.forEach { img in
                    multipartFormData.append(img?.jpegData(compressionQuality: 0.5) ?? Data(), withName: imageParamName ?? "", fileName: "\(imageParamName ?? "").jpg", mimeType: "image/jpg")
                }
            case .bothDataAndImages:
                data.forEach { d in
                    if let pdfData = d {
                        multipartFormData.append(pdfData, withName: dataParamName ?? "", fileName: "\(dataParamName ?? "").pdf", mimeType: "pdf/ebub")
                    }
                }
                image.forEach { img in
                    multipartFormData.append(img?.jpegData(compressionQuality: 0.5) ?? Data(), withName: imageParamName ?? "", fileName: "\(imageParamName ?? "").jpg", mimeType: "image/jpg")
                }
            }
            for (key, value) in params {
                print(key)
                print(value)
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue) ?? Data(), withName: key)
            }
        }, to: urslString, method: method , headers: URLs.userHeader()).responseDecodable(of: T.self) { response in
            //Do what ever you want to do with response
            debugPrint(response)
            guard let data = response.data else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(json, nil)
                } catch let err {
                    completion(T.self as? T, err)
                }
            case .failure(let err):
                completion(nil , err)
            }
        }
        request.resume()
    }
}
