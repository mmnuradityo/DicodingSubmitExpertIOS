//
//  DateUtils.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

func generateDate(dateString: String) -> Date? {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  dateFormatter.timeZone = TimeZone.current
  dateFormatter.locale = Locale.current
  return dateFormatter.date(from: dateString) ?? nil
}

func getDateStringFull(date: Date?) -> String {
  guard let date = date else { return "" }
  
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  dateFormatter.timeZone = TimeZone.current
  dateFormatter.locale = Locale.current
  
  return dateFormatter.string(from: date)
}

func getDateString(date: Date?) -> String {
  guard let date = date else { return "" }
  
  let dateFormatter = DateFormatter()
  dateFormatter.timeStyle = DateFormatter.Style.none
  dateFormatter.dateStyle = DateFormatter.Style.medium
  
  return dateFormatter.string(from: date)
}
