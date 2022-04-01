//
//  NowPlayingVM.swift
//  MVVM
// sddfvcsdg
//  Created by Gulam Ali on 30/03/22.
//

import Foundation

protocol NowPlayingProtocol : AnyObject {
    func didgetMovies(Movies:[resultsModel])
    func didgetApiFailure(error:String)
    func GotEmptyMovieArray()
}

extension NowPlayingProtocol{
    func didgetMovies(Movies:[resultsModel]){}
    func didgetApiFailure(error:String){}
    func GotEmptyMovieArray(){}
}

class NowPlayingVM{
    
    var Movies:[resultsModel] = [resultsModel]()
    weak var delegate : NowPlayingProtocol!
    
    //MARK: Get Now playing movies
    func getNowPlayingMovies(){
        Loader.showUniversalLoadingView(true)
        let serverURL = Endpoints.baseurl + Endpoints.getnowPlayingMovie
        Networking.shared.MakeGetRequest(Url: serverURL) { [self] (result : Result<NowplayingModel,CustomError>) in
        
            switch result {
            case .success(let response):
                guard let hasMovies = response.results else {return}
                HandleAPIsuccess(movies: hasMovies)
                break
                
            case .failure(let failedcase):
                HandleAPIfailureCases(cases: failedcase)
                break
            
            }
        }
    }
    

    
    //MARK: Handle API errors
    private func HandleAPIfailureCases(cases:CustomError){
        DispatchQueue.main.async {
            Loader.showUniversalLoadingView(false)
        }
        switch cases {
        case .noInternet:
            print("No internet connection")
            self.delegate.didgetApiFailure(error: "No internet connection")
        case .badStatusCode:
            print("status code is not 200")
            self.delegate.didgetApiFailure(error: "status code is not 200")
        case.errorfetchingData:
            print("error fetching data")
            self.delegate.didgetApiFailure(error: "error fetching data")
        default:
            print("Got error case")
            self.delegate.didgetApiFailure(error: "Something went wrong,Try again later")
        }
    }
    
    //MARK: Handle success case
    func HandleAPIsuccess(movies:[resultsModel]){
        DispatchQueue.main.async {
            Loader.showUniversalLoadingView(false)
        }
        if checkifMovieArrayEmpty(movies: movies) == true{
            //Array is empty
            delegate.GotEmptyMovieArray()
        }else{
            //Array has movies
            FilterMoviesByRating(movies: movies)
        }
    }
    
    
    //MARK: Check if movie array is not empty
    func checkifMovieArrayEmpty(movies:[resultsModel]) -> Bool{
        if movies.count != 0{
            return false
        }else{
            return true
        }
    }
    

    //MARK: Filtering movies by highest rating
    
    @discardableResult func FilterMoviesByRating(movies:[resultsModel]) -> [resultsModel]{
        let ratingDescending = movies.sorted { (a,b) in
            return a.vote_average ?? 0.0 > b.vote_average ?? 0.0
        }
        print("count ->",ratingDescending.count)
        Movies = ratingDescending
        delegate.didgetMovies(Movies: Movies)
         return ratingDescending
    }

    
    
}
