import UIKit

public class GalleryViewController: UIViewController,CellDelegate {
    

    public var images:[ImageItem]!

    public func openImageOnFullScreen(index: Int) {
        self.viewFullScreen(imageType: images[index])
    }
    

    
    public lazy var collectionView:UICollectionView = {
        // Flow layout setup
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: self.view.bounds.width, height: ((self.view.bounds.width)/3)*2)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register( UINib(nibName: FirstCVC.NibName, bundle: Bundle(for: FirstCVC.self)), forCellWithReuseIdentifier: FirstCVC.reuseIdentifier)
        cv.register( UINib(nibName: SecondCVC.NibName, bundle: Bundle(for: SecondCVC.self)), forCellWithReuseIdentifier: SecondCVC.reuseIdentifier)
        cv.register( UINib(nibName: ThirdCVC.NibName, bundle: Bundle(for: ThirdCVC.self)), forCellWithReuseIdentifier: ThirdCVC.reuseIdentifier)
        return cv
    }()
    
    override public func loadView() {
        super.loadView()
        //view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bindFrameToSuperview()
        title = "Gallery"
        collectionView.reloadData()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    
    override public func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
}

extension GalleryViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        let val :Double = Double(images.count) / 12.0
        return Int(val.rounded(.up))
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let val = images.count % 12
        let sec :Double = Double(images.count) / 12.0
        let totalSection = Int(sec.rounded(.up))
        if(section == totalSection - 1 ){
            if(val < 4){
                return 1
            }
            else if(val < 10){
                return 2
            }
            else{
                return 3
            }
        }
        else{
            return 3
        }
    }
    public func setImageOfType(index: Int, on imageView: UIImageView) {
        imageView.tag = index
        let imageType: ImageItem = images[index]
        switch imageType {
        case .url(let url, _):
            imageView.downloaded(from: url)
        case .image(let image):
            imageView.image = image
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell:FirstCVC = collectionView
                .dequeueReusableCell(withReuseIdentifier: FirstCVC.reuseIdentifier,
                                     for: indexPath) as! FirstCVC
            cell.delegate = self
            let index = indexPath.section * 12
            if(index < images.count){
                setImageOfType(index: index, on: cell.img1)
            }
            if(index+1 < images.count){
                setImageOfType(index: index+1, on: cell.img2)
            }
            if(index+2 < images.count){
                setImageOfType(index: index+2, on: cell.img3)
            }
            
            
            return cell
        }
        else if(indexPath.row == 1){
            let cell:ThirdCVC = collectionView
            .dequeueReusableCell(withReuseIdentifier: ThirdCVC.reuseIdentifier,
                                 for: indexPath) as! ThirdCVC
            cell.delegate = self
            let index = indexPath.section * 12
            if(index+3 < images.count){
                setImageOfType(index: index+3, on: cell.img1)
            }
            if(index+4 < images.count){
                setImageOfType(index: index+4, on: cell.img2)
            }
            if(index+5 < images.count){
                setImageOfType(index: index+5, on: cell.img3)
            }
            if(index+6 < images.count){
                setImageOfType(index: index+6, on: cell.img4)
            }
            if(index+7 < images.count){
                setImageOfType(index: index+7, on: cell.img5)
            }
            if(index+8 < images.count){
                setImageOfType(index: index+8, on: cell.img6)
            }
            
            return cell
        }
        else {
            let cell:SecondCVC = collectionView
            .dequeueReusableCell(withReuseIdentifier: SecondCVC.reuseIdentifier,
                                 for: indexPath) as! SecondCVC
            cell.delegate = self
            let index = indexPath.section * 12
            if(index+9 < images.count){
                setImageOfType(index: index+9, on: cell.img1)
            }
            if(index+10 < images.count){
                setImageOfType(index: index+10, on: cell.img2)
            }
            if(index+11 < images.count){
                setImageOfType(index: index+11, on: cell.img3)
            }
            return cell
        }
        
        
    }
    
    public func viewFullScreen(imageType: ImageItem) {
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.tag = 123
        scrollView.minimumZoomScale = 0.8
        scrollView.maximumZoomScale = 6.0
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        scrollView.delegate = self


        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imgView.backgroundColor = UIColor.black
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
    
        
        switch imageType {
            case .image(let image):
                imgView.image = image
            case .url(let URL, _):
                imgView.downloaded(from: URL)
        }
        imgView.tag = 1010
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeImage))
        tap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(tap)

        scrollView.addSubview(imgView)
        view.addSubview(scrollView)
        view.layoutIfNeeded()

        UIView.animate(withDuration: 0.2, animations: {
            imgView.frame = self.view.bounds
            self.view.layoutIfNeeded()

        })
    }
    
    
    @objc public func removeImage(){
        if let scrollView = self.view.viewWithTag(123) {
            scrollView.removeFromSuperview()
        }
    }

}

extension GalleryViewController :UIScrollViewDelegate {
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat){
        if(scale < 1){
            scrollView.zoomScale = 1
        }
    }
    public func viewForZooming(in scrollView: UIScrollView ) -> UIView?{
        let imgView = scrollView.viewWithTag(1010)
        return imgView
    }
}
