
import UIKit
import RealmSwift

class BasketModel: Object {
   
    @objc dynamic var id = 0
    @objc dynamic var count = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id  : Int, _ productId : Int, _ count : Int) {
        self.init()
        self.id = id
        self.count = count
    }
}

extension BasketModel {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: .modified)
        }
    }
    func deleteFromRealm() {
        try! uiRealm.write {
            uiRealm.delete(self)
        }
    }
    func deleteAllFromBasket() {
        try! uiRealm.write {
            uiRealm.deleteAll()
        }
    }
}
