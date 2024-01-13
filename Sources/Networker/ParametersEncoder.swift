//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public protocol ParametersEncoder {
	var headers: Headers? { get }
	func encode<T: Requestable>(_ requestable: T) -> URLRequest
}

struct DefaultParametersEncoder: ParametersEncoder {

	static let shared = DefaultParametersEncoder()

	let headers: Headers? = [:]

	private init() { }

	func encode<T: Requestable>(_ requestable: T) -> URLRequest {
		let url = requestable.endpoint.url
		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
		request.httpBody = requestable.body
		return request
	}
}
