//
//  Task4.swift
//  HaHdevSchool
//
//  Created by Admin on 11.02.2023.
//

import Foundation

enum DataKeys: String {
    case jsonData
}

func task4() {
    print("~ Задание 4:")
    let storage = Assembly().dataStorage
    let assembly = Assembly()
    
//ApiClient with change to generic method + result<S,F> + errors------->
    let jsonDataKey = DataKeys.jsonData.rawValue
    lazy var apiClientV2 = assembly.apiClientV2
        //Создаём ссылку (делаю тут, т.к. для метода profile будет больше универсальности)
    guard let currentUrl = Bundle.main.url(forResource: "Profile", withExtension: "json") else {
        return
    }
        //Передаём все необходимые параметры для загрузки и вывода
    apiClientV2.profile(
        url: currentUrl,
        expecting: ResponceBody<ProfileResponceData>.self) { result in
            switch result {
            case .success(let responseBody):
                print("\n ---> \"ApiClientV2\" Результат загрузки из \"JSON\" файла: \n\(responseBody)")
                //Сохраняем полученный результат в dataStorage
                storage.save(value: responseBody, key: jsonDataKey)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        //Проверяем, что всё сохранилось
    if let data = storage.value(key: jsonDataKey) as ResponceBody<ProfileResponceData>? {
        print("\n ---> Результат загрузки из \"dataStorage\": \n\(data)")
    } else {
        print("Это был первый вход, \"data\" ещё не сохранена в \"dataStore\"")
    }
    
//ApiClient with URLSession------->
    lazy var apiClientV3 = assembly.apiclientV3
    apiClientV3.profile(url: currentUrl, expecting: ResponceBody<ProfileResponceData>.self) { result in
        switch result {
        case .success(let data):
            print("\n ---> \"ApiClientV3\" Результат загрузки из \"JSON\" файла: \n\(data)")
        case .failure(let error):
            print("Error: \(error)")
        }
    }
//Load data with URLSession extension ------->
    URLSession.shared.profile(url: currentUrl, expecting: ResponceBody<ProfileResponceData>.self) { result in
        switch result {
        case .success(let data):
            print("\n ---> \"extensionURLSession\" Результат загрузки из \"JSON\" файла: \n\(data)")
        case .failure(let error):
            print("Error: \(error)")
        }
    }
//Test API request data from a URL on the internet (with the help ApiClientV3)
    let internetUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
    apiClientV3.profile(url: internetUrl, expecting: [User].self) { result in
        switch(result) {
        case .success(let users):
            print("\n ---> Test API request form URL (ApiClientV3)\n\(users)")
        case .failure(let error):
            print(error)
        }
    }
}
