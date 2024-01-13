//
//  Created by Andrew Kuts on 2022-12-02.
//

public enum HTTPSResponseType: Equatable {

	case info(code: Int)
	case success(code: Int)
	case redirect(code: Int)
	case clientError(code: Int)
	case serverError(code: Int)
	case untrustedCertificate(code: Int)
	case timeOut(code: Int)
	case unowned(code: Int)

	public init(rawValue: Int) {

		switch rawValue {

		case 100..<200:
			self = .info(code: rawValue)

		case 200..<300:
			self = .success(code: rawValue)

		case 300..<400:
			self = .redirect(code: rawValue)

		case 400..<500:
			self = .clientError(code: rawValue)

		case 500..<600:
			self = .serverError(code: rawValue)

		case -999:
			self = .untrustedCertificate(code: rawValue)

		case -1001:
			self = .timeOut(code: rawValue)

		default:
			self = .unowned(code: rawValue)
		}
	}
}
