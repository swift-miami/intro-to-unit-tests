//
//  APIManager.swift
//  EmailListV5
//
//  Created by Nilson Nascimento on 4/4/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class APIManager {
    func loadEmails(completion: @escaping ([Email]?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            let emails = [
                Email(subject: "Breaking News!", isRead: false),
                Email(subject: "Facebook done did it again!", isRead: false)
            ]
            completion(emails, nil)
        }
    }
}
