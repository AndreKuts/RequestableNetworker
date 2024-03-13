//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public typealias Headers = [String : String]
public typealias Parameters = [String : Any]

public protocol Requestable {

	var method: HTTPSMethod { get }
	var headers: Headers? { get }
	var body: Data? { get }
	var endpoint: Endpoint { get }
	var parameters: Parameters { get }
	var encoder: ParametersEncoder { get }
	var urlRequest: URLRequest { get }
}

public extension Requestable {

	var method: HTTPSMethod { .get }

	var headers: Headers? { nil }

	var body: Data? { nil }

	var parameters: Parameters { [:] }

	var encoder: ParametersEncoder {
		DefaultParametersEncoder.shared
	}

	var urlRequest: URLRequest {
		var request = encoder.encode(self)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = makeHeaders()
		return request
	}

	private func makeHeaders() -> [String: String] {
		var headers = self.headers ?? [:]

		for header in encoder.headers ?? [:] {
			headers[header.key] = header.value
		}

		return headers
	}
}
