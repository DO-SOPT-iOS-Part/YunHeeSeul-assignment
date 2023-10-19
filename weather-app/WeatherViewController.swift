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
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                     contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)])
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
                                     temperature.topAnchor.constraint(equalTo: myLocation.bottomAnchor, constant: 10),
                                     weather.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 10),
                                     highNLow.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 5)])
        setFont(label: myLocation, fontName: "SFProDisplay-Regular", size: 36, text: "의정부시")
        setFont(label: temperature, fontName: "SFProDisplay-Thin", size: 102, text: "21º")
        setFont(label: weather, fontName: "SFProDisplay-Regular", size: 24, text: "흐림")
        setFont(label: highNLow, fontName: "SFProDisplay-Medium", size: 20, text: "최고:29º 최저:15º")

    }
    
    func setMiddleLayout(){
        
    }
    
    func setBottomLayout(){
        
    }
    
    func setFont(label: UILabel, fontName: String, size: CGFloat, text: String){
        label.font = UIFont(name: fontName, size: size)
        label.text = text
    }
}
