import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    private var mainTableView = UITableView(frame: .zero, style: .grouped)
    private var headerView = UIView()
    private var menuBtn = UIButton()
    private var titleText = UILabel()
    private var searchBar = UISearchBar()
    private var data: [WeatherInfoData] = WeatherInfoData.weatherInfoData
    private var filteredData: [WeatherInfoData] = []
    private var isFiltered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setDetail()
        setViewLayout()
    }
    
    func setViewLayout(){
        self.view.addSubview(mainTableView)
        headerView.addSubViews(menuBtn, titleText, searchBar)

        mainTableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        //[메뉴 아이콘]
        menuBtn.snp.makeConstraints{
            $0.top.equalTo(headerView)
            $0.size.equalTo(42)
            $0.trailing.equalTo(headerView).inset(8)
        }
        //[날씨라벨]
        titleText.snp.makeConstraints{
            $0.top.equalTo(menuBtn.snp.bottom).offset(10)
            $0.leading.equalTo(headerView).inset(8)
            $0.width.equalTo(headerView)
            $0.height.equalTo(44)
        }

        //[서치바]
        searchBar.snp.makeConstraints{
            $0.top.equalTo(titleText.snp.bottom).offset(15)
            $0.leading.trailing.width.equalTo(headerView)
            $0.height.equalTo(40)
            $0.bottom.equalTo(headerView).inset(10)
        }
    }
    func setDetail(){
        self.view.backgroundColor = .black
                
        //테이블뷰 스타일 지정하기
        mainTableView.do{
            $0.backgroundColor = .black
            $0.separatorStyle = .none
            $0.separatorColor = .black
            $0.rowHeight = UIScreen.main.bounds.height/6
            $0.dataSource = self
            $0.delegate = self
            $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
            $0.tableHeaderView = headerView
            $0.showsVerticalScrollIndicator = false
        }
        
        headerView.do{
            $0.backgroundColor = .black
            $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height/5.5)
        }
        headerView.layoutIfNeeded()

        menuBtn.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        titleText.do{
            $0.text = "날씨"
            $0.font = UIFont(name: "SFProDisplay-Bold", size: 36)
            $0.backgroundColor = .black
            $0.textColor = .white
        }

        //[서치바]
        searchBar.do{
            $0.delegate = self
            $0.placeholder = "도시 또는 공항 검색"
            $0.searchTextField.backgroundColor = UIColor(named: "searchBar")
            $0.searchTextField.textColor = .white
            $0.searchTextField.attributedPlaceholder = NSAttributedString(string: $0.searchTextField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            $0.searchTextField.leftView?.tintColor = UIColor.lightGray
            $0.searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 19)
            $0.barTintColor = .clear
        }
    }
}
extension ViewController: UITableViewDelegate{}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        if isFiltered {
            cell.bindData(data: filteredData[indexPath.row])
        }else{
            cell.bindData(data: data[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushData = data[indexPath.row]
        let weatherVC = WeatherViewController()
        weatherVC.setInfo(myLocation: pushData.myLocation, temperature: pushData.temperature, weather: pushData.weather, highNLow: pushData.highNLow)
        self.navigationController?.pushViewController(weatherVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: UISearchBarDelegate{
    //서치바에서 검색을 시작할 때 호출
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.lowercased() else { return }
        if text == ""{
            self.isFiltered = false
        }else {
            self.isFiltered = true
        }
        self.mainTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        if text == "" {
            isFiltered = false
            mainTableView.reloadData()
        } else {
            isFiltered = true
            filteredData = data.filter({$0.myLocation.localizedCaseInsensitiveContains(searchBar.text ?? "")})
            print("filter \(filteredData)")
            mainTableView.reloadData()
        }
    }
    
    // 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()

        guard let text = searchBar.text?.lowercased() else { return }
        self.filteredData = self.data.filter{
            $0.myLocation.localizedCaseInsensitiveContains(text)
        }
        self.mainTableView.reloadData()
    }
    
    // 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.isFiltered = false
        self.mainTableView.reloadData()
    }
    
    // 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.mainTableView.reloadData()
    }
    
    // 서치바 키보드 내리기
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}



