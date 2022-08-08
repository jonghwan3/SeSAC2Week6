//
//  ViewController.swift
//  SeSAC2Week6
//
//  Created by 박종환 on 2022/08/08.
//

import UIKit

/*
 <b>고래밥</b> 이런 부분 해결방법
 1. html tag <></> 기능 활용
 2. 문자열 대체 메서드 (replacingOccurrences)
 - response에서 처리하는 것과 셀에서 처리하는 것의 차이 (list 저장 여부)
 */

/*
 TableView automaticDimension
 - 컨텐츠 양에 따라서 셀 높이가 자유롭게
 - 조건1: 레이블 numberOfLines 0
 - 조건2: tableView Height automaticDimension 설정
 - 조건3: 레이아웃 설정
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList: [String] = []
    var cafeList: [String] = []
    var isExpanded = false // false 2줄, true 0으로!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션의 셀에 대해서 유동적으로 잡겠다라는 뜻
        searchBlog()
    }
    
    func searchBlog() {
        KakaoAPIManger.shared.callRequest(type: .blog, query: "고래밥") { json in
//            print(json)
            for document in json["documents"].arrayValue {
                let value = document["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                self.blogList.append(value)
            }
            self.searchCafe()
        }
    }
    
    func searchCafe() {
        KakaoAPIManger.shared.callRequest(type: .cafe, query: "고래밥") { json in
//            print(json)
            for document in json["documents"].arrayValue {
                let value = document["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                self.cafeList.append(value)
            }
            print(self.blogList)
            print(self.cafeList)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func expandCell(_ sender: Any) {
        isExpanded.toggle()
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return blogList.count
        } else if section == 1 {
            return cafeList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else {return UITableViewCell()}
        cell.testLabel.numberOfLines = isExpanded ? 0 : 2
        if indexPath.section == 0 {
            cell.testLabel.text = blogList[indexPath.row]
        } else if indexPath.section == 1 {
            cell.testLabel.text = cafeList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "블로그 검색결과"
        } else if section == 1 {
            return "카페 검색결과"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class kakaoCell: UITableViewCell {
    @IBOutlet weak var testLabel: UILabel!
}
