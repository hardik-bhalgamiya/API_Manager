//
//  APIManager.swift
//  APIManager
//

//

import Foundation

class APIManager{
    
    static let sharedInstance = APIManager()
    static let urlString = "your url"
    
    
    func ServiceCall(method: String,parameter:String, completion: @escaping (_ dictionary: NSDictionary?, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            var request = URLRequest(url: URL(string:APIManager.urlString)!)
            request.httpMethod = method
            request.httpBody = parameter.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    completion(nil, error)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                    // make error here and then
                    completion(nil, error)
                    return
                }
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                
                DispatchQueue.main.async {
                    do {
                        let jsonDictionary:NSDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] as NSDictionary
                        completion(jsonDictionary, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
}
