//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public enum HTTPSMethod: String {

	case get
	case post
	case put
	case patch
	case delete

	var name: String {
		switch self {
		case .get:
			return "GET"
		case .post:
			return "POST"
		case .put:
			return "PUT"
		case .patch:
			return "PATCH"
		case .delete:
			return "DELETE"
		}
	}
}
