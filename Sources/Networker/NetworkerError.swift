//
//  Created by Andrew Kuts on 2022-12-02.
//

import Foundation

public enum NetworkerError: Error {
	case noData(Error?)
	case noResponse(Error?)
	case baseError(Error?)
	case statusCodeError(Int, Data?)
}
