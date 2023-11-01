//
//  JokeManager.swift
//  DaddyJo
//
//  Created by Kate Volkova on 10.08.22.
//

import Foundation

protocol JokeManagerDelegate {
    func didLoadJoke(_ joke: String)
}

struct JokeManager {
    let baseUrl = "https://icanhazdadjoke.com/"
    
    var delegate: JokeManagerDelegate?
    
    func fetchJoke() {
        performRequest(for: baseUrl)
    }
    
    func fetchJoke(about theme: String) {
        let urlString = "\(baseUrl)search?limit=30&term=\(theme)"
        performRequest(for: urlString)
    }
    
    func performRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = session.dataTask(with: request, completionHandler: { data, respose, error in
                if let data = data, let jokeData = parseJSON(data) {
                    if let themeJokes = jokeData.results {
                        let randomThemedJoke = themeJokes.randomElement()?.joke
                        if randomThemedJoke == nil {
                            // report error
                            return
                        }
                        delegate?.didLoadJoke(randomThemedJoke!)
                    } else {
                        delegate?.didLoadJoke(jokeData.joke!)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> JokeData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JokeData.self, from: data)
            return decodedData
        } catch {
            print("decoding failed")
            return nil
        }
    }
}
