//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public protocol NetworkerDependency {

	/// Validate response status code than try to pars data into expected type
	func validateAndDecode<T: Decodable>(response: URLResponse, withData data: Data) throws -> T

}

public struct DefaultNetworkerDependency: NetworkerDependency {

	private let decoder: JSONDecoder

	public init(decoder: JSONDecoder = JSONDecoder()) {
		self.decoder = decoder
	}

	public func validateAndDecode<T: Decodable>(response: URLResponse, withData data: Data) throws -> T {

		let statusCode = response.statusCode ?? -1
		let responseGroup = HTTPSResponseType(rawValue: statusCode)

		guard responseGroup != .success(code: statusCode) else {
			throw NetworkerError.statusCodeError(statusCode, data)
		}

		return try decoder.decode(T.self, from: data)
	}
}

extension URLResponse {
	var statusCode: Int? { (self as? HTTPURLResponse)?.statusCode }
}
