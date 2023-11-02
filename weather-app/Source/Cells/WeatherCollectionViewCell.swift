import UIKit
import SnapKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "WeatherCollectionViewCell"
    private var verticalStackView = UIStackView()
    private var imageView = UIImageView()
    private var timeLabel = UILabel()
    private var tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
//        set
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        self.contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalTo(self.contentView)
        }
        for i in [timeLabel, imageView, tempLabel] {
            verticalStackView.addArrangedSubview(i)
            i.snp.makeConstraints{
                $0.width.equalTo(44)
            }
        }
    }
    
    private func setStyle(){
        verticalStackView.do{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 12
        }
        timeLabel.do{
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 17)
            $0.textColor = .white
            $0.textAlignment = .center
        }
        tempLabel.do{
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 22)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    }
    
    func bindData(data: HourlyWeatherData){
        self.timeLabel.text = data.time
        let icon = UIImage(named: data.icon)
        self.imageView.image = icon
        self.tempLabel.text = data.temperature
    }
    
}
