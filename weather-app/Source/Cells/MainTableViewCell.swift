import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let identifier : String = "MainTableViewCell"
    private var leftStackView = UIStackView()
    private var rightStackView = UIStackView()
    private var blankView1 = UILabel()
    private var blankView2 = UILabel()
    private var weatherInfoView = UIImageView()
    private var myLocation = UILabel()
    private var city = UILabel()
    private var weather = UILabel()
    private var temperature = UILabel()
    private var highNLow = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        addSubview(weatherInfoView)
        [leftStackView, rightStackView].forEach{
            weatherInfoView.addSubview($0)
        }

        //[날씨 정보 카드]
        weatherInfoView.snp.makeConstraints{
            $0.top.equalTo(self).offset(10)
            $0.bottom.equalTo(self).inset(6)
            $0.width.equalTo(UIScreen.main.bounds.width-16)
            $0.leading.trailing.equalTo(self.contentView).inset(8)
        }
        
        //나의 위치,날씨 라벨을 담은 좌측 스택뷰
        leftStackView.snp.makeConstraints{
            $0.top.equalTo(weatherInfoView).inset(8)
            $0.bottom.equalTo(weatherInfoView).inset(12)
            $0.leading.equalTo(weatherInfoView).inset(10)
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
            $0.bottom.equalTo(weatherInfoView).offset(8)
            $0.trailing.equalTo(weatherInfoView).inset(16)
            $0.width.equalTo(UIScreen.main.bounds.width/2)
        }

        for i in [temperature, highNLow] {
            rightStackView.addArrangedSubview(i)
            i.snp.makeConstraints{
                $0.width.equalTo(rightStackView)
                $0.trailing.equalTo(rightStackView).inset(14)
            }
        }
        temperature.snp.makeConstraints{
            $0.top.equalTo(rightStackView)
            $0.trailing.equalTo(rightStackView)
        }
        highNLow.snp.makeConstraints{
            $0.trailing.equalTo(rightStackView)
            $0.top.equalTo(temperature.snp.bottom).offset(40)
        }
    }
    private func setStyle(){
        self.backgroundColor = .black
        //[날씨 정보 카드]
        weatherInfoView.image = UIImage(named: "weatherInfo")
        
        //나의 위치,날씨 라벨을 담은 좌측 스택뷰
        leftStackView.do{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10
            $0.isLayoutMarginsRelativeArrangement = true
        }
        myLocation.setLabel(font: .bold(size: 24), bgColor: .clear, textColor: .white, text: "", textAlignment: .left)
        city.setLabel(font: .medium(size: 17), bgColor: .clear, textColor: .white, text: "", textAlignment: .left)
        weather.setLabel(font: .medium(size: 16), bgColor: .clear, textColor: .white, text: "", textAlignment: .left)

        //기온, 최고/최저 기온 라벨을 담은 우측 스택뷰
        rightStackView.do{
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10
            $0.isLayoutMarginsRelativeArrangement = true
        }
        temperature.setLabel(font: .light(size: 52), bgColor: .clear, textColor: .white, text: "", textAlignment: .right)
        highNLow.setLabel(font: .medium(size: 15), bgColor: .clear, textColor: .white, text: "", textAlignment: .right)
    }
    
    func bindData(data: WeatherInfoData){
        self.myLocation.text = data.myLocation
        self.city.text = data.city
        self.weather.text = data.weather
        self.temperature.text = "\(String(format: "%.0f", data.temperature))º"
        self.highNLow.text = "최고:\(String(format: "%.0f", data.high))º 최저:\(String(format: "%.0f", data.low))º"
    }
}
