//
//  User + CustomStringConvertible.swift
//  HaHdevSchool
//
//  Created by Admin on 14.02.2023.
//

import Foundation

extension User: CustomStringConvertible {
    var description: String {
        return
"""

ID: \(id)
Name: \(name)
Username: \(username)
Email: \(email)
Address:
\(address)
Phone: \(phone)
Website: \(website)
Company:
\(company)

"""
    }
}

extension ResponseAddress: CustomStringConvertible {
    var description: String {
        return
"""
  Street: \(street)
  Suite: \(suite)
  City: \(city)
  Zipcode \(zipcode)
  Geo:
    lat: \(geo.lat)
    lng: \(geo.lng)
"""
    }
}

extension ResponseCompany: CustomStringConvertible {
    
    var description: String {
        return
"""
  CompanyName: \(name)
  CatchPhrase: \(catchPhrase)
  BS: \(bs)
"""
    }
}
