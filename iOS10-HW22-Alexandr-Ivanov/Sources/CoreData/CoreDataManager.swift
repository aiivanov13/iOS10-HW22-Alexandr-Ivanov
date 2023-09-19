import UIKit
import CoreData

final class CoreDataManager {
    private let fetchRequest: NSFetchRequest<User> = {
        NSFetchRequest<User>(entityName: "User")
    }()

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        appDelegate.coreDataStack.context
    }
}

// MARK: - CoreDataManagerInput

extension CoreDataManager: CoreDataManagerInput {
    func createUser(imageData: Data?, name: String, birthDate: String?, gender: String?) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }
        let entity = User(entity: entityDescription, insertInto: context)
        entity.imageData = imageData
        entity.name = name
        entity.birthDate = birthDate
        entity.gender = gender
        
        appDelegate.coreDataStack.saveContext()
    }

    func fetchUsers(completion: @escaping ([User]) -> Void) {
        do {
            completion(try context.fetch(fetchRequest))
        } catch let error as NSError {
            print("Ошибка при загрузке данных: \(error), \(error.userInfo)")
        }
    }

    func deleteUser(_ user: User) {
        context.delete(user)
        appDelegate.coreDataStack.saveContext()
    }
}

// MARK: - CoreDataManagerUpdate

extension CoreDataManager: CoreDataManagerUpdate {
    func updateUser(_ user: User,
                    newImageData: Data?,
                    newName: String,
                    newBirthDate: String,
                    newGender: String?) {
        user.imageData = newImageData
        user.name = newName
        user.birthDate = newBirthDate
        user.gender = newGender
        appDelegate.coreDataStack.saveContext()
    }
}
