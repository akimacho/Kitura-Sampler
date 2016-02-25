import KituraSys
import SwiftRedis
import Foundation

let redis = Redis()

// connection
redis.connect("127.0.0.1", port: 6379) { _ in 
    if redis.connected {
        print("connection success")
    } else {
        print("connection failed")
        redis.ping() { (error: NSError?) in 
            if let e = error {
                print(e.localizedDescription)
                exit(EXIT_FAILURE)
            }
        }
    }
}
/* set & get String */
redis.set("apple", value: "48") { (wasSet: Bool, error: NSError?) in
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if (!wasSet) {
        print("not set")
    }
}
redis.get("apple") { (result: RedisString?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let r = result {
        print(r.asInteger) // asData, asString, asInteger, asDouble
    } else {
        print("Not Found")
    }
}
redis.incr("apple") { (result: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let r = result {
        print(r) // value of the result
    }
}
redis.del("apple") { (length: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let l = length {
        print(l) // number of keys
    }
}
redis.mset(("apple", "swift")) { (wasSet: Bool, error: NSError?) in
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if (!wasSet) {
        print("not set")
    }
}
redis.msetArrayOfKeyValues([("apple", "Swift"), ("Google", "Golang"), ("MS", "C#")]) { (wasSet: Bool, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}
redis.mget("apple", "Google", "MS") { (results: [RedisString?]?, error: NSError?) in
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let rs = results {
        for item in rs {
            print(item!.asString)
        }
    }
}
redis.append("apple", value: "Objective-C") { (length: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let l = length {
        print(l) // length of the set string
    }
}
redis.exists("apple") { (isExist: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let ie = isExist {
        // exist : 1, not exist : 0
        print(ie)
    }
}
let interval: NSTimeInterval = 60.0 * 60.0 * 24 // one day
redis.expire("apple", inTime: interval) { (wasSet: Bool, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}
/* set & get Hash */
redis.hmset("IBM", fieldValuePairs: ("Swift", "Kitura")) { (wasSet: Bool, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}
redis.hmget("IBM", fields: "Swift") { (results: [RedisString?]?, error: NSError?) in
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let rs = results {
        for item in rs {
            print(item!.asString)
        }
    }
}
redis.hdel("IBM", fields: "Swift") { (number: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}
let pairs = [("Swift", "Kitura"), ("Node", "Node-RED"), ]
redis.hmsetArrayOfKeyValues("IBM", fieldValuePairs: pairs) { (wasSet: Bool, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}
redis.hmget("IBM", fields: "Swift", "Node") { (results: [RedisString?]?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let rs = results {
        for item in rs {
            print(item!.asString)
        }
    }
}
redis.hgetall("IBM") { (result: [String: RedisString], error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    for key in result.keys {
        print(result[key]!.asString)
    }
}
redis.hlen("IBM") { (length: Int?, error: NSError?) in
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
    if let l = length {
        print(l)
    }
}
redis.hdel("IBM", fields: "Swift", "Node") { (number: Int?, error: NSError?) in 
    if let e = error {
        print(e.localizedDescription)
        exit(EXIT_FAILURE)
    }
}