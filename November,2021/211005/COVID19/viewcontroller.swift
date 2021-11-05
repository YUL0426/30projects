//
//  ViewController.swift
//  COVID19
//
//  Created by YUL on 2021/11/05.
//

import UIKit

import Alamofire
import Charts

class ViewController: UIViewController {
    
    //Mark - IBOutlet
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in          // 강한변수(?)를 만들어준다.
            guard let self = self else { return }
            switch result {
            case let .success(result):
             debugPrint("success \(result)")
            case let .failure(error):
             debugPrint("error \(error)")
            }
        })
    }
    
    //함수정의
    //completionHandler정의 :
    func fetchCovidOverview(
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        //딕셔너리 대입
        let param = [
            "serviceKey" : "oT5zq6DHpFi4yKJmEhRj8gSQnskeI1LxU" //발급받은 api 키
        ]
        
        AF.request(url, method: .get, parameters: param)
          .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do {
                      let decoder = JSONDecoder()
                      let result = try decoder.decode(CityCovidOverview.self, from: data)
                      completionHandler(.success(result))
                    } catch {
                      completionHandler(.failure(error))
                    }
                    
                case let .failure(error):
                  completionHandler(.failure(error))
                }
            })
    }
}

