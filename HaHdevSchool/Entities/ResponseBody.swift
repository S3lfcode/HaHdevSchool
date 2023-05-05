import Foundation

struct ResponseBody<ApiData: Codable>: Codable {
    let data: ApiData?
    let error: ApiErrorData?
}
