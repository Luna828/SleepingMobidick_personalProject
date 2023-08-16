//
//  FotoDataManager.swift
//  API_Project
//
//  Created by t2023-m0050 on 2023/08/16.
//

import Alamofire

//클라이언트와 서버를 연결해주는 것
class FotoDataManager {
    func fotoDataManager(_ parameters: FotoAPIInput, _ viewController: ImageFeedViewController) {
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get,
                   parameters: parameters).validate().responseDecodable(of: [FotoModel].self) { response in
            switch response.result {
            case .success(let result):
                print("성공\(result)")
                viewController.successAPI(result)
            case .failure(let error):
                print("실패\(error)")
            }
        }
    }
}
