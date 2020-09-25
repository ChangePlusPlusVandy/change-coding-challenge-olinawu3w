//
//  TrumpQuotes.swift
//  TrumpKanyeQuotes
//
//  Created by apple on 2020/9/24.
//

import Foundation

// establish protocol for delegate use
protocol QuoteManagerDelegate {
    func updateQuote(_ quoteManager: QuoteManager, quote: QuoteModel)
    func didFailWithError(error: Error)
}

struct QuoteManager{
    // create two api links
    let trumpQuotesURL = "https://api.whatdoestrumpthink.com/api/v1/quotes/random"
    let kanyeQuotesURL = "https://api.kanye.rest"
    
    var delegate: QuoteManagerDelegate?
    
    //fetch quote based on a random boolean
    func fetchQuote(){
        let isTrump = Bool.random()
        // if bool is true fetch Trump quote else fetch Kanye quote
        performRequest(urlString: isTrump ? trumpQuotesURL: kanyeQuotesURL, isTrump: isTrump)
    }
    
    // get task based on url
    func performRequest(urlString: String, isTrump: Bool){
        // create url type
        if let url = URL(string: urlString){
            // create URLSession
            let session = URLSession(configuration: .default)
            // get task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    // retrieve safe data
                    if let quote = self.parseJSON(quoteData: safeData, isTrump: isTrump){
                        self.delegate?.updateQuote(self, quote: quote) //parse the JSON
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(quoteData: Data, isTrump: Bool) -> QuoteModel?{
        // create decoder
        let decoder = JSONDecoder()
        do{
            // get quote
            if isTrump{
                let decodedData = try decoder.decode(TrumpQuoteData.self , from: quoteData)
                return QuoteModel(question: "\"" + decodedData.message + "\"", answer: "Trump")
            }else{
                let decodedData = try decoder.decode(KanyeQuoteData.self , from: quoteData)
                return QuoteModel(question: "\"" + decodedData.quote + "\"", answer: "Kanye")
            }
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
