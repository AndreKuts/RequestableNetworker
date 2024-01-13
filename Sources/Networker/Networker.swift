//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation
import Combine

public protocol NetworkerProtocol {

	init(session: URLSession, dependency: NetworkerDependency)

	func getPublisher<T: Decodable>(type: T.Type, requestable: Requestable) -> AnyPublisher<T, Error>
	func getAsync<T: Decodable>(type: T.Type, requestable: Requestable) async throws -> T
}

public struct Networker: NetworkerProtocol {

	let session: URLSession
	let dependency: NetworkerDependency

	public init(session: URLSession = .shared, dependency: NetworkerDependency = DefaultNetworkerDependency()) {
		self.session = session
		self.dependency = dependency
	}

	public init(dependency: NetworkerDependency = DefaultNetworkerDependency(), isCertificateValid: @escaping (SecTrust) -> Bool) {
		self.dependency = dependency
		self.session = URLSession(configuration: .default, delegate: SSLDelegate(isCertificateValid: isCertificateValid), delegateQueue: nil)
	}

	public func getPublisher<T: Decodable>(type: T.Type, requestable: Requestable) -> AnyPublisher<T, Error> {
		self.session.dataTaskPublisher(for: requestable.urlRequest)
			.tryMap { try dependency.validateAndDecode(response: $0.response, withData: $0.data) }
			.eraseToAnyPublisher()
	}

	public func getAsync<T: Decodable>(type: T.Type, requestable: Requestable) async throws -> T {
		let (data, response) = try await session.data(for: requestable.urlRequest)
		return try dependency.validateAndDecode(response: response, withData: data)
	}
}
