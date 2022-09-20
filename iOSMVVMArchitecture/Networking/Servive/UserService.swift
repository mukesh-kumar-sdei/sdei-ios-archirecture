//
//  LoginAPIManager.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 14/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation
import UIKit

let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImY3NGRiMDIxYTg0ZTE2MTNmN2U1NTk1ZTE4Y2E4ODg2YjVmMzIyZTE2Y2E2MGNjZmFhOWM1OGI3NTliODcyOTQ4NjJkZGJhODdiZWEwZDVhIn0.eyJhdWQiOiIyIiwianRpIjoiZjc0ZGIwMjFhODRlMTYxM2Y3ZTU1OTVlMThjYTg4ODZiNWYzMjJlMTZjYTYwY2NmYWE5YzU4Yjc1OWI4NzI5NDg2MmRkYmE4N2JlYTBkNWEiLCJpYXQiOjE1OTg2OTc0MDIsIm5iZiI6MTU5ODY5NzQwMiwiZXhwIjoxNjMwMjMzNDAyLCJzdWIiOiI4Iiwic2NvcGVzIjpbIioiXX0.lGVlaPAKKJ9hp0Ox29i-hFYal2_W_Bd17l8mP7oSSdhLzjZx8yRr03oqj4fVYbKoaoNR0wd9BkdB9RTWuw8ITohOLekFoPGBaKpjSnhu4TnKaXRBljTaddQGmQKhuAuP418OAWh-PIi8hAACJG0BClOpB_Q8F8fLOtlHbIhlerPDKozDNAoxNjKC05-d5_0tLglMaxh34a5ob7662qfLfdmr3bCujCxk4XJ3xbYttbLxXt2F8I-wAYfsYPrFraa9hd-EdaAqyjjcyRWBcAE2J09MGiXXjPU1GpBpydWCupnsip2UAG3ry-klctHOFKhy2kpU7genGEP2Mk__CJK2ZKzBPnutuzY7NOlsKVkYcLNRI_LtvRJcUcVQTINbwZzD8AK2A-1jTKfaGcSjo1E48bA04cb7iIwokk3mha9v5LwqCMQMS7O7AMUT92o4M3B0ox_kICR_zHgqlrbNrngxzzAkR_hvDD-ewu2_Hv5DFaGQgJJhK9OnI8Zp9LsYEfcejCBTLbdGZctmClgcLvG7GCCKnPN3RlRy7ualYsbXoID0me_tIXeDs6DJynGCaq43idExZiNo52CIcCijnw9QtkuHAeKFPHhSae0I0vxpjfHGVXY3krFR6UPBMNqdr1Q06EXXE7a_ZLaABMifEIniJ9XIwuN2oE02Xslfl3FD-5c"

public class UserService {
    
    // Fetch employee list
    func doLogin(with params:Parameters,
                 completion:@escaping (Result<User>) -> Void) {
        
        Router.data(Endpoints.user("login"), method: .post, parameters: params, encoder: JSONEncoding.default)
            .responseDecodable(decodingType: User.self) { (result) in
                switch result {
                case .Success(let user):
                    debugPrint("response = \(user)")
                    completion(.Success(user))
                case .Error(let error):
                    debugPrint("error = \(error.localizedDescription)")
                    completion(.Error(error))
                }
        }
    }

    // Upload file to server
    func uploadFile(_ image:UIImage, _ completion:@escaping (String?) -> Void) {

        Router.upload(Endpoints.user("avatar"),
                      filename: "avatar",
                      name: "avatar",
                      data: image.pngData(),
                      parameters: nil)
        .authenticate(token)
            .response { (result) in
                switch result {
                case .Success(let response):
                    if let dict = response as? Parameters,
                        let message = dict["message"] as? String {
                        print(message)
                        completion(message)
                    }
                case .Error(let error):
                    debugPrint("error = \(error.localizedDescription)")
                    completion(nil)
                }
        }
    }
}

