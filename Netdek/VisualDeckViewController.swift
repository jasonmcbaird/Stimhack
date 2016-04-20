//
//  VisualDeckViewController.swift
//  Netdek
//
//  Created by Jason Baird on 11/18/15.
//  Copyright © 2015 Jason Baird. All rights reserved.
//

import Foundation
import UIKit

class VisualDeckViewController: UIViewController {
    
    @IBOutlet var scrollView: TappableScrollView!
    @IBOutlet var identityButton: UIButton!
    @IBOutlet var identityImageView: UIImageView!
    
    let widthHeightRatio: CGFloat = 0.717703
    
    var verticalMargin: Int = 40
    var horizontalMargin: Int = 40
    var horizontalPadding: Int = 30
    var verticalPadding: Int = 20
    var imageWidth: CGFloat = 150
    
    var deck: Deck!
    var playsetImages: [UIImageView: Playset] = Dictionary()
    var columns: [[UIImageView]] = []
    var totalHeight: CGFloat = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Crash: Deck is nil here sometimes.
        let playsets = deck.playsets.allObjects as! [Playset]
        scrollView.controller = self
        setAllCardImages(playsets)
        showImages()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        identityImageView.userInteractionEnabled = true
        identityImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func showIdentityImage() {
        let card = deck.identity.card
        if(card.getImage() != nil) {
            identityImageView.image = card.getImage()
            identityImageView.hidden = false
        } else {
            if(card.image != "") {
                if(identityImageView.image == nil || identityImageView.hidden) {
                    identityImageView.image = UIImage(named: "BlankCard")
                }
                identityImageView.hidden = false
                let imageDownloader = ImageDownloader(downloadAction: CardImageUpdateAction(imageView: identityImageView))
                imageDownloader.downloadCardImageByNumber(card, number: card.image)
            } else {
                print("No image found")
            }
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        showImages()
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        showImagesWithRotatedScreen()
    }
    
    func showImages() {
        showImages(UIScreen.mainScreen().bounds.width, screenHeight: UIScreen.mainScreen().bounds.height)
    }
    
    func showImagesWithRotatedScreen() {
        showImages(UIScreen.mainScreen().bounds.height, screenHeight: UIScreen.mainScreen().bounds.width)
    }
    
    func showImages(screenWidth: CGFloat, screenHeight: CGFloat) {
        clearTypeLabels()
        verticalMargin = Int(screenHeight) / 12
        horizontalMargin = Int(screenWidth) / 12
        let playsets = deck.playsets.allObjects as! [Playset]
        let types = CGFloat(countTypes(playsets))
        imageWidth = (4 * screenWidth - 8 * CGFloat(horizontalMargin))/(5 * types - 1)
        horizontalPadding = Int(imageWidth) / 4
        // TODO: Set vertical padding smaller if screen is too small
        if(Array<UIImageView>(playsetImages.keys)[0].image == nil) {
            verticalPadding = Int(getImageHeight(nil)) / 8
        } else {
            verticalPadding = Int(getImageHeight(Array<UIImageView>(playsetImages.keys)[0].image!)) / 8
        }
        showAlignedImages()
    }
    
    
    func setAllCardImages(playsets: [Playset]) {
        for playset in playsets {
            setCardImage(playset)
        }
    }
    
    func setCardImage(playset: Playset) {
        var imageViews: [UIImageView] = []
        for _ in 1...playset.count {
            imageViews.append(UIImageView())
            playsetImages.updateValue(playset, forKey: imageViews[imageViews.count - 1])
        }
        showCardImage(imageViews, card: playset.card)

    }
    
    func showAlignedImages() {
        columns = []
        var left = horizontalMargin
        var top = verticalMargin
        var lastCardType = ""
        
        let playsets = ArrayUtility.uniq(CardSorter.complexSort((Array(playsetImages.values))))
        for playset in playsets {
            let imageViews = (playsetImages as NSDictionary).allKeysForObject(playset) as! [UIImageView]
            for imageView in imageViews {
                var cardType = playsetImages[imageView]!.card.type.name
                if(cardType == "Program" && playsetImages[imageView]!.card.type.subtypes.containsObject("Icebreaker")) {
                    cardType = "Icebreaker"
                }
                /**if(imageView.image != nil && imageView.image!.size.width > imageWidth) {
                imageWidth = imageView.image!.size.width
                }*/
                if(cardType != lastCardType) {
                    if(lastCardType != "") {
                        left = left + Int(imageWidth) + horizontalPadding
                        top = verticalMargin
                    }
                    columns.append([imageView])
                    printTypeLabel(cardType, left: left)
                } else {
                    if(lastCardType != "") {
                        columns[columns.count - 1].append(imageView)
                        top += verticalPadding
                    }
                }
                //print("Displaying \(playset.card.name) at \(left) by \(top).")
                let imageHeight = getImageHeight(imageView.image)
                imageView.frame = CGRect(origin: CGPoint(x: left, y: top), size: CGSize(width: imageWidth, height: imageHeight))
                if(playsetImages[imageView]!.card.type.subtypes.containsObject("Icebreaker")) {
                    lastCardType = "Icebreaker"
                }
                lastCardType = cardType
                scrollView.addSubview(imageView)
                setTapResponse(imageView)
                if(totalHeight < CGFloat(top) + imageHeight) {
                    totalHeight = CGFloat(top) + imageHeight
                }
            }
        }
        scrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: totalHeight)
    }
    
