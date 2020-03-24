//
//  ViewController.swift
//  WeekdayFinder
//
//  Created by Мария Матичина on 3/11/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // везде var т.к. это Optional значения
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeekDay() { // срабатывает при нажатии на кнопку
        
        let calendar = Calendar.current // определили календарь
        
        var dateComponents = DateComponents() // из каких компонентов состоит дата (день, месяц, год)
        guard let day = dateTF.text, let month = monthTF.text, let year = yearTF.text else { return }
        dateComponents.day = Int(day)
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        
        /*
         ошибка т.к. day - это Int
         извлечем значение - Int(dateTF.text!)
         3 компонента хранятся в var dateComponents
         */
        
        
        guard let date = calendar.date(from: dateComponents) else { return } //  можем создать дату исходя из наших 3х компонентов
        if dateComponents.day! > 31 { // проверка на то, что день не должен быть > 31
            resultLabel.text = "Error"
            print(resultLabel.text!)
            return
        }
        
        if dateComponents.month! > 12 {
            resultLabel.text = "Error"
            print(resultLabel.text)
            return
        }
        
        
        let dateFormatter = DateFormatter() //  хотим, чтобы дата отображала только ДЕНЬ НЕДЕЛИ
        dateFormatter.locale = Locale(identifier: "ru_Ru") // день недели по русски
        dateFormatter.dateFormat = "EEEE" // (Рисунок 60) в Word.doc
        
        let weekday = dateFormatter.string(from: date) // получаем (день недели) строку при помощи dateFormatter из нашей date
        let capitalizedWeekDay = weekday.capitalized // чтобы день недели по-русски не был с маленькой буквы
        
        resultLabel.text = capitalizedWeekDay
        
        /*
         dateComponents.day = Int(dateTF.text!)
         dateComponents.month = Int(monthTF.text!)
         dateComponents.year = Int(yearTF.text!)
         
         так принудительно извлекать нельзя
         ! - код мб не безопасный, потому что принудительное извлечение - это некая гарантия, что там находится какой-то текст, но не всегда бывает так
         
         Решение
         1) if let day = dateTF.text, let month = monthTF.text, let year = yearTF.text{} - оборачиваем
         или
         2) guard let day = dateTF.text, let month = monthTF.text, let year = yearTF.text else {rerurn} - если где-то не находится текст, то выходим из метода
         
         dateComponents.day = Int(day)
         dateComponents.month = Int(month)
         dateComponents.year = Int(year)
         */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // когда касаемся экрана клавиатура должна уйти
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Here you wil see\n the day of the week"
    }
}



