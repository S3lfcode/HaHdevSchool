//
//  ResponceBody.swift
//  HaHdevSchool
//
//  Created by Admin on 07.02.2023.
//

import Foundation

struct ResponceBody<ApiData: Codable>: Codable {
    let data: ApiData?
    let error: ApiErrorData?
}
