import UIKit

struct APIManager {
    func fetch(completion: @escaping
        ([String]?, [Double]?, [String]?) -> Void)
    {
        print("1")
        let headers = [
            "accept": "application/json",
            "Authorization": "\(Secrets.ACCESS_TOKEN)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Secrets.BASE_URL)/movie/popular?")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            print("2")
            if let error = error {
                print("Error: \(error)")
                print("3")
                return
            }
            guard let data = data else {
                print("데이터를 받을 수 없습니다")
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieInfo.self, from: data)
                print("result = \(result)")
                    
                DispatchQueue.main.async {
                    let titles = result.results.map { $0.title }
                    let average = result.results.map { $0.vote_average }
                    let posterPath = result.results.map { $0.poster_path }
                    print(titles)
                    completion(titles, average, posterPath)
                }
            } catch {
                print("Decoding Error: \(error)")
            }
        })
        dataTask.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func forUnderStandCompletion1(completion: (String) -> Void) {
        let understand = "컴플리션 클로져 이해하기.."
        /*
         completion 클로저는 타입이 String을 반환하고 이 함수는 void 형태이다.
         다른 곳에서 이 함수가 실행될 때
         
         apiManager.forUnderStandCompletion { val in
             print(val) // 결과 : "컴플리션 클로져 이해하기"
         }
         
         그럼 @escaping은 언제쓰는걸까? 이 함수는 한번 불리면 결과값을 도출하고 나서 끝나는 함수인데 @escaping을 사용하면서 함수의 실행이 완료 이후에
         언제 불러올지 모르는 데이터를 기다리면서 클로저를 함수 외부에서 사용할 수 있게 하는 함수이다
         즉, 함수가 끝나도 비동기처리가 끝날 때까지 클로저에 가지고 있는 값을 부르면 끝나게 하는 방식
         */
        completion(understand)
    }
    
    func forUnderStandCompletion2(completionHandler: (String) -> Void, completionHandler2: (String) -> Void) {
        let dog = "땡글"
        let cat = "부우"
        /*
         completion 클로저는 타입이 String을 반환하고 이 함수는 void 형태이다.
         다른 곳에서 이 함수가 실행될 때
         
         apiManager.forUnderStandCompletion { val in
         print("1.\(val)") // 땡글
         } completionHandler2: { val in
         print("2.\(val)") // 부우
         }
         
         참고로 completion 클로저는 몇개를 넣어도 상관없음!
         */
        completionHandler(dog)
        completionHandler2(cat)
    }
}
