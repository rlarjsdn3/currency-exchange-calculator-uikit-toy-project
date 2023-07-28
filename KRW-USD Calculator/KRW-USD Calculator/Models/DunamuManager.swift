//
//  dunamuManager.swift
//  KRW-USD Calculator
//
//  Created by 김건우 on 7/27/23.
//

import Foundation

class DunamuManager {
    
    private var wonDollarInfo: Dunamu?
    
    func fetchWonDollarBasePrice(completion: @escaping (Double?) -> Void) {
        requestWonDollarBasePrice { [weak self] dunamu in
            guard let dunamu = dunamu?.first else {
                return
            }
            self?.wonDollarInfo = dunamu
            completion(dunamu.basePrice)
        }
    }
    
    func requestWonDollarBasePrice(completion: @escaping ([Dunamu]?) -> Void) {
        
        let url = URL(string: "https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD")!
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // 에러가 발생하였다면
            if let error = error {
                print("원/달러 환율 정보 불러오기 실패: \(error)")
                completion(nil)
                return
            }
            
            // 상태 코드가 200이상 300미만이 아니라면
            if !(200..<300).contains((response as! HTTPURLResponse).statusCode) {
                print("원/달러 환율 정보 불러오기 실패: \(error)")
                completion(nil)
                return
            }
            
            // 데이터를 정상적으로 받아왔으면
            if let data = data {
                // 정상적으로 JSON 파싱이 가능하면
                if let parsedDunamu = self?.parseDunamuJSON(data) {
                    completion(parsedDunamu)
                }
            }
        }.resume()
    }
    
    func parseDunamuJSON(_ data: Data) -> [Dunamu]? {
        do {
            let decodedData = try JSONDecoder().decode([Dunamu].self, from: data)
            return decodedData
        } catch let error {
            print("JSON 파싱 실패: \(error)")
            return nil
        }
    }
    
    func calculateWonDollarExchange(inputWon: Double, primeExchangeRate: Double) -> Double? {
        guard let basePrice = wonDollarInfo?.basePrice,
              let ttSellingPrice = wonDollarInfo?.ttSellingPrice
        else {
            return nil
        }
        // 환전 우대율을 고려해 적용 환율 계산하기
        let exchangeRate = basePrice + (basePrice - ttSellingPrice) * primeExchangeRate / 100.0
        let result = inputWon / exchangeRate // 원화를 달러로 환전한 결과 저장하기
        return result
    }
}
