//
//  HomeViewController+CollectionView.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell,
            let movie = viewModel.getMovie(at: indexPath.row)
        else {
            return UICollectionViewCell ()
        }
        cell.updateView(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            if let indexPath = homeCollectionView?.indexPathsForSelectedItems?.first {
                let viewModel = DetailViewModel(movie: viewModel.movies.value?[indexPath.row])
                vc.viewModel = viewModel
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("✅ willDisplay for indexPath \(indexPath)")
         if indexPath.row == viewModel.movies.value!.count - 1 {
             viewModel.loadData(shouldResetData: false)
         }
         
     }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let width: CGFloat = (homeCollectionView.frame.size.width - space) * 0.5
        let height: CGFloat = (homeCollectionView.frame.size.height - space) * 0.42
        return CGSize(width: width, height: height)
    }

}
