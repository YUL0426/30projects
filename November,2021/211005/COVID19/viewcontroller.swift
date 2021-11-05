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

    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.configureStarckView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
             debugPrint("error \(error)")
            }
        })
    }
    
    func makeCovidOverviewList (
        cityCovidOverview: CityCovidOverview
    ) -> [CovidOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju,
        ]
    }
    
    func configureChartView(covidOverviewList: [CovidOverview]) {       //전달받은 것
        self.pieChartView.delegate = self
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil}
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        //데이터셋 항목으로 묶기
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1 //항목간 간격을 1피트로
        dataSet.entryLabelColor = .black //항목이름을 검정색으로
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice //항목이름이 파이차트 바깥쪽선으로 표시되게
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
               //파이차트뷰,데이터프로퍼티에
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(string: String)  -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStarckView (koreaCovidOverview: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
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

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as? CovidDetailViewController else { return }
        guard let covidOverview = entry.data as? CovidOverview else { return } // 엔트리 데이터를 입력시켜주는데, covidoverview type으로 다운캐스팅
        covidDetailViewController.covidOverview = covidOverview //coviddetaiviewcontroller의 covidoverview프로퍼티에 선택된항목에 저장된 데이터를 전달
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
        //항목을 누르면 coviddetailviewcontroller에 표시가되도록.
    } //차트에서 항목이 선택되었을 때 호출되는 메서드
}
