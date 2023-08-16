/*
let url = "https://어쩌구저쩌구"

AF.request(url, // 첫번째 파라미터 요청할 url 담는다
           method: .get, // 어떤 request method정하기
           parameters: nil, // request body 전달 값
           encoding: URLEncoding.default, //인코딩 방식 정하기
           headers: ["Content-Type":"application/json", "Accept":"application/json"])
    .validate(statusCode: 200..<300) //유효성 검사
    .responseJSON { response in // 응답 Json 데이터

    /** 서버로부터 받은 데이터 활용 */
    switch response.result {
    case .success(let data):
        /** 정상적으로 reponse를 받은 경우 */
    case .failure(let error):
        /** 그렇지 않은 경우 */
    }
}
*/

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
