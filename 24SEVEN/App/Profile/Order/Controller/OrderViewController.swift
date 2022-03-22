//
//  OrderViewController.swift
//  24SEVEN
//
//  Created by Islom on 13/02/21.
//

import UIKit

class OrderViewController : GenericViewController {
    
    let _view = OrderView()
    
    let orderSections : [OrderTypes] = [
        .processing,
        .active,
        .delivered
    ]
    
    var selectedVC : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupPageVC()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
}

extension OrderViewController {
    private func setupCollectionView() {
        _view.collectionView.delegate = self
        _view.collectionView.dataSource = self
    }
    
    private func setupPageVC() {
        _view.pageViewController.delegate = self
        _view.pageViewController.dataSource = self
        _view.pageViewController.setViewControllers([_view.orderViewControllers[self.selectedVC]], direction: .forward, animated: false, completion: nil)
    }
    
    private func setup() {
        addChildViewController(vc: _view.pageViewController)
    }
    
    private func updateCells(previousIndex: Int, currentIndex: Int) {
        guard let oldCell = _view.collectionView.cellForItem(at: IndexPath(item: previousIndex, section: 0)) as? OrderTypeCollectionViewCell else { return }
        oldCell.setDeselected(index: selectedVC)
        
        selectedVC = currentIndex
        
        guard let newCell = _view.collectionView.cellForItem(at: IndexPath(item: selectedVC, section: 0)) as? OrderTypeCollectionViewCell else { return }
        newCell.setSelected(index: selectedVC, color: OrderTypes(rawValue: selectedVC)?.color)
    }
}

//MARK: - UICollectionViewDataSource
extension OrderViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderTypeCollectionViewCell.reuseId, for: indexPath) as? OrderTypeCollectionViewCell else { return UICollectionViewCell() }
        let idx = indexPath.row
        if idx == selectedVC {
            let color = OrderTypes(rawValue: idx)?.color
            cell.setSelected(index: idx, color: color)
        }
        
        let type = OrderTypes(rawValue: indexPath.row)
        cell.orderTypeLabel.text = type?.title
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension OrderViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCells(previousIndex: selectedVC, currentIndex: indexPath.row)
        
        _view.pageViewController.setViewControllers([_view.orderViewControllers[indexPath.row]], direction: .forward, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OrderViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3.0 - 10, height: 30.0)
    }
}

//MARK: - UIPageViewControllerDataSource
extension OrderViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = _view.orderViewControllers.firstIndex(of: viewController) else { return nil}
        
        if currentIndex == 0 {
            return _view.orderViewControllers.last
        } else {
            return _view.orderViewControllers[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = _view.orderViewControllers.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < _view.orderViewControllers.count - 1 {
            return _view.orderViewControllers[currentIndex + 1]
        } else  {
            return _view.orderViewControllers.first
        }
    }
    
    
}

//MARK: - UIPageViewControllerDelegate
extension OrderViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = _view.orderViewControllers.firstIndex(of: viewControllers[0]) else { return }
        
        updateCells(previousIndex: selectedVC, currentIndex: currentIndex)
    }
}
