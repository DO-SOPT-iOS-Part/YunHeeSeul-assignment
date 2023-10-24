//
//  WeatherViewController.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/18.
//

import UIKit

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
    private var horizontalStackView : UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 16
        horizontalStackView.backgroundColor = .clear
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        return horizontalStackView
    }()
    private var divider2 = UIView()
    private var bottomStackView : UIStackView = {
        let bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .equalSpacing
        bottomStackView.backgroundColor = .clear
        bottomStackView.isLayoutMarginsRelativeArrangement = true
        return bottomStackView
    }()
    private var mapBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "map"), for: .normal)
        return btn
    }()
    private var mainBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "main"), for: .normal)
        return btn
    }()
    private var dotBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dot"), for: .normal)
        return btn
    }()
    private var arrowBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow"), for: .normal)
        return btn
    }()
    private var container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setViewLayout()
        setTopLayout()
        setMiddleLayout()
        setBottomLayout()
    }
    
    func setViewLayout(){
        self.view.addSubViews(backgroundView, scrollView)
        backgroundView.image = UIImage(named: "weatherBg")
        scrollView.backgroundColor = .clear
        scrollView.addSubViews(contentView)
        contentView.backgroundColor = .clear
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                                     backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                    ])
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    func setTopLayout(){
        contentView.addSubViews(myLocation, temperature, weather, highNLow)
        for i in [myLocation, temperature, weather, highNLow] {
            i.textColor = .white
            i.backgroundColor = .clear
            i.adjustsFontSizeToFitWidth = true
            i.textAlignment = .center
            NSLayoutConstraint.activate([i.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                         i.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                         i.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
        }
        
        NSLayoutConstraint.activate([myLocation.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
                                     myLocation.heightAnchor.constraint(equalToConstant: 40),
                                     temperature.topAnchor.constraint(equalTo: myLocation.bottomAnchor, constant: 4),
                                     temperature.heightAnchor.constraint(equalToConstant: 110),
                                     weather.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 4),
                                     weather.heightAnchor.constraint(equalToConstant: 30),
                                     highNLow.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 4),
                                     highNLow.heightAnchor.constraint(equalToConstant: 24)])
        setFont(label: myLocation, fontName: "SFProDisplay-Regular", size: 36, text: "의정부시")
        setFont(label: temperature, fontName: "SFProDisplay-Thin", size: 102, text: "21º")
        setFont(label: weather, fontName: "SFProDisplay-Regular", size: 24, text: "흐림")
        setFont(label: highNLow, fontName: "SFProDisplay-Medium", size: 20, text: "최고:29º 최저:15º")
        
    }
    
    func setMiddleLayout(){
        contentView.addSubViews(infoCard)
        infoCard.addSubViews(weatherInfo, divider1, weatherScrollView)
        weatherScrollView.addSubViews(horizontalStackView)

        infoCard.backgroundColor = .white .withAlphaComponent(0.01)
        infoCard.layer.cornerRadius = 15
        infoCard.layer.borderWidth = 0.5
        
        infoCard.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        NSLayoutConstraint.activate([infoCard.topAnchor.constraint(equalTo: highNLow.bottomAnchor, constant: 60),
                                     infoCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     infoCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     infoCard.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-32),
                                     infoCard.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)])
                
        weatherInfo.backgroundColor = .clear
        weatherInfo.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        weatherInfo.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        weatherInfo.textColor = .white
        weatherInfo.textAlignment = .left
        NSLayoutConstraint.activate([weatherInfo.topAnchor.constraint(equalTo: infoCard.topAnchor, constant: 6),
                                     weatherInfo.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 12),
                                     weatherInfo.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -12),
                                     weatherInfo.widthAnchor.constraint(equalToConstant: infoCard.bounds.width-24),
                                     weatherInfo.heightAnchor.constraint(equalToConstant: 60)])
        divider1.backgroundColor = .white.withAlphaComponent(0.3)
        NSLayoutConstraint.activate([divider1.topAnchor.constraint(equalTo: weatherInfo.bottomAnchor, constant: 6),
                                     divider1.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 12),
                                     divider1.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -12),
                                     divider1.widthAnchor.constraint(equalToConstant: infoCard.bounds.width-24),
                                     divider1.heightAnchor.constraint(equalToConstant: 0.5)])
        
        NSLayoutConstraint.activate([weatherScrollView.topAnchor.constraint(equalTo: infoCard.safeAreaLayoutGuide.topAnchor, constant: 90),
                                     weatherScrollView.leadingAnchor.constraint(equalTo: infoCard.safeAreaLayoutGuide.leadingAnchor, constant: 12),
                                     weatherScrollView.bottomAnchor.constraint(equalTo: infoCard.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                                     weatherScrollView.trailingAnchor.constraint(equalTo: infoCard.safeAreaLayoutGuide.trailingAnchor, constant: -12)])

        NSLayoutConstraint.activate([horizontalStackView.topAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.topAnchor),
                                     horizontalStackView.leadingAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.leadingAnchor),
                                     horizontalStackView.trailingAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.trailingAnchor),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.bottomAnchor),
                                     horizontalStackView.heightAnchor.constraint(equalTo: weatherScrollView.heightAnchor)])
        let width = horizontalStackView.widthAnchor.constraint(greaterThanOrEqualTo: weatherScrollView.widthAnchor)
        width.priority = .defaultLow
        width.isActive = true
        
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
        
    }
    
    func setBottomLayout(){
        contentView.addSubViews(divider2, bottomStackView)
        divider2.backgroundColor = .white.withAlphaComponent(0.3)
        NSLayoutConstraint.activate([divider2.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -82),
                                     divider2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     divider2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     divider2.heightAnchor.constraint(equalToConstant: 0.4)])
        bottomStackView.backgroundColor = .clear
        NSLayoutConstraint.activate([bottomStackView.heightAnchor.constraint(equalToConstant: 50),
                                     bottomStackView.topAnchor.constraint(equalTo: divider2.bottomAnchor),
                                     bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
        [mapBtn, container, mainBtn].forEach {
            bottomStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
        
        container.addSubViews(arrowBtn, dotBtn)
        NSLayoutConstraint.activate([arrowBtn.topAnchor.constraint(equalTo: container.topAnchor),
                                     arrowBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                                     arrowBtn.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                                     dotBtn.topAnchor.constraint(equalTo: container.topAnchor),
                                     dotBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                                     dotBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor)])
        
        mainBtn.addTarget(self, action: #selector(mainButtonTap(_:)), for: .touchUpInside)

    }
    
    func setFont(label: UILabel, fontName: String, size: CGFloat, text: String){
        label.font = UIFont(name: fontName, size: size)
        label.text = text
    }
    
    func setStackViewItem(time: String, icon: String, temperature: String) -> UIStackView {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10
        
        let imageView = UIImageView()
        let image = UIImage(named: icon)
        imageView.image = image
        
        let timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        
        let tempLabel = UILabel()
        tempLabel.text = temperature
        tempLabel.font = UIFont(name: "SFProDisplay-Medium", size: 22)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        
        [timeLabel, imageView, tempLabel].forEach {
            NSLayoutConstraint.activate([$0.widthAnchor.constraint(equalToConstant: 44)])
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addArrangedSubview($0)
        }
        return view
    }
    
    @objc
    func mainButtonTap(_ gesture: UITapGestureRecognizer){
        print("pop")
        let mainVC = ViewController()
        self.navigationController?.popViewController(animated: true)
    }

}
