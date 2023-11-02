import UIKit
import SnapKit

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
    private var divider2 = UIView()
    private var bottomStackView = UIStackView()
    private var mapBtn = UIButton()
    private var mainBtn = UIButton()
    private var dotBtn = UIButton()
    private var arrowBtn = UIButton()
    private var container = UIView()
    
    private var weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var forecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView?.backgroundColor = .clear
        setViewLayout()
        setDetail()
        setCollectionViewLayout()
        setForecastViewLayout()
    }
    
    func setViewLayout(){
        self.view.addSubViews(backgroundView, scrollView,divider2,bottomStackView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(myLocation, temperature, weather, highNLow, infoCard, forecastCollectionView)
        infoCard.addSubViews(weatherInfo, divider1, weatherCollectionView)
        
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

        //[화면 하단] 구분선
        divider2.snp.makeConstraints{
            $0.bottom.equalTo(backgroundView).inset(82)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.4)
        }
        
        //스크롤뷰
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalTo(divider2.snp.top)
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
        
        //[화면 중앙]
        //시간 별 날씨 정보 카드
        infoCard.snp.makeConstraints{
            $0.top.equalTo(highNLow.snp.bottom).offset(60)
            $0.leading.trailing.equalTo(contentView).inset(20)
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
        //시간 별 날씨 collectionview
        weatherCollectionView.snp.makeConstraints{
            $0.top.equalTo(divider1.snp.bottom)
            $0.leading.trailing.bottom.equalTo(infoCard).inset(10)
        }
        

        
        //10일간 일기예보 collectionview
        forecastCollectionView.snp.makeConstraints{
            $0.top.equalTo(infoCard.snp.bottom).offset(20)
            $0.height.equalTo(675)
            $0.bottom.equalTo(contentView)
            $0.leading.trailing.equalTo(contentView).inset(20)
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
        //시간 별 날씨 collectionview
        weatherCollectionView.do{
            $0.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier:WeatherCollectionViewCell.identifier)
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
        }
        
        headerView.do{
            $0.backgroundColor = .clear
        }

        //10일간 일기예보 collectionview
        forecastCollectionView.do{
            $0.isScrollEnabled = false
            $0.layer.cornerRadius = 15
            $0.layer.borderWidth = 0.5
            $0.layer.backgroundColor = UIColor(red: 0.175, green: 0.201, blue: 0.249, alpha: 0.2).cgColor
            $0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
            $0.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
            $0.register(ForecastCollectionReusableView.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ForecastCollectionReusableView.identifier)
            $0.dataSource = self
            $0.delegate = self
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
    private func setCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 44 , height: UIScreen.main.bounds.height/8)
        flowLayout.minimumLineSpacing = 12
        self.weatherCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    private func setForecastViewLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0.5
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40 , height: 55.5)
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width - 40 , height: 40)
        self.forecastCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    
    //폰트 세팅
    func setFont(label: UILabel, fontName: String, size: CGFloat, text: String){
        label.font = UIFont(name: fontName, size: size)
        label.text = text
    }
    
    //메인화면 pop
    @objc
    func mainButtonTap(_ gesture: UITapGestureRecognizer){
        print("pop")
        self.navigationController?.popViewController(animated: true)
    }

}
extension WeatherViewController: UICollectionViewDelegate{}
extension WeatherViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weatherCollectionView {
            return HourlyWeatherData.hourlyWeatherData.count
        }else{
            return ForecastData.forecastData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weatherCollectionView {
            guard let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
            weatherCell.bindData(data: HourlyWeatherData.hourlyWeatherData[indexPath.row])
            return weatherCell
        }else{
            guard let forecastCell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as? ForecastCollectionViewCell else {return UICollectionViewCell()}
            forecastCell.bindData(data: ForecastData.forecastData[indexPath.row])
            return forecastCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ForecastCollectionReusableView.identifier, for: indexPath) as? ForecastCollectionReusableView else {return UICollectionReusableView()}
        return headerView
    }
}
