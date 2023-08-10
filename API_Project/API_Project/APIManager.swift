import UIKit

struct APIManager {
    
   static func fetch(completion: @escaping
    ([String]?,[Double]?, [String]?) -> Void){
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
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("데이터를 받을 수 없습니다")
                return
            }
            //print("data: \(data)")
            var result: String
            result = String(decoding: data, as: UTF8.self)
            print(result)
            let decoder = JSONDecoder()
            let movieInfo = try? decoder.decode(MovieInfo.self, from: result.data(using: .utf8)!)
            
            DispatchQueue.main.async {
                let titles = movieInfo?.results.map{$0.title}
                let average = movieInfo?.results.map{$0.vote_average}
                let posterPath = movieInfo?.results.map{$0.poster_path}
                completion(titles, average, posterPath)
            }
        })
        dataTask.resume()
    }
}

