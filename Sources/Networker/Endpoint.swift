//
//  Created by Andrew Kuts on 2024-01-13.
//

import Foundation

public indirect enum Endpoint {

	case root(url: URL)
	case path(endpoint: Endpoint, path: String)

	public var url: URL {
		switch self {
		case .root(let url):
			return url
		case .path(let endpoint, let path):
			return endpoint.url.appendingPathComponent(path)
		}
	}
}
