////
////  CoreDataManager.swift
////  FinalProject
////
////  Created by Ерасыл Еркин on 20.12.2023.
////
//
//import UIKit
//import CoreData
//
//public final class CoreDataManager: NSObject {
//    public static let shared = CoreDataManager()
//    private override init() {}
//    
//    private var appDelegate: AppDelegate {
//        UIApplication.shared.delegate as! AppDelegate
//    }
//    
//    private var context: NSManagedObjectContext {
//        appDelegate.persistentContainer.viewContext
//    }
//    
//    public func logCoreDataDBPath() {
//        if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
//            print("DB url - \(url)")
//        }
//    }
//    
//    public func createPhoto(_ id: Int16, title: String) {
//        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: context) else {
//            return
//        }
//        let entity = Entity(entity: photoEntityDescription, insertInto: context)
//        entity.id = id
//        entity.title = title
//        
//        appDelegate.saveContext()
////
//    
//    public func fetchEntity() -> [Entity] {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
//        do {
//            return (try? context.fetch(fetchRequest) as? [Entity]) ?? []
//        }
//    }
//    
//    public func fetchEntities(with id: Int16) -> Entity? {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
//        do {
//            let entity = try? context.fetch(fetchRequest) as? [Entity]
//            return entity?.first(where: { $0.id == id})
//        }
//    }
//    
//    public func updataPhoto(with id: Int16, title: String? = nil) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
//        do {
//            guard let entities = try? context.fetch(fetchRequest) as? [Entity], let entity = entities.first(where: {$0.id == id}) else {return}
//            entity.title = title!
//        }
//        
//        appDelegate.saveContext()
//    }
//}
//                                                                                                            
