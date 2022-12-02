//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation
import Combine

public protocol NetworkerProtocol {

	init(session: URLSession, dependency: NetworkerDependency)

	func dataTask<T: Decodable>(requestable: Requestable, completion: @escaping (Result<T, Error>) -> Void)
	func getPublisher<T: Decodable>(type: T.Type, requestable: Requestable) -> AnyPublisher<T, Error>

}

public protocol NetworkerDependency {
	func validate<T: Decodable>(response: URLResponse, andData data: Data, completion: @escaping (Result<T, Error>) -> Void)
	func tryMap(response: URLResponse, and data: Data) throws -> Data
}
