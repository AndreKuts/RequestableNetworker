//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation
import Combine

public protocol NetworkerDependency {
	func validate<T: Decodable>(response: URLResponse, andData data: Data, completion: @escaping (Result<T, Error>) -> Void)
	func tryMap(response: URLResponse, and data: Data) throws -> Data
}

public struct DefaultNetworkerDependency: NetworkerDependency {

	private let decoder: JSONDecoder

	public init(decoder: JSONDecoder = JSONDecoder()) {
		self.decoder = decoder
	}

	public func validate<T>(response: URLResponse, andData data: Data, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
		let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
		let responseGroup = HTTPSResponseType(rawValue: statusCode)

		if responseGroup == .success {
			decode(type: T.self, data: data, completion: completion)
		} else {
			completion(.failure(NetworkerError.statusCodeError(statusCode)))
		}
	}

	public func tryMap(response: URLResponse, and data: Data) throws -> Data {
		let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
		let responseGroup = HTTPSResponseType(rawValue: statusCode)
		if responseGroup == .success {
			return data
		} else {
			throw NetworkerError.statusCodeError(statusCode)
		}
	}

	private func decode<T: Decodable>(type: T.Type, data: Data, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let result = try decoder.decode(T.self, from: data)
			completion(.success(result))
		} catch {
			completion(.failure(error))
		}
	}
}
