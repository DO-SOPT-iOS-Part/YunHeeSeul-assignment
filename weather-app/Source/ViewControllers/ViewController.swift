//
//  ViewController.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/17.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    private var mainTableView = UITableView(frame: .zero, style: .grouped)
    private var headerView = UIView()
    private var menuBtn = UIButton()
    private var titleText = UILabel()
    private var searchBar = UISearchBar()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setDetail()
        setViewLayout()
    }
    
    func setViewLayout(){
        self.view.addSubview(mainTableView)
        headerView.addSubViews(menuBtn, titleText, searchBar)

        mainTableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        //[메뉴 아이콘]
        menuBtn.snp.makeConstraints{
            $0.top.equalTo(headerView)
            $0.size.equalTo(42)
            $0.trailing.equalTo(headerView).inset(8)
        }
        //[날씨라벨]
        titleText.snp.makeConstraints{
            $0.top.equalTo(menuBtn.snp.bottom).offset(10)
            $0.leading.equalTo(headerView).inset(8)
            $0.width.equalTo(headerView)
            $0.height.equalTo(44)
        }

        //[서치바]
        searchBar.snp.makeConstraints{
            $0.top.equalTo(titleText.snp.bottom).offset(15)
            $0.leading.trailing.width.equalTo(headerView)
            $0.height.equalTo(40)
            $0.bottom.equalTo(headerView).inset(10)
        }
    }
    func setDetail(){
        self.view.backgroundColor = .black
                
        //테이블뷰 스타일 지정하기
        mainTableView.do{
            $0.backgroundColor = .black
            $0.separatorStyle = .none
            $0.separatorColor = .black
            $0.rowHeight = UIScreen.main.bounds.height/6
            $0.dataSource = self
            $0.delegate = self
            $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
            $0.tableHeaderView = headerView
            $0.showsVerticalScrollIndicator = false
            $0.allowsSelection = false
        }
        
        headerView.do{
            $0.backgroundColor = .black
            $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height/5.5)
        }
        headerView.layoutIfNeeded()

        menuBtn.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        titleText.do{
            $0.text = "날씨"
            $0.font = UIFont(name: "SFProDisplay-Bold", size: 36)
            $0.backgroundColor = .black
            $0.textColor = .white
        }

        //[서치바]
        searchBar.do{
            $0.placeholder = "도시 또는 공항 검색"
            $0.searchTextField.backgroundColor = UIColor(named: "searchBar")
            $0.searchTextField.textColor = .white
            $0.searchTextField.attributedPlaceholder = NSAttributedString(string: $0.searchTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            $0.searchTextField.leftView?.tintColor = UIColor.lightGray
            $0.searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 19)
            $0.barTintColor = .clear
        }
    }
    
    //날씨화면 push
    @objc
    func weatherInfoCardTap(_ gesture: UITapGestureRecognizer){
        let weatherVC = WeatherViewController()
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
}
extension ViewController: UITableViewDelegate{}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WeatherInfoData.weatherInfoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        cell.bindData(data: WeatherInfoData.weatherInfoData[indexPath.row])
        return cell
    }
}



