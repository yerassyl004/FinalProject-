//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveHistoryToFile()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveHistoryToFile()
    }

    func saveHistoryToFile() {
        let fileManager = FileManager.default

        if let userIdentifier = Auth.auth().currentUser?.uid,
           let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let userDirectory = documentDirectory.appendingPathComponent(userIdentifier)

            do {
                try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating user directory: \(error)")
                return
            }

            let fileURL = userDirectory.appendingPathComponent("historyData.json")

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(History.shared.history)
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error saving history data: \(error)")
            }
        }
    }

    func loadHistoryFromFile() {
        let fileManager = FileManager.default

        if let userIdentifier = Auth.auth().currentUser?.uid,
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let userDirectory = documentDirectory.appendingPathComponent(userIdentifier)
            let fileURL = userDirectory.appendingPathComponent("historyData.json")

            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let historyArray = try decoder.decode([Article].self, from: data)

                History.shared.updateHistory(with: historyArray)
                print("Successfully loaded history data")
            } catch {
                print("Error loading history data: \(error)")
            }
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "FinalProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    lazy var persistentContainerData: NSPersistentContainer = {
//        let container = NSPersistentContainer (name: "CoreData")
//        container.loadPersistentStores { description, error in
//            if let error {
//                print (error.localizedDescription)
//            } else {
//                print("DB url -", description.url?.absoluteString)
//            }
//        }
//        return container
//    }()
//    
//    func saveContextData() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//                print("Successfully")
//            }
//            catch {
//                fatalError(error.localizedDescription)
//                print("Error Sending")
//            }
//        }
//    }
}

