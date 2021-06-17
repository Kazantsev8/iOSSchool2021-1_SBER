//
//  HW19ViewController.swift
//  MegaHomeWorkApp
//
//  Created by Иван Казанцев on 08.06.2021.
//

import UIKit

class HW19ViewController: UIViewController {
    
    //MARK: - PROPERTIES
    var selectedImage: UIImage? = nil {
        didSet {
            filteredImages = []
            imageView.image = selectedImage
            imageFilterService.filters.forEach { filter in
                imageFilterService.change(image: self.selectedImage, with: filter) { filteredImage in
                    self.filteredImages.append(filteredImage)
                    self.filtersCollectionView.reloadData()
                }
            }
            self.filtersCollectionView.reloadData()
        }
    }
    var filteredImages: [UIImage?] = []
    var selectedFilter: CIFilter? = nil
    var imageFilterService: ImageFilterServiceProtocol
    var appCoordinator: AppCoordinator
    
    
    //MARK: - INITIALIZERS
    init(imageFilterService: ImageFilterServiceProtocol, appCoordinator: AppCoordinator) {
        self.imageFilterService = imageFilterService
        self.appCoordinator = appCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    //main image
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    //navigation bar
    private lazy var pickImageNavigationBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "pick", style: .done, target: self, action: #selector(pickImage))
        return button
    }()
    private lazy var saveImageNavigationBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveImage))
        return button
    }()
    
    //filters collection view
    private lazy var filtersCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    //filter intensity slider
    private lazy var filterIntensitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isHidden = true
        slider.backgroundColor = .black
        slider.alpha = 0.4
        slider.layer.cornerRadius = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    //image picker pop up controller
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    //MARK: - VIEW CONTROLLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        //subviews
        view.addSubview(imageView)
        view.addSubview(filterIntensitySlider)
        view.addSubview(filtersCollectionView)
        //collection view
        let layout = createLayout()
        filtersCollectionView.collectionViewLayout = layout
        //navigation bar
        navigationItem.rightBarButtonItems = [saveImageNavigationBarButton, pickImageNavigationBarButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //layouts subviews
        imageViewConstraints()
        filterIntensitySliderConstraints()
        filtersCollectionViewConstraints()
        //other functions
        configureNavigationBar()
    }
    
    //MARK: - AUTOLAYOUTS
    //image view
    private func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ])
    }
    //filter intensity slider
    private func filterIntensitySliderConstraints() {
        NSLayoutConstraint.activate([
            filterIntensitySlider.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            filterIntensitySlider.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            filterIntensitySlider.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 5),
            filterIntensitySlider.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    //filters collection view
    private func filtersCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            filtersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filtersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filtersCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    //creating layout for collection view
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .fractionalHeight(1.0))
        let filterItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: filterItem,
                                                       count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    //MARK: - UI ITEMS SELECTORS
    @objc func pickImage() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveImage() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @objc func showFilterIntensity() {
        filterIntensitySlider.isHidden = filterIntensitySlider.isHidden ? false : true
    }
    
    //MARK: - OTHER FUNCTIONS
    private func configureNavigationBar() {
        self.navigationItem.title = "HOMEWORK 19"
    }
    
}

//MARK: - EXTENSION PICKER CONTROLLER PROTOCOLS
extension HW19ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        self.selectedImage = image
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - EXTENSION COLLECTION VIEW PROTOCOLS
extension HW19ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filtersCollectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.identifier,
                                                             for: indexPath) as! FiltersCollectionViewCell
        cell.imageView.image = filteredImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = filteredImages[indexPath.row]
    }
    
}
