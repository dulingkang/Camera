# Camera
Custom camera using swift, can take photo, front camera flip

## 最基本的捕获图像

- 需要一个session：

```
let session = AVCaptureSession()
```

- 需要相机设备输入，前置或者后置：

```
let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == position {
                captureDevice = device as! AVCaptureDevice
            }
        }
```

position为init时指定的前置或者后置相机位置
- 现在有了相机设备，就可以获得AVCaptureDeviceInput，将它设为session的输入：

```
do {
            input = try AVCaptureDeviceInput.init(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("add video input error")
        }
}
```

- 如果获得了相机使用权限，显示相机图像流简单的方法是用AVCaptureVideoPreviewLayer：

```
previewLayer = AVCaptureVideoPreviewLayer.init(session: session)
previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
 previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCameraBottomHeight - kNavigationHeight)
```

## 使用相机

- 初始化preset:

```
camera = SSCamera.init(sessionPreset: AVCaptureSessionPresetPhoto, position: .Front)
```

- 添加上previewLayer:

```
cameraView.preview.layer.addSublayer(camera.previewLayer)
```

## 拍完照图像翻转

- 相机在不同的方向拍照时，拍出的照片带有方向信息，以前置拍照为例，如果想让前置所见即所得，应该这样：

```
outputImage = UIImage(CGImage: inputImage.CGImage!, scale: inputImage.scale, orientation: UIImageOrientation.LeftMirrored)
```

- 然后再来一次绘制，下面的方法会把图片按照当前的方向绘制出来：

```
UIGraphicsBeginImageContext(size)
inputImage.drawInRect(CGRectMake(0,0, size.width, size.height))
let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
```
