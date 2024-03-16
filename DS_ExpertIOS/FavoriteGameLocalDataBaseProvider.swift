//
//  FavoriteGameCDProvider.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/02/24.
//

import CoreData
import Combine

struct FavoriteGameCDIdentifier {
  let persistanceName = "GamesCD"
  let entryName = "Game"
  // atribute
  let atributeId = "id"
  let atributeTitle = "title"
  let atributeRating = "rating"
  let atributeReleaseDate = "releaseDate"
  let atributePosterPath = "posterPath"
  let atributeDescription = "gameDescription"
  let atributeGenre = "genre"
  let atributeReviewsCount = "reviewsCount"
  let atributeIsFavorite = "isFavorite"
}

protocol FavoriteGameLocalDataBaseProtocol {
  func getAll() -> AnyPublisher<[GameEntity], Error>
  func get(id: Int) -> AnyPublisher<GameEntity?, Error>
  func create(_ game: GameEntity) -> AnyPublisher<GameEntity, Error>
  func creates(_ games: [GameEntity]) -> AnyPublisher<[GameEntity], Error>
  func update(_ game: GameEntity) -> AnyPublisher<GameEntity, Error>
  func getGameByName(name: String) -> AnyPublisher<[GameEntity], Error>
  func getGameFavoriteByName(name: String) -> AnyPublisher<[GameEntity], Error>
  func deleteAll() -> AnyPublisher<Void, Error>
  func delete(_ id: Int) -> AnyPublisher<Void, Error>
}

class FavoriteGameLocalDataBaseProvider: FavoriteGameLocalDataBaseProtocol {
  private let identifier = FavoriteGameCDIdentifier()
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: identifier.persistanceName)
    
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    
    return container
  }()
  
  func getAll() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        do {
          let result: [GameEntity] = try self.fetchData(
            taskContext, fetchRequest: self.createFectManageRequest(), getSingle: false
          ) as? [GameEntity] ?? []
          
          completion(.success(result))
          
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func get(id: Int) -> AnyPublisher<GameEntity?, Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        do {
          let fetchRequest = self.createFectManageRequest()
          fetchRequest.fetchLimit = 1
          fetchRequest.predicate = NSPredicate(
            format: "\(self.identifier.atributeId) == \(id)"
          )
          
          let result: GameEntity? = try self.fetchData(
            taskContext, fetchRequest: fetchRequest, getSingle: true
          ) as? GameEntity
          
          completion(.success(result))
          
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  private func getGameId(
    _ tasckContext: NSManagedObjectContext, id: Int,
    completionSuccess: @escaping (_ lastId: Int) -> Void,
    completionError: @escaping (_ error: Error) -> Void
  ) {
    let fetchRequest = createFectManageRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: identifier.atributeId, ascending: false)]
    fetchRequest.fetchLimit = 1
    
    do {
      let games: [GameModel] = try fetchData(
        tasckContext, fetchRequest: fetchRequest, getSingle: false
      ) as? [GameModel] ?? []
      
      for game in games where game.id == id {
        completionSuccess(id)
        return
      }
      completionSuccess(0)
      
    } catch {
      completionError(error)
    }
  }
  
  func create(_ game: GameEntity) -> AnyPublisher<GameEntity, Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.performAndWait {
        if let entry = NSEntityDescription.entity(
          forEntityName: self.identifier.entryName, in: taskContext
        ) {
          let result = NSManagedObject(entity: entry, insertInto: taskContext)
          
          self.getGameId(taskContext, id: game.id) { lastId in
            if lastId != game.id {
              do {
                self.configureMember(target: result, game)
                try taskContext.save()
                completion(.success(game))
                
              } catch let error as NSError {
                completion(.failure(error))
              }
              
            } else {
              completion(.failure(
                NSError(domain: "Data is exist!", code: 0)
              ))
            }
            
          } completionError: { error in
            completion(.failure(error))
          }
        }
        
      }
    }.eraseToAnyPublisher()
  }
  
  func creates(_ games: [GameEntity]) -> AnyPublisher<[GameEntity], Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.performAndWait {
        if let entry = NSEntityDescription.entity(
          forEntityName: self.identifier.entryName, in: taskContext
        ) {
          var gamesToResult: [GameEntity] = []
          
          for game in games {
            self.getGameId(taskContext, id: game.id) { lastId in
              do {
                if lastId != game.id {
                  let result = NSManagedObject(entity: entry, insertInto: taskContext)
                  self.configureMember(target: result, game)
                  try taskContext.save()
                  gamesToResult.append(game)
                }
                
              } catch let error as NSError {
                print(error.localizedDescription)
              }
              
            } completionError: { error in
              print(error.localizedDescription)
            }
          }
          
          completion(.success(gamesToResult))
        }
        
      }
    }.eraseToAnyPublisher()
  }
  
  func update(_ game: GameEntity) -> AnyPublisher<GameEntity, Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        let fetchRequest = self.createFectManageRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(
          format: "\(self.identifier.atributeId) == \(game.id)"
        )
        
        do {
          let result = try taskContext.fetch(fetchRequest).first
          
          if result != nil {
            self.configureMember(target: result!, game)
            try taskContext.save()
            completion(.success(game))
            
          } else {
            completion(.failure(
              NSError(domain: "Failed to update data!", code: 0)
            ))
          }
        } catch let error as NSError {
          completion(.failure(error))
        }
        
      }
    }.eraseToAnyPublisher()
  }
  
  func getGameByName(name: String) -> AnyPublisher<[GameEntity], Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        do {
          try self.loadGameByName(taskContext: taskContext, name: name) { result in
            completion(.success(result))
          }
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func getGameFavoriteByName(name: String) -> AnyPublisher<[GameEntity], Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        do {
          try self.loadGameByName(taskContext: taskContext, name: name) { entities in
            var result: [GameEntity] = []
            for entity in entities where entity.isFavorite {
              result.append(entity)
            }
            completion(.success(result))
          }
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  private func loadGameByName(
    taskContext: NSManagedObjectContext, name: String, completion: @escaping ([GameEntity]) -> Void
  ) throws {
    let fetchRequest = self.createFectManageRequest()
    fetchRequest.predicate = NSPredicate(
      format: "\(self.identifier.atributeTitle) CONTAINS %@", name
    )
    let result: [GameEntity] = try self.fetchData(
      taskContext, fetchRequest: fetchRequest, getSingle: false
    ) as? [GameEntity] ?? []
    
    completion(result)
  }
  
  func deleteAll() -> AnyPublisher<Void, Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        let fetchRequest = self.createFectObtainRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            completion(.success(()))
          }
        }
        
      }
    }.eraseToAnyPublisher()
  }
  
  func delete(_ id: Int) -> AnyPublisher<Void, Error> {
    return Future { completion in
      let taskContext = self.newTaskContext()
      
      taskContext.perform {
        let fetchRequest = self.createFectObtainRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "\(self.identifier.atributeId) == \(id)")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            completion(.success(()))
          }
        }
        
      }
    }.eraseToAnyPublisher()
  }
  
}