    func printTypeLabel(type: String, left: Int) {
        let label = UILabel(frame: CGRect(origin: CGPoint(x: left, y: verticalMargin - 20), size: CGSize(width: imageWidth, height: 15)))
        label.text = type
        scrollView.addSubview(label)
    }

    func countTypes(playsets: [Playset]) -> Int {
        var types: [String] = []
        for playset in playsets {
            if(!types.contains(playset.card.type.name)) {
                types.append(playset.card.type.name)
            }
            if(playset.card.type.subtypes.containsObject("Icebreaker") && !types.contains("Icebreaker")) {
                types.append("Icebreaker")
            }
        }
        return types.count
    }
    
    func clearTypeLabels() {
        let typeLabels = scrollView.subviews.filter{$0 is UILabel}
        for label in typeLabels {
            label.removeFromSuperview()
        }
    }
    
    func getImageHeight(image: UIImage?) -> CGFloat {
        if(image == nil) {
            return imageWidth / widthHeightRatio
        }
        //print("Width to Height ratio: \(image!.size.width / image!.size.height)")
        return imageWidth / (image!.size.width / image!.size.height)
    }
    
    func setTapResponse(imageView: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: scrollView, action: Selector("tapImageView:"))
        tapGestureRecognizer.cancelsTouchesInView = false
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func bringToFront(column: [UIImageView], index: Int) {
        if(index != column.count - 1) {
            for i in (index + 1...column.count - 1).reverse() {
                scrollView.bringSubviewToFront(column[i])
            }
        }
        for i in 0...index {
            scrollView.bringSubviewToFront(column[i])
        }
    }
    
    func showCardImage(imageViews: [UIImageView], card: Card) {
        if(card.getImage() != nil) {
            for imageView in imageViews {
                imageView.image = card.getImage()
            }
        } else {
            if(card.image != "") {
                let imageDownloader = ImageDownloader(downloadAction: CardImageUpdateVisualAction(imageViews: imageViews))
                imageDownloader.downloadCardImageByNumber(card, number: card.image)
            } else {
                print("No image found for \(card.name)")
            }
        }
    }
    
    @IBAction func tapIdentityButton(sender: AnyObject) {
        showIdentityImage()
    }
    
    func imageTapped(img: AnyObject) {
        identityImageView.hidden = true
    }
}