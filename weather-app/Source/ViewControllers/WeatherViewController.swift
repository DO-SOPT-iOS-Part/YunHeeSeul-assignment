//
//  WeatherViewController.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/18.
//

import UIKit
import SnapKit
import Then

class WeatherViewController: UIViewController {
    private var backgroundView = UIImageView()
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var myLocation = UILabel()
    private var temperature = UILabel()
    private var weather = UILabel()
    private var highNLow = UILabel()
    private var infoCard = UIView()
    private var weatherInfo = UITextView()
    private var divider1 = UIView()
    private var weatherScrollView = UIScrollView()
    private var horizontalStackView  = UIStackView()
    private var divider2 = UIView()
    private var bottomStackView = UIStackView()
    private var mapBtn = UIButton()
    private var mainBtn = UIButton()
    private var dotBtn = UIButton()
    private var arrowBtn = UIButton()
    private var container = UIView()
    
    private var mainTableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView?.backgroundColor = .clear
        setViewLayout()
        setDetail()
    }
    
    func setViewLayout(){
        self.view.addSubViews(backgroundView, scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(myLocation, temperature, weather, highNLow, infoCard, divider2, bottomStackView)
        infoCard.addSubViews(weatherInfo, divider1, weatherScrollView)
        weatherScrollView.addSubViews(horizontalStackView)
        //시간 별 날씨 정보를 담은 스택뷰의 아이템 생성
        [setStackViewItem(time: "Now", icon: "moonNcloud", temperature: "21º"),
         setStackViewItem(time: "10시", icon: "rain", temperature: "21º"),
         setStackViewItem(time: "11시", icon: "heavyRain", temperature: "19º"),
         setStackViewItem(time: "12시", icon: "thunder", temperature: "19º"),
         setStackViewItem(time: "13시", icon: "rainNsun", temperature: "19º"),
         setStackViewItem(time: "14시", icon: "moonNcloud", temperature: "18º"),
         setStackViewItem(time: "15시", icon: "rain", temperature: "18º"),
         setStackViewItem(time: "16시", icon: "heavyRain", temperature: "18º"),
         setStackViewItem(time: "17시", icon: "thunder", temperature: "18º"),
         setStackViewItem(time: "18시", icon: "rainNsun", temperature: "18º")].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.addArrangedSubview($0)
        }
        [mapBtn, container, mainBtn].forEach {
            bottomStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        container.addSubViews(arrowBtn, dotBtn)

        let safeArea = view.safeAreaLayoutGuide
        //배경이미지뷰
        backgroundView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(view)
        }

        //스크롤뷰
        scrollView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(safeArea)
        }

        //컨텐트뷰
        contentView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualTo(view).priority(.low)
        }
        
        //[화면 상단] 위치, 기온, 날씨, 최고/최저 기온
        myLocation.snp.makeConstraints{
            $0.top.equalTo(contentView).inset(50)
            $0.height.equalTo(40)
        }
        temperature.snp.makeConstraints{
            $0.top.equalTo(myLocation.snp.bottom).inset(4)
            $0.height.equalTo(110)
        }
        weather.snp.makeConstraints{
            $0.top.equalTo(temperature.snp.bottom).inset(4)
            $0.height.equalTo(24)
        }
        highNLow.snp.makeConstraints{
            $0.top.equalTo(weather.snp.bottom).offset(4)
            $0.height.equalTo(24)
        }
        
        //[화면 중앙] 시간 별 날씨 정보 카드
        infoCard.snp.makeConstraints{
            $0.top.equalTo(highNLow.snp.bottom).offset(60)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.width.equalTo(UIScreen.main.bounds.width-32)
            $0.height.equalTo(UIScreen.main.bounds.height/4)
        }
        //날씨 정보 카드 내 날씨 설명 라벨
        weatherInfo.snp.makeConstraints{
            $0.top.equalTo(infoCard).inset(6)
            $0.leading.trailing.equalTo(infoCard).inset(12)
            $0.width.equalTo(infoCard.bounds.width-24)
            $0.height.equalTo(60)
        }

        //날씨 정보 카드 내 구분선
        divider1.snp.makeConstraints{
            $0.top.equalTo(weatherInfo.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(infoCard).inset(12)
            $0.width.equalTo(infoCard.bounds.width-24)
            $0.height.equalTo(0.5)
        }

        //시간 별 날씨 정보를 스크롤 할 수 있는 수평스크롤뷰
        weatherScrollView.snp.makeConstraints{
            $0.top.equalTo(infoCard.safeAreaLayoutGuide.snp.top).inset(90)
            $0.leading.trailing.equalTo(infoCard).inset(12)
            $0.bottom.equalTo(infoCard.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.height.equalTo(0.5)
        }

        //시간 별 날씨 정보를 담은 스택뷰
        horizontalStackView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(weatherScrollView.contentLayoutGuide)
            $0.height.equalTo(weatherScrollView)
            $0.width.greaterThanOrEqualTo(weatherScrollView).priority(.low)
        }
        
        //[화면 하단] 구분선
        divider2.snp.makeConstraints{
            $0.bottom.equalTo(backgroundView).inset(82)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.4)
        }

        //[화면 하단] 버튼들을 담은 스택뷰
        bottomStackView.snp.makeConstraints{
            $0.top.equalTo(divider2.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(10)
            $0.height.equalTo(50)
        }
        arrowBtn.snp.makeConstraints{
            $0.top.bottom.leading.equalTo(container)
        }
        dotBtn.snp.makeConstraints{
            $0.top.bottom.trailing.equalTo(container)
        }
    }
    
    func setDetail(){
        backgroundView.image = UIImage(named: "weatherBg")
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        //[화면 상단]
        //위치, 기온, 날씨, 최고/최저 기온
        for i in [myLocation, temperature, weather, highNLow] {
            i.textColor = .white
            i.backgroundColor = .clear
            i.adjustsFontSizeToFitWidth = true
            i.textAlignment = .center
            i.snp.makeConstraints{
                $0.width.leading.trailing.equalTo(contentView)
            }
        }
        setFont(label: myLocation, fontName: "SFProDisplay-Regular", size: 36, text: "의정부시")
        setFont(label: temperature, fontName: "SFProDisplay-Thin", size: 102, text: "21º")
        setFont(label: weather, fontName: "SFProDisplay-Regular", size: 24, text: "흐림")
        setFont(label: highNLow, fontName: "SFProDisplay-Medium", size: 20, text: "최고:29º 최저:15º")
        
        //[화면 중앙]
        //시간 별 날씨 정보 카드
        infoCard.do{
            $0.backgroundColor = .white .withAlphaComponent(0.01)
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        }
        //날씨 설명 라벨
        weatherInfo.do{
            $0.backgroundColor = .clear
            $0.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 18)
            $0.textColor = .white
            $0.textAlignment = .left
        }
        //날씨 정보 카드 내 구분선
        divider1.do{
            $0.backgroundColor = .white.withAlphaComponent(0.3)
        }
        //시간 별 날씨 정보를 담은 수평 스택뷰
        horizontalStackView.do{
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 16
            $0.backgroundColor = .clear
            $0.isLayoutMarginsRelativeArrangement = true
            
        }

        //[화면 하단]
        //구분선
        divider2.do{
            $0.backgroundColor = .white.withAlphaComponent(0.3)
        }
        //버튼들을 담은 스택뷰
        bottomStackView.do{
            $0.backgroundColor = .clear
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.backgroundColor = .clear
            $0.isLayoutMarginsRelativeArrangement = true
        }
        //지도, 점, 화살표, 메인 버튼
        mapBtn.setImage(UIImage(named: "map"), for: .normal)
        arrowBtn.setImage(UIImage(named: "arrow"), for: .normal)
        dotBtn.setImage(UIImage(named: "dot"), for: .normal)
        //탭하면 메인으로 돌아갈 수 있도록 UIControl과 액션 연결
        mainBtn.addTarget(self, action: #selector(mainButtonTap(_:)), for: .touchUpInside)
        mainBtn.setImage(UIImage(named: "main"), for: .normal)

    }
    
    //폰트 세팅
    func setFont(label: UILabel, fontName: String, size: CGFloat, text: String){
        label.font = UIFont(name: fontName, size: size)
        label.text = text
    }
    
    //스택뷰 아이템 생성
    func setStackViewItem(time: String, icon: String, temperature: String) -> UIStackView {
        let view = UIStackView().then{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 10
        }

        let imageView = UIImageView().then{
            let image = UIImage(named: icon)
            $0.image = image
        }
        
        let timeLabel = UILabel().then{
            $0.text = time
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        let tempLabel = UILabel().then{
            $0.text = temperature
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        
        [timeLabel, imageView, tempLabel].forEach {
            NSLayoutConstraint.activate([$0.widthAnchor.constraint(equalToConstant: 44)])
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addArrangedSubview($0)
        }
        return view
    }
    
    //메인화면 pop
    @objc
    func mainButtonTap(_ gesture: UITapGestureRecognizer){
        print("pop")
        self.navigationController?.popViewController(animated: true)
    }

}
