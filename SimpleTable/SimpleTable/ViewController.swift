//
//  ViewController.swift
//  SimpleTable
//
//  Created by 조윤영 on 20/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdetifier: String = "customCell"
    
    let korean: [String] = ["가", "나","다","라","마","바","사","아","자","차","카","타","파","하"]
    let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }
    var dates: [Date] = []
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func touchUpAdddButton(_ sender: UIButton) {
        dates.append(Date())
        
        //전체 데이터를 다시 불러오게 됨: 매우 비효율적!
//        self.tableView.reloadData()
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }
    
    
    
    //몇 개의 섹션을 사용할 것인지
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section < 2 {
            //여기서 deque가 재사용 큐를 이용한다고 선언하는 부분! :셀의 재사용
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier:self.cellIdentifier, for:indexPath)
                    //데이터 셋팅
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            
            cell.textLabel?.text = text
            
            if indexPath.row == 1 {
                cell.backgroundColor = UIColor.red
            }else{
                cell.backgroundColor = UIColor.white
            }
            
            
            return cell
        }else {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdetifier, for:indexPath) as! CustomTableViewCell
            
            cell.leftLabel?.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        }
        return nil
        
    }

    //MARK: -Navigation
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        
//        segue.identifier
        
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else{
            return
        }
        
        nextViewController.textToSet=cell.textLabel?.text
        
        //label에 직접 셋팅해주려고 하면 오류가 난다! 왜? 레이블이 아직 생성되기 전이므로!
        
    }
    
}