extension FavoriteGameLocalDataBaseProvider {
  private func newTaskContext() -> NSManagedObjectContext {
    return persistentContainer.newBackgroundContext()
  }
  
  private func createFectManageRequest() -> NSFetchRequest<NSManagedObject> {
    return NSFetchRequest<NSManagedObject>(entityName: identifier.entryName)
  }
  
  private func createFectObtainRequest() -> NSFetchRequest<NSFetchRequestResult> {
    return NSFetchRequest<NSFetchRequestResult>(entityName: identifier.entryName)
  }
  
  private func fetchData(
    _ taskContext: NSManagedObjectContext, fetchRequest: NSFetchRequest<NSManagedObject>, getSingle: Bool
  ) throws -> Any? {
    let results = try taskContext.fetch(fetchRequest)
    
    if getSingle {
      if let result = obtainGame(results.first) {
        return result
      }
    } else {
      var games: [GameEntity] = []
      
      for result in results {
        let game = obtainGame(result)
        if game != nil {
          games.append(game!)
        }
      }
      return games
    }
    
    return nil
  }
  
  private func obtainGame(_ result: NSObject?) -> GameEntity? {
    guard let result = result else { return nil }
    
    return GameEntity(
      id: result.value(forKeyPath: identifier.atributeId, 0),
      title: result.value(forKeyPath: identifier.atributeTitle, ""),
      rating: result.value(forKeyPath: identifier.atributeRating, 0),
      releaseDate: result.value(forKeyPath: identifier.atributeReleaseDate, ""),
      posterPath: result.value(forKeyPath: identifier.atributePosterPath, ""),
      description: result.value(forKeyPath: identifier.atributeDescription, ""),
      genre: result.value(forKeyPath: identifier.atributeGenre, "-"),
      reviewsCount: result.value(forKeyPath: identifier.atributeReviewsCount, 0),
      isFavorite: result.value(forKeyPath: identifier.atributeIsFavorite, false)
    )
  }
  
  private func configureMember(
    target targetObject: NSObject, _ game: GameEntity
  ) {
    targetObject.setValue(game.id, forKeyPath: identifier.atributeId)
    targetObject.setValue(game.title, forKeyPath: identifier.atributeTitle)
    targetObject.setValue(game.rating, forKeyPath: identifier.atributeRating)
    targetObject.setValue(game.releaseDate, forKeyPath: identifier.atributeReleaseDate)
    targetObject.setValue(game.posterPath, forKeyPath: identifier.atributePosterPath)
    targetObject.setValue(game.genre, forKeyPath: identifier.atributeGenre)
    targetObject.setValue(game.reviewsCount, forKeyPath: identifier.atributeReviewsCount)
    targetObject.setValue(game.isFavorite, forKeyPath: identifier.atributeIsFavorite)
  }
}

extension NSObject {
  func value<T>(forKeyPath keyPath: String, _ defaultValue: T) -> T {
    if let result = value(forKeyPath: keyPath) as? T {
      return result
    }
    return defaultValue
  }
}
