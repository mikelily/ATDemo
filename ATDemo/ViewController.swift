//
//  ViewController.swift
//  ATDemo
//
//  Created by 林華淵 on 2022/3/16.
//

import UIKit
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {
    
    var tempDateData: DateData?
    var tempUserData: UserData?
    
    let theManager = DateUtil.shared
    var weekDay1: Date = Date()
    var weekDay7: Date = Date()
    var currentWeek: Int = 0{
        didSet{
            if currentWeek == 1{
                leftArrowImageView.changeTo(color: colorGreen)
            }else if currentWeek == 0{
                leftArrowImageView.changeTo(color: .lightGray)
            }
            refreshViewsByWeekChange()
        }
    }
    
    let avatarHeight: CGFloat = 100
    let calenderCellWidth: CGFloat = 80
    let calenderCellHeight: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        getFirstWeekData()
        getUserData {
            self.setUserView()
            self.setWeekViews()
            self.setUserCalender()
        }
    }
    
    func getFirstWeekData(){
        weekDay1 = theManager.getWeekDate().0
        weekDay7 = theManager.getWeekDate().1
    }

    func getUserData(completion : @escaping ()->()){
        let responeJson = testGetUserData(caseID: 0)
        tempUserData = UserData(
            title: responeJson["title"].string ?? "",
            subTitle: responeJson["subTitle"].string ?? "",
            totalClass: responeJson["totalClass"].int ?? 0,
            avatar: responeJson["avatar"].string ?? "")
        completion()
    }
    
    let splitView2 = UIView()
    func setUserView(){
        let backImageView = UIImageView(image: UIImage(systemName: "arrow.uturn.backward"))
        backImageView.changeTo(color: .black)
        view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10+statusBarHeight)
            make.width.height.equalTo(25)
        }
        
        let splitView = UIView()
        splitView.backgroundColor = .lightGray
        view.addSubview(splitView)
        splitView.snp.makeConstraints { make in
            make.top.equalTo(backImageView.snp.bottom).offset(5)
            make.right.left.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let avatarView = UIImageView(image: UIImage(named: tempUserData!.avatar))
        avatarView.layer.cornerRadius = avatarHeight/2
        avatarView.clipsToBounds = true
        view.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(avatarHeight)
            make.top.equalTo(splitView.snp.bottom).offset(15)
        }
        
