//
//  ViewController.swift
//  baguette
//
//  Created by blue park on 2022/12/05.
//

import UIKit

class MainViewController: BaseViewController {
    
    private var selectedDateIdx = 1
    
    private let dateStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = UIColor(named: "Color000000")
        return label
        }()
    
    private let calenderButton: UIButton = {
       let btn = UIButton()
        let image = UIImage(named: "calender")!
        btn.setImage(image, for: UIControl.State.normal)
        return btn
    }()
    
    private let todoButton: UIButton = {
       let btn = UIButton()
        let image = UIImage(named: "todo")!
        btn.setImage(image, for: UIControl.State.normal)
        return btn
    }()
    
    var days: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    
        self.initView()
        self.initDate(date: Date())
    }
    
    func initDate(date: Date) {
        
        days.removeAll()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en") // 한국 지정
        
        let yesterday = date.addingTimeInterval(3600 * 24 * -1)
        dateFormatter.dateFormat = "dd eeee"
        let yesterdayDay = dateFormatter.string(from: yesterday)
        let dDay = dateFormatter.string(from: date)
        
        self.days.append(String(yesterdayDay))
        self.days.append(String(dDay))
        
        for i in 1...5 {
            let plusday = date.addingTimeInterval(TimeInterval(3600 * 24 * i))
            let plusdayDay = dateFormatter.string(from: plusday)
            self.days.append(String(plusdayDay))
        }
        
        for (index, day) in days.enumerated() {
            let list = day.components(separatedBy: " ")
            let mainCalenderView = MainCalenderView()
            
            
            mainCalenderView.date = list.first
            if let day = list.last {
                mainCalenderView.day = String(day.prefix(3))
            }
            
            mainCalenderView.setSelectDay(index == selectedDateIdx)
            
            dateStackView.addArrangedSubview(mainCalenderView)
            
            mainCalenderView.topAnchor.constraint(equalTo: dateStackView.topAnchor).isActive = true
            mainCalenderView.bottomAnchor.constraint(equalTo: dateStackView.bottomAnchor).isActive = true
            
            mainCalenderView.loadView()
            
            mainCalenderView
            
            print(day)
        }
    }
    
    func initView() {
    
        view.addSubview(dateStackView)
        view.addSubview(dateLabel)
        view.addSubview(calenderButton)
        view.addSubview(todoButton)
        
        dateLabel.text = getThisMonth()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        dateStackView.topAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: 32).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        todoButton.translatesAutoresizingMaskIntoConstraints = false
        todoButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        todoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        calenderButton.translatesAutoresizingMaskIntoConstraints = false
        calenderButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        calenderButton.trailingAnchor.constraint(equalTo: self.todoButton.leadingAnchor, constant: 20).isActive = true
    
    }
    
    func getThisMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월, yyyy"
        let date = dateFormatter.string(from: Date())
        print(date)
        return date
    }
    
}

class MainCalenderView: UIView {
    
    var date: String?
    var day: String?
    var isSelectDay: Bool = false
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        return progressView
        }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Color000000")
        return label
        }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .systemFont(ofSize: 9)
        label.textColor = UIColor(named: "Color999999")
        return label
        }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
    func setSelectDay(_ isSelectDay: Bool) {
        progressView.isHidden = !isSelectDay
    }
    
         func loadView() {
            
            addSubview(progressView)
            progressView.isHidden = true
            
            if isSelectDay {
                progressView.isHidden = false
            }
            
            if let date = date {
                dateLabel.text = date
                addSubview(dateLabel)
            }
            
            if let day = day {
                dayLabel.text = day
                addSubview(dayLabel)
            }

            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.widthAnchor.constraint(equalToConstant: 48).isActive = true
            progressView.heightAnchor.constraint(equalToConstant: 48).isActive = true
            progressView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
            dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            dateLabel.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 6).isActive = true
            dateLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 6).isActive = true
            dateLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 6).isActive = true
            
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6).isActive = true
            dayLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 6).isActive = true
            dayLabel.trailingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 6).isActive = true
        
        }
}


