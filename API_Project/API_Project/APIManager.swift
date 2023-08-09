import UIKit

extension UIViewController {
    
    func fetch(completion: @escaping ([String]?) -> Void){
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(Secrets.API_KEY)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/popular?")! as URL,
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
                print("No data received")
                return
            }
            print("data: \(data)")
            var result: String
            result = String(decoding: data, as: UTF8.self)
            //print(result)
            let decoder = JSONDecoder()
            let movieInfo = try? decoder.decode(MovieInfo.self, from: result.data(using: .utf8)!)
            
            DispatchQueue.main.async {
                let titles = movieInfo?.results.map{$0.title}
                print(titles ?? nil)
                completion(titles)
            }
        })
        dataTask.resume()
    }
}

