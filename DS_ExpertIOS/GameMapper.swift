//
//  DataMaper.swift
//  DS_ExpertIOS
//
//  Created by Admin on 05/03/24.
//

import Foundation

class GameMapper {
  
  static func modelToEntity(game: GameModel) -> GameEntity {
    return GameEntity(
      id: game.id,
      title: game.title,
      rating: game.rating,
      releaseDate: getDateStringFull(date: game.releaseDate),
      posterPath: game.posterPath,
      description: game.description,
      genre: game.genre,
      reviewsCount: game.reviewsCount,
      isFavorite: game.isFavorite
    )
  }
  
  static func entitiesToModel(entity: [GameEntity]) -> [GameModel] {
    return entity.map { result in
      return entityToModel(entity: result)
    }
  }
  
  static func entityToModel(entity: GameEntity) -> GameModel {
    return GameModel(
      id: entity.id,
      title: entity.title,
      rating: entity.rating,
      releaseDate: generateDate(dateString: entity.releaseDate),
      posterPath: entity.posterPath,
      description: entity.description,
      genre: entity.genre,
      reviewsCount: entity.reviewsCount,
      isFavorite: entity.isFavorite
    )
  }
  
  static func responseToEntity(response: GamesResponse) -> [GameEntity] {
    let toResult = response.results ?? []
    
    return toResult.map { result in
      GameEntity(
        id: result.id ?? 0,
        title: result.name ?? "not_found",
        rating: result.rating ?? 0.0,
        releaseDate: result.released ?? "",
        posterPath: result.backgroundImage ?? "not_found"
      )
    }
  }
  
  static func detailResponseToEntity(response: GameDetailResponse) -> GameEntity {
    return GameEntity(
      id: response.id ?? 0,
      title: response.name ?? "not_found",
      rating: response.rating ?? 0.0,
      releaseDate: response.released ?? "",
      posterPath: response.backgroundImage ?? "not_found",
      description: response.description ?? "not_found",
      genre: generateGenre(response.genres),
      reviewsCount: response.reviewsCount ?? 0
    )
  }
  
  private static func generateGenre(_ genres: [GenreDetails]?) -> String {
    guard let genres = genres else { return "not found" }
    
    var result: String = ""
    for genre in genres where genre.name != nil {
      result += " \(genre.name!),"
    }
    
    result.remove(at: result.startIndex)
    result.remove(at: result.index(before: result.endIndex))
    return result
  }
}
