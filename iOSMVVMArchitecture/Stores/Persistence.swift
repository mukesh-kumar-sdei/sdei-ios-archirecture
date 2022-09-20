

import Foundation

class Persistence {
   
    private static let clientCacheKey   = "ios-cached-client"
    private static let userCacheKey     = "ios-cached-user"
    private static let rememberCacheKey = "ios-cached-remember-user"
    private static let pushCacheKey     = "ios-cached-push-token"

    // MARK: - Codable Property List Persistence Wrapper

   private static func cache<T>(_ toCache: T?, forKey: String) where T: Encodable {
        guard let toCache = toCache else {
            return UserDefaults.standard.set(nil, forKey: forKey)
        }

        let encoder = PropertyListEncoder()
        let encoded = try! encoder.encode(toCache)

        UserDefaults.standard.set(encoded, forKey: forKey)
    }

    private static func cached<T>(forKey: String) -> T? where T: Decodable {
        let decoder = PropertyListDecoder()

        guard let encoded = UserDefaults.standard.data(forKey: forKey) else {
            return nil
        }

        let decoded = try? decoder.decode(T.self, from: encoded)

        return decoded
    }

    // MARK: - Signed In User Persistence

    static func cacheUser(_ user: User?) {
        cache(user, forKey: userCacheKey)
    }

    static func cachedUser() -> User? {
        return cached(forKey: userCacheKey)
    }
    
    // MARK: - Remember User Persistence
    static func storeRememberUser(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: rememberCacheKey)
    }

    static func rememberUser() -> Bool {
        return UserDefaults.standard.bool(forKey: rememberCacheKey)
    }
    
    // MARK: - Push Notifications Token Persistence
    static func storePushToken(_ value: String?) {
        UserDefaults.standard.set(value, forKey: pushCacheKey)
    }

    static func pushToken() -> String? {
        return UserDefaults.standard.string(forKey: pushCacheKey)
    }
}

class SecurePersistence {
    static var keychainPrefix: String {
        let bundleDictionary = Bundle.main.infoDictionary!
        let appName = bundleDictionary[kCFBundleIdentifierKey as String] as! String

        return appName
    }

    static var accessTokenKeychainKey: String {
        return "\(keychainPrefix).oauth-token"
    }

    static var refreshTokenKeychainKey: String {
        return "\(keychainPrefix).refresh-token"
    }
    
    static var pushKeychainKey: String {
        return "\(keychainPrefix).push-token"
    }
    
    static var voipKeychainKey: String {
        return "\(keychainPrefix).voip-token"
    }
    
    static func clear() {
        storeAccessToken(nil)
        storeRefreshToken(nil)
    }

    // MARK: - Access Token Persistence (NOT CURRENTLY SECURE)
    static func storeAccessToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: accessTokenKeychainKey)
    }

    static func accessToken() -> String? {
        return UserDefaults.standard.string(forKey: accessTokenKeychainKey)
    }

    // MARK: - Refresh Token Persistence (NOT CURRENTLY SECURE)
    static func storeRefreshToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: refreshTokenKeychainKey)
    }

    static func refreshToken() -> String? {
        return UserDefaults.standard.string(forKey: refreshTokenKeychainKey)
    }
    
}
