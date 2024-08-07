//
//  CoreManager.swift
//  RadioApp
//
//  Created by Елена Логинова on 07.08.2024.
//

import UIKit
import CoreData

class CoreManager {
    enum DataBaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = CoreManager()
    
    //Сохранение в базу
    func downloadRadioWith(model: RadioStation, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let item = RadioStations(context: context)
        item.name = model.name
        item.stationuuid = model.stationuuid
        item.url_resolved = model.url_resolved
        item.votes = Int64(model.votes)
        item.tags = model.tags
        //item.isFavorite = model.isFavorite ?? false
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    //Получение из базы
    func fetchingRadioFromDataBase(completion: @escaping (Result<[RadioStations], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<RadioStations>
        
        request = RadioStations.fetchRequest()
        
        do {
            let stations = try context.fetch(request)
            completion(.success(stations))
        } catch {
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    //Удаление из базы
    func deleteRadioWith(model: RadioStations, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToDeleteData))
        }
    }
    
    func deleteRadioFromFavorites(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy //?
        
        let request: NSFetchRequest<RadioStations>
        request = RadioStations.fetchRequest()
        request.predicate = NSPredicate(format: "stationuuid == %@", id)
    
        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
                try context.save()
                completion(.success(()))
            }
        } catch {
            completion(.failure(DataBaseError.failedToDeleteData))
        }
    }
}


extension CoreManager {

    func updateLike(id: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<RadioStations>
        request = RadioStations.fetchRequest()
        
        var favoritesRadio: [RadioStations] = []
    
        do {
            let result = try context.fetch(request)
            favoritesRadio = result
        } catch {
            print(error.localizedDescription)
        }
        
        if favoritesRadio.contains(where: { $0.stationuuid == id }) == true {
            return true
        } else {
            return false
        }
    }
}

