//Created by Halbus Development

import Foundation

private enum BuildConfiguration {
    enum Error: Swift.Error {
        case missingkey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
        throw Error.missingkey
    }
    
    switch object {
    case let string as String:
        guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
static var baseURL: String {
    do {
        return try BuildConfiguration.value(for: "BASE_URL" )
        
    } catch {
        fatalError(error.localizedDescription)
    }
}
}
