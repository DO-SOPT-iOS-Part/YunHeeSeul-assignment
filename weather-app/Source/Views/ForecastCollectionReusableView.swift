import UIKit

class ForecastCollectionReusableView: UICollectionReusableView {
    static let identifier: String = "ForecastCollectionReusableView"
    private var calendar = UIImageView()
    private var forecastLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        [calendar, forecastLabel].forEach{
            self.addSubview($0)
        }
        //일기예보 아이콘
        calendar.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(15)
            $0.size.equalTo(24)
        }
        //일기예보 라벨
        forecastLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(calendar.snp.trailing).offset(5)
            $0.height.equalTo(24)
        }
    }
    private func setStyle(){
        calendar.do{
            let image = UIImage(named: "calendar")
            $0.image = image
        }
        forecastLabel.do{
            $0.alpha = 0.3
            $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
            $0.text = "10일간의 일기예보"
        }
    }
}