//        let splitView2 = UIView()
        splitView2.backgroundColor = .lightGray
        view.addSubview(splitView2)
        splitView2.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(15)
            make.right.left.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = tempUserData?.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarView)
            make.left.equalTo(avatarView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = tempUserData?.subTitle
        subTitleLabel.font = .boldSystemFont(ofSize: 16)
        subTitleLabel.textColor = colorGreen
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(titleLabel)
        }
        
        let totalClassNumLabel = UILabel()
        totalClassNumLabel.text = "\(tempUserData?.totalClass ?? 0)"
        totalClassNumLabel.font = .boldSystemFont(ofSize: 14)
        view.addSubview(totalClassNumLabel)
        totalClassNumLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.left.equalTo(subTitleLabel)
        }
        
        let totalClassLabel = UILabel()
        totalClassLabel.text = "堂日文課完成"
        totalClassLabel.font = .systemFont(ofSize: 14)
        view.addSubview(totalClassLabel)
        totalClassLabel.snp.makeConstraints { make in
            make.left.equalTo(totalClassNumLabel.snp.right).offset(5)
            make.bottom.equalTo(totalClassNumLabel)
        }
    }
    
    let leftArrowImageView = UIImageView(image: UIImage(systemName: "chevron.left"))
    let rightArrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    let weekRangeLabel = UILabel()
    let splitView3 = UIView()
    func setWeekViews(){
        weekRangeLabel.text = getWeekRangeString()
        weekRangeLabel.font = .systemFont(ofSize: 25)
        view.addSubview(weekRangeLabel)
        weekRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(splitView2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        let introLabel = UILabel()
        introLabel.text = "*時間以 \(timeZone)時間(\(gmt))顯示"
        introLabel.font = .systemFont(ofSize: 12)
        introLabel.textColor = .lightGray
        view.addSubview(introLabel)
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(weekRangeLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        splitView3.backgroundColor = .lightGray
        view.addSubview(splitView3)
        splitView3.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(20)
            make.right.left.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let viewForMiddle = UIView()
        view.addSubview(viewForMiddle)
        viewForMiddle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(splitView2)
            make.bottom.equalTo(splitView3)
        }
        
        leftArrowImageView.changeTo(color: currentWeek == 0 ? .lightGray : colorGreen)
        view.addSubview(leftArrowImageView)
        leftArrowImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
            make.centerY.equalTo(viewForMiddle)
        }
        leftArrowImageView.addTapGestureRecognizer {
            if self.currentWeek != 0{
                self.currentWeek -= 1
            }
        }
        
        rightArrowImageView.changeTo(color: colorGreen)
        view.addSubview(rightArrowImageView)
        rightArrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.height.centerY.equalTo(leftArrowImageView)
        }
        rightArrowImageView.addTapGestureRecognizer {
            self.currentWeek += 1
        }
    }
    
    func getWeekRangeString() -> String {
        var returnString: String = ""
        
        var dateComponet = DateComponents()
        dateComponet.day = currentWeek * 7
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let day1 = Calendar.current.date(byAdding: dateComponet, to: weekDay1)!
        returnString = dateFormatter.string(from: day1)
        
        dateFormatter.dateFormat = "MM/dd"
        let day7 = Calendar.current.date(byAdding: dateComponet, to: weekDay7)!
        returnString = returnString + " - " + dateFormatter.string(from: day7)
        
        return returnString
    }
    
    func refreshViewsByWeekChange(){
        weekRangeLabel.text = getWeekRangeString()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        dateFormatter.dateFormat = "dd"
        
        var dateComponet = DateComponents()
        
        for index in 0..<calenderDayLabels.count{
            dateComponet.day = index + currentWeek*7
            calenderDayLabels[index].text = dateFormatter.string(from: Calendar.current.date(byAdding: dateComponet, to: weekDay1)!)
        }
        
        hScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        vScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        for sv in vContainerView.subviews{
            sv.removeFromSuperview()
        }
        
        getWeekData {
            self.setActView(openOrClose: false)
            self.setAvailableData()
            self.setBookedData()
        }
//        setAvailableData()
//        setBookedData()
    }
    
    var calenderDayLabels: [UILabel] = []
    let hScrollView = UIScrollView()
    let vScrollView = UIScrollView()
    let vContainerView = UIView()
    func setUserCalender(){
        hScrollView.bounces = false
        hScrollView.showsVerticalScrollIndicator = false
        hScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(hScrollView)
        hScrollView.snp.makeConstraints { make in
            make.top.equalTo(splitView3).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
        
        let hContainerView = UIView()
        hScrollView.addSubview(hContainerView)
        hContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(calenderCellWidth*7)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.ReferenceType.system
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        dateFormatter.dateFormat = "dd"
        
        var dateComponet = DateComponents()
        
        let weekdaySymbols: [String] = ["週日","週一","週二","週三","週四","週五","週六"]
        for index in 0..<weekdaySymbols.count{
            let weekdaySymbolLabel = UILabel()
            weekdaySymbolLabel.text = weekdaySymbols[index]
            hContainerView.addSubview(weekdaySymbolLabel)
            weekdaySymbolLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.centerX.equalTo(hContainerView.snp.left).offset(calenderCellWidth/2+calenderCellWidth*CGFloat(index))
            }
            
            let calenderDayLabel = UILabel()
            calenderDayLabels.append(calenderDayLabel)
            dateComponet.day = index
            calenderDayLabel.text = dateFormatter.string(from: Calendar.current.date(byAdding: dateComponet, to: weekDay1)!)
            hContainerView.addSubview(calenderDayLabel)
            calenderDayLabel.snp.makeConstraints { make in
                make.top.equalTo(weekdaySymbolLabel.snp.bottom).offset(5)
                make.centerX.equalTo(weekdaySymbolLabel)
            }
        }
        
        hContainerView.addSubview(vScrollView)
        vScrollView.bounces = false
        vScrollView.showsVerticalScrollIndicator = false
        vScrollView.showsHorizontalScrollIndicator = false
        vScrollView.snp.makeConstraints { make in
            make.top.equalTo(calenderDayLabels[0].snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
        
        vScrollView.addSubview(vContainerView)
        vContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(calenderCellHeight*10+120)
        }
        
        getWeekData {
            self.setActView(openOrClose: false)
            self.setAvailableData()
            self.setBookedData()
        }
        
    }
    
    func getWeekData(completion : @escaping ()->()) {
        
        self.setActView(openOrClose: true)  // 模擬讀取
        
        let responeJson = testGetDatas(weekIndex: currentWeek)
        
        tempDateData = DateData()   //init
        
        for availableData in responeJson["available"].arrayValue {
            
            let startTime = theManager.getDateFromString(strDate: availableData["start"].string!)
            
            if startTime > Date() || Calendar.current.isDate(startTime, inSameDayAs: Date()){
                tempDateData?.availableDatas.append(
                    StartEndTime(
                        startTime: startTime,
                        endTime: theManager.getDateFromString(strDate: availableData["end"].string!)
                    )
                )
            }
            
        }
        
        for bookedData in responeJson["booked"].arrayValue {
            
            let startTime = theManager.getDateFromString(strDate: bookedData["start"].string!)
            
            if startTime > Date() || Calendar.current.isDate(startTime, inSameDayAs: Date()){
                tempDateData?.bookedDatas.append(
                    StartEndTime(
                        startTime: theManager.getDateFromString(strDate: bookedData["start"].string!),
                        endTime: theManager.getDateFromString(strDate: bookedData["end"].string!)
                    )
                )
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            completion()
        }
    }
    
    var tupleForBooked: [(Int,Int,String)] = []
    func setAvailableData(){
        
        tupleForBooked = [] // init
        
        var targetDate = Date()
        var dateComponet = DateComponents()
        for index in 0..<7{
            dateComponet.day = index + currentWeek*7
            targetDate = Calendar.current.date(byAdding: dateComponet, to: weekDay1)!
            for availableData in tempDateData!.availableDatas{
                if Calendar.current.isDate(availableData.startTime, inSameDayAs: targetDate){
//                    print(index)
                    let calendar = Calendar.current
                    let diff:DateComponents = calendar.dateComponents([.minute], from: availableData.startTime, to: availableData.endTime)
//                    print(diff.minute)
                    let cellCount = diff.minute!/30
                    if cellCount > 10{
                        vContainerView.snp.updateConstraints { make in
                            make.height.equalTo(calenderCellHeight*CGFloat(cellCount)+120)
                        }
                    }
                    
                    let startTime = availableData.startTime
                    var dateComponet = DateComponents()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    
                    for index2 in 0..<cellCount{
                        dateComponet.minute = index2*30
                        
                        let timeCell = UIView()
                        timeCell.tag = 100*index + index2
                        timeCell.layer.cornerRadius = 3
                        timeCell.backgroundColor = colorLightGreen
                        vContainerView.addSubview(timeCell)
                        timeCell.snp.makeConstraints { make in
                            make.centerX.equalTo(vContainerView.snp.left).offset(calenderCellWidth/2+calenderCellWidth*CGFloat(index))
                            make.top.equalToSuperview().offset(10+(10+calenderCellHeight)*CGFloat(index2))
                            make.width.equalTo(calenderCellWidth-10)
                            make.height.equalTo(calenderCellHeight)
                        }
                        
                        let timeLabel = UILabel()
                        timeLabel.tag = 100*index + index2
                        let timeLabelText = dateFormatter.string(from: Calendar.current.date(byAdding: dateComponet, to: startTime)!)
                        timeLabel.text = timeLabelText
//                        print(index, index2, timeLabelText)
                        tupleForBooked.append((index, index2, timeLabelText))
                        timeLabel.font = .systemFont(ofSize: 12)
                        timeLabel.textColor = colorGreen
                        vContainerView.addSubview(timeLabel)
//                        timeCell.addSubview(timeLabel)
                        timeLabel.snp.makeConstraints { make in
//                            make.center.equalToSuperview()
                            make.center.equalTo(timeCell)
                        }
                    }
                }
            }
            
        }
    }
    
    func setBookedData(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        var dateComponet = DateComponents()
        var dayList : [Date] = []
        
        for i in 0..<7{
            dateComponet.day = i + currentWeek*7
            dayList.append(Calendar.current.date(byAdding: dateComponet, to: weekDay1)!)
        }
        
        for bookedData in tempDateData!.bookedDatas{
            var column: Int?
            var row: Int?
            
            let startTime = bookedData.startTime
            let endTime = bookedData.endTime
            for i in 0..<7{
                if Calendar.current.isDate(startTime, inSameDayAs: dayList[i]){
                    column = i
                }
            }
            
            let calendar = Calendar.current
            let diff:DateComponents = calendar.dateComponents([.minute], from: startTime, to: endTime)
            let continuousCount = diff.minute!/30
            
            
            
            for index in 0..<continuousCount{
                dateComponet.minute = index*30
                dateComponet.day = 0
                
                let bookedTimeText = dateFormatter.string(from: Calendar.current.date(byAdding: dateComponet, to: startTime)!)
                
                for tupleData in tupleForBooked{
                    if tupleData.0 == column && tupleData.2 == bookedTimeText{
                        row = tupleData.1
                    }
                }
                
                for sv in vContainerView.subviews{
                    if sv.tag == 100*column! + row!{
                        if let timeLabel = sv as? UILabel{
                            timeLabel.textColor = .lightGray
                        }
                        
                        if let timeCell = sv as? UIView{
                            timeCell.backgroundColor = .white
                            let grayView = UIView()
                            grayView.backgroundColor = .gray
                            grayView.layer.cornerRadius = 3
                            vContainerView.addSubview(grayView)
                            grayView.snp.makeConstraints { make in
                                make.top.left.equalTo(timeCell).offset(-1)
                                make.bottom.right.equalTo(timeCell).offset(1)
                            }
                            vContainerView.sendSubviewToBack(grayView)
                        }
                    }
                }
            }
        }
    }
    
}

