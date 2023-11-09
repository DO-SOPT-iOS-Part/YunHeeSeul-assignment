import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    static let identifier : String = "ForecastCollectionView"
    private var day = UILabel()
    private var container = UIView()
    private var weatherIcon = UIImageView()
    private var percentage = UILabel()
    private var lowest = UILabel()
    private var progressBar = UIImageView()
    private var highest = UILabel()
    private var divider = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        self.contentView.addSubview(divider)
        self.contentView.addSubview(progressBar)

        for i in [day, container, lowest, highest] {
            self.contentView.addSubview(i)
            i.backgroundColor = .clear
            i.snp.makeConstraints{
                $0.top.equalTo(contentView)
                $0.bottom.equalTo(divider.snp.top)
            }
        }
        container.addSubview(weatherIcon)
        
        day.snp.makeConstraints{
            $0.width.equalTo(45)
            $0.leading.equalTo(contentView).inset(16)
        }
        container.snp.makeConstraints{
            $0.width.equalTo(35)
            $0.leading.equalTo(day.snp.trailing)
        }
        weatherIcon.snp.makeConstraints{
            $0.width.equalTo(32)
            $0.height.equalTo(26)
            $0.centerX.equalTo(container)
        }
        lowest.snp.makeConstraints{
            $0.width.equalTo(35)
            $0.leading.equalTo(container.snp.trailing).offset(15)
        }
        progressBar.snp.makeConstraints{
            $0.width.equalTo(108)
            $0.leading.equalTo(lowest.snp.trailing).offset(5)
            $0.height.equalTo(12)
            $0.centerY.equalTo(contentView)
        }
        highest.snp.makeConstraints{
            $0.width.equalTo(40)
            $0.leading.equalTo(progressBar.snp.trailing).offset(3)
            $0.trailing.equalTo(contentView).inset(16)
        }
        divider.snp.makeConstraints{
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(0.5)
            $0.top.equalTo(contentView).inset(55.5)
        }
    }
    
    private func setStyle(){
        contentView.backgroundColor = .clear
        day.setLabel(font: .medium(size: 22), bgColor: .clear, textColor: .white, text: "", textAlignment: .left)
        percentage.setLabel(font: .semibold(size: 15), bgColor: .clear, textColor: UIColor(red: 0.506, green: 0.812, blue: 0.98, alpha: 1), text: "", textAlignment: .left)
        lowest.setLabel(font: .medium(size: 22), bgColor: .clear, textColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3), text: "", textAlignment: .left)
        highest.setLabel(font: .medium(size: 22), bgColor: .clear, textColor: .white, text: "", textAlignment: .left)
        divider.do{
            $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        }
    }
    
    private func setIconStyle(text: String, icon: String){
        weatherIcon.do{
            $0.image = UIImage(systemName: icon)?.withRenderingMode(.alwaysOriginal)
            $0.tintColor = UIColor(red: 0.973, green: 0.843, blue: 0.29, alpha: 1)
        }
        if !text.isEmpty {
            container.addSubview(percentage)
            weatherIcon.snp.makeConstraints{
                $0.top.equalTo(container).inset(4)
            }
            percentage.snp.makeConstraints{
                $0.width.equalTo(container)
                $0.height.equalTo(18)
                $0.centerX.equalTo(container)
                $0.top.equalTo(weatherIcon.snp.bottom).offset(1)
            }
        }else{
            weatherIcon.snp.makeConstraints{
                $0.centerY.equalTo(container)
            }
        }
    }
    
    func bindData(data: ForecastData){
        let icon = UIImage(systemName: data.weatherIcon)
        let bar = UIImage(named: data.progressBar)
        self.day.text = data.day
        self.weatherIcon.image = icon
        self.percentage.text = data.percentage
        self.lowest.text = data.lowest
        self.progressBar.image = bar
        self.highest.text = data.highest
        
        guard let text = percentage.text else {return}
        setIconStyle(text: text, icon: data.weatherIcon)
    }
}
