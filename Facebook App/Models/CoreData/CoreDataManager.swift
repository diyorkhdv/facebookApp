//
//  CoreDataManager.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 14/03/23.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shareInstance = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveProfile(data: Data, email: String, id: String, name: String) {
        let profile = Profile(context: context)
        profile.image = data
        profile.name = name
        profile.email = email
        profile.id = id
        do {
            try context.save()
            print("Profile is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchProfiles() -> [Profile] {
        var fetchingImage = [Profile]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Profile]
        } catch {
            print("Error while fetching the profile")
        }
        return fetchingImage
    }
    func deleteProfiles() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let fetchingImages = try context.fetch(fetchRequest) as! [Profile]
            for object in fetchingImages {
                context.delete(object)
            }
            try context.save()
            print("Profiles deleted")
        } catch {
            print("Error while fetching the profiles")
        }
    }
}
