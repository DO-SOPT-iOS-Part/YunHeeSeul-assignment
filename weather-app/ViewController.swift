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
    private var titleText = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        setComponentLayout()
        getFontName()
    }
    
    func getFontName() {
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
    
    private func setViewLayout(){
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
                                     menuBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     menuBtn.widthAnchor.constraint(equalToConstant: 44),
                                     menuBtn.heightAnchor.constraint(equalToConstant: 44)])
        
        titleText.text = "날씨"
        titleText.font = UIFont(name: "SFProDisplay-Bold", size: 36)
        titleText.backgroundColor = .black
        titleText.textColor = .white
        NSLayoutConstraint.activate([titleText.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 10), titleText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     titleText.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     titleText.heightAnchor.constraint(equalToConstant: 44)])
    }
}

extension UIView {
        func addSubViews(_ views: UIView...) {
                views.forEach {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview($0)
                }
        }
}



