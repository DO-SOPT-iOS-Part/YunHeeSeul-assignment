//
//  ViewController.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/17.
//

import UIKit

class ViewController: UIViewController {
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var menuBtn = UIButton()
    private var titleText = UILabel()
    private var searchBar = UISearchBar()
    private var searchImageView = UIImageView()
    private var leftStackView: UIStackView = {
        let leftStackView = UIStackView()
        leftStackView.axis = .vertical
        leftStackView.distribution = .fillEqually
        leftStackView.backgroundColor = .clear
        leftStackView.layer.cornerRadius = 10
        leftStackView.isLayoutMarginsRelativeArrangement = true
        return leftStackView
    }()
    private var rightStackView: UIStackView = {
        let rightStackView = UIStackView()
        rightStackView.axis = .vertical
        rightStackView.distribution = .fillEqually
        rightStackView.backgroundColor = .clear
        rightStackView.layer.cornerRadius = 10
        rightStackView.isLayoutMarginsRelativeArrangement = true
        return rightStackView
    }()
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(weatherInfoCardTap(_:)))
        setViewLayout()
        setComponentLayout()
        setSearchBarLayout()
        setWeatherInfoLayout(tapGesture)
    }
    
     func setViewLayout(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.backgroundColor = .black
        contentView.backgroundColor = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
        NSLayoutConstraint.activate([contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)])
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func setComponentLayout(){
        contentView.addSubViews(menuBtn, titleText)
        
        menuBtn.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        NSLayoutConstraint.activate([menuBtn.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     menuBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
                                     menuBtn.widthAnchor.constraint(equalToConstant: 42),
                                     menuBtn.heightAnchor.constraint(equalToConstant: 42)])
        
        titleText.text = "날씨"
        titleText.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        titleText.backgroundColor = .black
        titleText.textColor = .white
        NSLayoutConstraint.activate([titleText.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 10), titleText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     titleText.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     titleText.heightAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setSearchBarLayout(){
        contentView.addSubViews(searchBar)

        searchBar.placeholder = "도시 또는 공항 검색"
        searchBar.searchTextField.backgroundColor = UIColor(named: "searchBar")
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 19)
        searchBar.barTintColor = .clear

        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15),
                                     searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     searchBar.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     searchBar.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setWeatherInfoLayout(_ tapGesture: UITapGestureRecognizer) {
        contentView.addSubViews(weatherInfoView)
        weatherInfoView.addSubViews(leftStackView, rightStackView)
        weatherInfoView.image = UIImage(named: "weatherInfo")
        //addGestureRecognizer 을 통해 만든 gesture를 등록
        weatherInfoView.addGestureRecognizer(tapGesture)
        weatherInfoView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([weatherInfoView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
                                     weatherInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     weatherInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                                     weatherInfoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/7)])
        NSLayoutConstraint.activate([leftStackView.topAnchor.constraint(equalTo: weatherInfoView.topAnchor, constant: 6),
                                     leftStackView.bottomAnchor.constraint(equalTo: weatherInfoView.bottomAnchor, constant: 10),
                                     leftStackView.leadingAnchor.constraint(equalTo: weatherInfoView.leadingAnchor),
                                     leftStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
                                     leftStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2)])
        
        for i in [myLocation, city, weather] {
            leftStackView.addArrangedSubview(i)
            i.backgroundColor = .clear
            i.textColor = .white
            i.adjustsFontSizeToFitWidth = true
            NSLayoutConstraint.activate([i.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor, constant: 14)])
        }
        
        myLocation.text = "나의 위치"
        myLocation.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        NSLayoutConstraint.activate([myLocation.topAnchor.constraint(equalTo: leftStackView.topAnchor, constant: 0)])
        
        city.text = "의정부시"
        city.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        NSLayoutConstraint.activate([city.topAnchor.constraint(equalTo: myLocation.bottomAnchor, constant: -20)])
        
        weather.text = "흐림"
        weather.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        NSLayoutConstraint.activate([weather.bottomAnchor.constraint(equalTo: leftStackView.bottomAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([rightStackView.topAnchor.constraint(equalTo: weatherInfoView.topAnchor, constant: 6),
                                     rightStackView.trailingAnchor.constraint(equalTo: weatherInfoView.trailingAnchor, constant: -16),
                                     rightStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
                                     rightStackView.bottomAnchor.constraint(equalTo: weatherInfoView.bottomAnchor)])
        for i in [temperatures, blankView2, highNLow] {
            rightStackView.addArrangedSubview(i)
            i.backgroundColor = .clear
            i.textColor = .white
            NSLayoutConstraint.activate([i.widthAnchor.constraint(equalTo: rightStackView.widthAnchor),i.trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor, constant: 14)])
        }
        
        temperatures.text = "21º"
        temperatures.textAlignment = .right
        temperatures.font = UIFont(name: "SFProDisplay-Light", size: 52)
        NSLayoutConstraint.activate([temperatures.topAnchor.constraint(equalTo: rightStackView.topAnchor, constant: 10),
                                     temperatures.trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor, constant: -20)])
        
        highNLow.textAlignment = .right
        highNLow.text = "최고:29º 최저:15º"
        highNLow.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        NSLayoutConstraint.activate([highNLow.bottomAnchor.constraint(equalTo: rightStackView.bottomAnchor),
                                     highNLow.topAnchor.constraint(equalTo: temperatures.bottomAnchor, constant: 10)])

    }
    
    @objc
    func weatherInfoCardTap(_ gesture: UITapGestureRecognizer){
        print("tap")
    }
}



