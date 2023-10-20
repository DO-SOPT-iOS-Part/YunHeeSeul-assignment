//
//  WeatherViewController.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/18.
//

import UIKit

class WeatherViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIImageView()
    private var myLocation = UILabel()
    private var temperature = UILabel()
    private var weather = UILabel()
    private var highNLow = UILabel()
    private var infoCard = UIView()
    private var weatherInfo = UITextView()
    private var divider1 = UIView()
    private var weatherScrollView = UIScrollView()
    private var contentView2 = UIView()
    private var horizontalStackView : UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 16
        horizontalStackView.backgroundColor = .clear
        horizontalStackView.layer.cornerRadius = 10
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        return horizontalStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        setTopLayout()
        setMiddleLayout()
        setBottomLayout()
    }
    
    func setViewLayout(){
        self.view.addSubViews(scrollView)
        scrollView.backgroundColor = .white
        scrollView.addSubViews(contentView)
        contentView.image = UIImage(named: "weatherBg")
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                    ])
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.isActive = true
    }
    func setTopLayout(){
        contentView.addSubViews(myLocation, temperature, weather, highNLow)
        for i in [myLocation, temperature, weather, highNLow] {
            i.textColor = .white
            i.backgroundColor = .clear
            i.adjustsFontSizeToFitWidth = true
            
            NSLayoutConstraint.activate([i.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                         i.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                         i.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
            i.textAlignment = .center
        }
        NSLayoutConstraint.activate([myLocation.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
                                     temperature.topAnchor.constraint(equalTo: myLocation.bottomAnchor, constant: 6),
                                     weather.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 6),
                                     highNLow.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 5)])
        setFont(label: myLocation, fontName: "SFProDisplay-Regular", size: 36, text: "의정부시")
        setFont(label: temperature, fontName: "SFProDisplay-Thin", size: 102, text: "21º")
        setFont(label: weather, fontName: "SFProDisplay-Regular", size: 24, text: "흐림")
        setFont(label: highNLow, fontName: "SFProDisplay-Medium", size: 20, text: "최고:29º 최저:15º")
        
    }
    
    func setMiddleLayout(){
        contentView.addSubViews(infoCard)
        infoCard.backgroundColor = .white .withAlphaComponent(0.01)
        infoCard.layer.cornerRadius = 15
        infoCard.layer.borderWidth = 0.5
        
        infoCard.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        NSLayoutConstraint.activate([infoCard.topAnchor.constraint(equalTo: highNLow.bottomAnchor, constant: 60),
                                     infoCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     infoCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     infoCard.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-32),
                                     infoCard.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/4)])
        
        infoCard.addSubViews(weatherInfo, divider1, weatherScrollView)
        
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
        
        NSLayoutConstraint.activate([weatherScrollView.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 16),
                                     weatherScrollView.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 12),
                                     weatherScrollView.bottomAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: -16),
                                     weatherScrollView.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -12)])
        let width = weatherScrollView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, constant: -30)
        width.priority = .defaultLow
        width.isActive = true
        weatherScrollView.addSubViews(horizontalStackView)

        NSLayoutConstraint.activate([horizontalStackView.topAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.topAnchor),
                                     horizontalStackView.leadingAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.leadingAnchor),
                                     horizontalStackView.trailingAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.trailingAnchor),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: weatherScrollView.contentLayoutGuide.bottomAnchor),
                                     horizontalStackView.heightAnchor.constraint(equalTo: weatherScrollView.heightAnchor)])
        
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

}
