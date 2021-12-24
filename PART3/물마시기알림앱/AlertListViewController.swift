//
//  AlertListViewController.swift
//  DrinkAlarm
//
//  Created by YUL on 2021/12/24.
//

import UIKit

class AlertListViewController: UITableViewController {
    
    //tabelview에 뿌려질 alert들
    var alerts: [Alert] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alerts = alertList() // tableview가 바라볼 alerts에 넣어줌
    }
    
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        
        addAlertVC.pickedDate = { [weak self] date in //클로져 + 순환참조방식을위한 weak self 설정(date전달)
            guard let self = self else { return }
            
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true) // 자식뷰에서 설정된 새 알림값 받을 수 있음
            
            alertList.append(newAlert)          // 새로생성된 alert append
            alertList.sort { $0.date < $1.date }    // date순서대로 정렬
            
            
            self.alerts = alertList
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
        }
        self.present(addAlertVC, animated: true, completion: nil)   // 자식뷰에서 전달될 데이터 핸들링
    }
    
    func alertList() -> [Alert] {   // Alert라는 배열의 객체를 내뱉어 준다
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data, // userdefaults(내부저장소)에서 key가 alerts인 것
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] } // 디코딩
        return alerts
    }
}


// UITABLEVIEW DATASOURE,Delegate
extension AlertListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for:indexPath) as? AlertListCell else { return UITableViewCell() }
        
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time     //timelabel에 표시할것, alertlist에서 전달되는 alert중에 해당하는 indexpath 중에 time
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        cell.alertSwitch.tag = indexPath.row        // ...
        
        return cell
    }
    //셀 높이 설정해주는 함수
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // 알람삭제시 전체 다 삭제 가능할 수 있도록 델리게이트 추가(caneditrow함수)
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            //노티피케이션 삭제 구현
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}
