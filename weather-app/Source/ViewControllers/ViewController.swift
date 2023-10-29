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
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var menuBtn = UIButton()
    private var titleText = UILabel()
    private var searchBar = UISearchBar()
    private var searchImageView = UIImageView()
    private var leftStackView = UIStackView()
    private var rightStackView = UIStackView()
    private var blankView1 = UILabel()
    private var blankView2 = UILabel()
    private var weatherInfoView = UIImageView()
    private var myLocation = UILabel()
    private var city = UILabel()
    private var weather = UILabel()
    private var temperatures = UILabel()
    private var highNLow = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setDetail()
        setViewLayout()
    }
    
    func setViewLayout(){
        self.view.addSubViews(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(menuBtn, titleText, searchBar, weatherInfoView)
        weatherInfoView.addSubViews(leftStackView, rightStackView)
        
        let safeArea = view.safeAreaLayoutGuide
        scrollView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(safeArea)
        }
        contentView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(view).priority(.low)
        }
        //[메뉴 아이콘]
        menuBtn.snp.makeConstraints{
            $0.top.equalTo(contentView)
            $0.size.equalTo(42)
            $0.trailing.equalTo(contentView).inset(6)
        }
        //[날씨라벨]
        titleText.snp.makeConstraints{
            $0.top.equalTo(menuBtn.snp.bottom).offset(10)
            $0.leading.equalTo(contentView).inset(10)
            $0.width.equalTo(contentView)
            $0.height.equalTo(44)
        }
        
        //[서치바]
        searchBar.snp.makeConstraints{
            $0.top.equalTo(titleText.snp.bottom).offset(15)
            $0.leading.trailing.width.equalTo(contentView)
            $0.height.equalTo(40)
        }
        
        //[날씨 정보 카드]
        weatherInfoView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(10)
            $0.height.equalTo(UIScreen.main.bounds.height/7)
        }
        
        //나의 위치,날씨 라벨을 담은 좌측 스택뷰
        leftStackView.snp.makeConstraints{
            $0.top.equalTo(weatherInfoView).inset(6)
            $0.bottom.equalTo(weatherInfoView).inset(10)
            $0.leading.equalTo(weatherInfoView)
            $0.width.equalTo(UIScreen.main.bounds.width/2)
            $0.height.equalTo(weatherInfoView)
        }
        
        for i in [myLocation, city, weather] {
            leftStackView.addArrangedSubview(i)
            i.snp.makeConstraints{
                $0.leading.equalTo(leftStackView).inset(14)
            }
        }
        
        myLocation.snp.makeConstraints{$0.top.equalTo(leftStackView)}
        city.snp.makeConstraints{$0.top.equalTo(myLocation.snp.bottom).inset(20)}
        weather.snp.makeConstraints{$0.bottom.equalTo(leftStackView).inset(10)}

        
        //기온, 최고/최저 기온 라벨을 담은 우측 스택뷰
        rightStackView.snp.makeConstraints{
            $0.top.equalTo(weatherInfoView).inset(6)
            $0.bottom.equalTo(weatherInfoView)
            $0.trailing.equalTo(weatherInfoView).inset(12)
            $0.width.equalTo(UIScreen.main.bounds.width/2)
        }

        for i in [temperatures, blankView2, highNLow] {
            rightStackView.addArrangedSubview(i)
            i.snp.makeConstraints{
                $0.width.equalTo(rightStackView)
                $0.trailing.equalTo(rightStackView).inset(14)
            }
        }
        temperatures.snp.makeConstraints{
            $0.top.equalTo(rightStackView).inset(10)
            $0.trailing.equalTo(rightStackView).inset(20)
        }
        highNLow.snp.makeConstraints{
            $0.top.equalTo(temperatures.snp.bottom).offset(10)
            $0.bottom.equalTo(rightStackView)
        }
    }
    func setDetail(){
        self.view.backgroundColor = .black
        scrollView.backgroundColor = .black
        contentView.backgroundColor = .black
        
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
        
        //[날씨 정보 카드]
        weatherInfoView.do{
            $0.image = UIImage(named: "weatherInfo")
            //addGestureRecognizer 을 통해 만든 gesture를 등록
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(weatherInfoCardTap(_:)))
            $0.addGestureRecognizer(tapGesture)
            $0.isUserInteractionEnabled = true
        }
        for i in [myLocation, city, weather] {
            i.backgroundColor = .clear
            i.textColor = .white
            i.adjustsFontSizeToFitWidth = true
        }
        
        //나의 위치,날씨 라벨을 담은 좌측 스택뷰
        leftStackView.do{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10
            $0.isLayoutMarginsRelativeArrangement = true
        }
        myLocation.do{
            $0.text = "나의 위치"
            $0.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        }
        city.do{
            $0.text = "의정부시"
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        }
        weather.do{
            $0.text = "흐림"
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        }
        //기온, 최고/최저 기온 라벨을 담은 우측 스택뷰
        rightStackView.do{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10
            $0.isLayoutMarginsRelativeArrangement = true
        }
        for i in [temperatures, blankView2, highNLow] {
            rightStackView.addArrangedSubview(i)
            i.backgroundColor = .clear
            i.textColor = .white
        }
        temperatures.do{
            $0.text = "21º"
            $0.textAlignment = .right
            $0.font = UIFont(name: "SFProDisplay-Light", size: 52)
        }
        highNLow.do{
            $0.textAlignment = .right
            $0.text = "최고:29º 최저:15º"
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        }
    }
    
    //날씨화면 push
    @objc
    func weatherInfoCardTap(_ gesture: UITapGestureRecognizer){
        let weatherVC = WeatherViewController()
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
}



