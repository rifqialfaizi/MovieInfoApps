//
//  HomeViewController.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 19/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    private var pickerViewHolder: UIView!
    private var pickerView: UIPickerView!
    
    var viewModel: HomeViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = HomeViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.reachability.whenUnreachable = { [weak self] _ in
            self?.showNoInternetConnectionAlert()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        pickerViewHolder.isHidden = true
    }
    
    private func setupUI() {
        setupCollectionView()
        setupPicker()
        setTitle()
    }
    
    private func setTitle() {
        titleButton.setTitle(viewModel.category.title + " Movie ▼", for: .normal)
    }
    
    private func setupPicker() {
        pickerViewHolder = UIView(frame: CGRect(x: 0, y: view.frame.height - 300, width: view.frame.width, height: 300))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(categoryPickerDoneDidTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(categoryPickerCancelDidTap))
        let accessory = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerViewHolder.frame.width, height: 40))
        accessory.barStyle = .default
        accessory.isTranslucent = false
        accessory.items = [cancelButton, spaceButton, doneButton]
        pickerViewHolder.addSubview(accessory)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: accessory.frame.height, width: view.frame.width, height: 260))
        pickerView.backgroundColor = .white
        pickerViewHolder.addSubview(pickerView)
        view.addSubview(pickerViewHolder)
        pickerViewHolder.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func titleButtonDidTap(_ sender: Any) {
        pickerViewHolder.isHidden = false
    }
    
    @objc func categoryPickerDoneDidTap() {
        let category = MovieCategory.allCases[pickerView.selectedRow(inComponent: 0)]
        guard viewModel.category != category else { return }
        viewModel.category = category
        viewModel.loadData(shouldResetData: true)
        setTitle()
        pickerViewHolder.isHidden = true
    }
    
    @objc func categoryPickerCancelDidTap() {
        pickerViewHolder.isHidden = true
    }
    
    private func setupCollectionView() {
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        homeCollectionView.register(
            UINib(
                nibName: "MovieCollectionViewCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.movies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.homeCollectionView.reloadData()
            }
        }
        
        viewModel.loadData(shouldResetData: true)
    }
    
}
