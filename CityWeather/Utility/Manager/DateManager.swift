//
//  DateManager.swift
//  CityWeather
//
//  Created by Greed on 6/25/24.
//

import Foundation

final class DateManager {
    
    static let shared = DateManager()
    
    private init() { }
    
    private var locale = Locale(identifier: "ko_KR")
    private var timezone = TimeZone(identifier: "Asia/Seoul") ?? .current {
        didSet {
            dateFormatter.timeZone = timezone
            calendar.timeZone = timezone
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.timeZone = timezone
        return formatter
    }()
    
    private lazy var utcDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    private lazy var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.timeZone = timezone
        return calendar
    }()
    
    func setTimeZone(secondsFromGMT: Int) {
        self.timezone = TimeZone(secondsFromGMT: secondsFromGMT) ?? .current
    }
    
    func convertToDate(from string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        utcDateFormatter.dateFormat = format
        return utcDateFormatter.date(from: string)
    }
    
    func toString(string: String, returnFormat: CWDateFormat, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        guard let date = convertToDate(from: string, format: format) else { return "" }
        dateFormatter.dateFormat = returnFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    func isToday(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        guard let date = convertToDate(from: string, format: format) else { return false }
        let todayStart = calendar.startOfDay(for: Date())
        let todayEnd = calendar.date(byAdding: .day, value: 1, to: todayStart) ?? Date()
        return todayStart <= date && date < todayEnd
    }
    
    func isTomorrow(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        guard let date = convertToDate(from: string, format: format) else { return false }
        let now = Date()
        let tomorrowStart = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now)) ?? now
        let twoDaysLaterStart = calendar.date(byAdding: .day, value: 2, to: calendar.startOfDay(for: now)) ?? now
        return tomorrowStart <= date && date < twoDaysLaterStart
    }
    
    func dateString(from dateString: String, fromFormat: String = "yyyy-MM-dd HH:mm:ss", toFormat: String = "yyyy-MM-dd") -> String {
        utcDateFormatter.dateFormat = fromFormat
        guard let date = utcDateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
    
    func startOfDay(for date: Date) -> Date {
        return calendar.startOfDay(for: date)
    }
}

extension DateManager {
    
    enum CWDateFormat: String {
        case day = "EEE"
        case ampmHour = "a h시"
    }
}
