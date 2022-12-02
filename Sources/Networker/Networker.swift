//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation
import Combine

public struct Networker:  NetworkerProtocol {

	let session: URLSession
	let dependency: NetworkerDependency

	public init(session: URLSession = .shared, dependency: NetworkerDependency) {
		self.session = session
		self.dependency = dependency
	}

	public func dataTask<T>(requestable: Requestable, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {

		self.session.dataTask(with: requestable.urlRequest) { data, response, error in
			guard error != nil else {
				completion(.failure(error!))
				return
			}

			guard let data = data else {
				completion(.failure(NetworkerError.noData(error)))
				return
			}

			guard let response = response else {
				completion(.failure(NetworkerError.noResponse(error)))
				return
			}

			dependency.validate(response: response, andData: data, completion: completion)
		}
	}

	public func getPublisher<T>(type: T.Type, requestable: Requestable) -> AnyPublisher<T, Error> where T : Decodable {
		self.session.dataTaskPublisher(for: requestable.urlRequest)
			.tryMap { try dependency.tryMap(response: $0.response, and: $0.data) }
			.decode(type: T.self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}

	public enum NetworkerError: Error {
		case noData(Error?)
		case noResponse(Error?)
		case baseError(Error?)
	}
}
