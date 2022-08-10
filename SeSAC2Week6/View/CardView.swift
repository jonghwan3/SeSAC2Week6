//
//  CardView.swift
//  SeSAC2Week6
//
//  Created by 박종환 on 2022/08/09.
//

import UIKit

/*
 Xml Interface Builder (XIB)
 1. UIView Custom Class
 2. File's owner => 활용도는 높지만, 한 파일 내에서 여러 View를 컨트롤하는 데에는 제약이 있음
 */

/*
 View:
 - 인터페이스 빌더 UI 초기화 구문: required init?
   - 프로토콜 초기화 구문: required > 초기화 구문이 프로토콜로 명세되어 있음
 - 코드 UI 초기화 구문: override init
 */
protocol A {
    func example()
    init()
}

class CardView: UIView {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
    }
}
