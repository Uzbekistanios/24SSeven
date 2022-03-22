
import Foundation
import RealmSwift
import Realm

class RealmWrapper {
    static var realm: Realm {
        get {
            do {
                return try Realm()
            } catch {
                print(error)
            }
            return self.realm
        }
    }
    
    func saveObjects(objs: Object) {
        do {
            try RealmWrapper.realm.write {
                RealmWrapper.realm.add(objs)
            }
        } catch {
            debugPrint("Could not write to dataBase: ", error)
        }
    }
    
    func getObjects(objs: Object.Type) -> Results <Object>? {
        return RealmWrapper.realm.objects(objs)
    }
    
    func updateObjects(objs: Object) {
        do {
            try RealmWrapper.realm.write {
                RealmWrapper.realm.add(objs, update: .all)
            }
        } catch {
            debugPrint("Could not update database: ", error)
        }
    }
    
    func deleteObjects(objs: Object) {
        do {
            try RealmWrapper.realm.write {
                RealmWrapper.realm.delete(objs)
            }
        } catch {
            debugPrint("Could not delete from database: ", error)
        }
    }
    
    func incrementIdBasket() -> Int {
        return (RealmWrapper.realm.objects(BasketModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
