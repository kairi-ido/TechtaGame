//
//  ViewController.swift
//  TechtaGame
//
//  Created by 井戸海里 on 2020/09/10.
//  Copyright © 2020 IdoUmi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //画像を表示するImageViewの宣言
    @IBOutlet var cameraImageView : UIImageView!
    
    //画像加工するためのもととなる画像
    var originalImage : UIImage!
    //画像を加工するフィルターの宣言
    var filter : CIFilter!
    
    var filter2 : CIFilter!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //撮影するボタンを押した時のメソッド
    @IBAction func takePhoto(){
        //カメラが使えるかの確認
    if UIImagePickerController.isSourceTypeAvailable(.camera){
            //カメラを起動
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker,animated: true,completion: nil)
    }else{
        //カメラが使えない時はエラーコンソールに出る
        print("error")
        }
    }
    //カメラ、カメラロールを使ったときに選択した画像をアプリ内に表示するためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        cameraImageView.image = info[.editedImage] as? UIImage
        //カメラで写真をとった後、その画像を加工する前の元画像としてとっておく
        originalImage = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    //撮影した画像を保存するメソッド
    @IBAction func savePhoto(){
        //保存する処理
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
        
    }
    //表示している画像フィルターを加工する時のメソッド
    @IBAction func colorFilter(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        //彩度の調整
        filter.setValue(1.0, forKey: "inputSaturation")
        //明度の調整
        filter.setValue(0.5, forKey: "inputBrightness")
        //コントラストの調整
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    //表示している画像にフィルターを加工する２
    @IBAction func colorFilter2(){
        
        let filterImage: CIImage = CIImage(image: originalImage)!
        //フィルターの設定
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        //彩度の調整
        filter.setValue(1.0, forKey: "inputSaturation")
        //明度の調整
        filter.setValue(0.8, forKey: "inputBrightness")
        //コントラストの調整
        filter.setValue(3.3, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
        
    }
    //カメラロールにある画像を読み込む時のメソッド
    @IBAction func openAlbum(){
        //カメラロールを使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //カメラロールの画像を選択して画像を表示するまでの一連の流れ
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker,animated: true,completion: nil)
            
        }
        
    }
    //SNSに編集した画像を投稿したい時のメソッド
    @IBAction func snsPhoto(){
        //投稿する時に一緒に載せるコメント
        let shareText = "写真加工いえい！"
        
        //投稿する画像の選択
        let shareImage = cameraImageView.image!
        //投稿するコメントと画像の準備
        let activityItem:[Any] = [shareText,shareImage]
        
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo,.saveToCameraRoll,.print]
        
        present(activityViewController,animated: true,completion: nil)
        
        
        
        
    }


}

