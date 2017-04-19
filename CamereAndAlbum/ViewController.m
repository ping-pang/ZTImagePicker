//
//  ViewController.m
//  CamereAndAlbum
//
//  Created by zt on 17/4/14.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ViewController.h"
#import "ZTImagePickerViewController.h"
#import "ZTShowImagesView.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)ZTShowImagesView *showView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ZTShowImagesView *show = [[ZTShowImagesView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
//    show.imageArray = array;
//    [self.view addSubview:show];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-50, self.view.frame.size.width-40, 40)];
    [btn setTitle:@"add pic" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)click{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"msg" message:@"select" preferredStyle:UIAlertControllerStyleActionSheet];
 
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
        
    }];
    
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self album];
        
    }];
       UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:camera];
    [alert addAction:album];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)camera{
    [self presentViewToImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

-(void)album{
    [self presentViewToImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)presentViewToImagePickerWithSourceType:(UIImagePickerControllerSourceType)type{
    ZTImagePickerViewController *picker = [[ZTImagePickerViewController alloc]init];
    picker.type = type;
    picker.allowEdit = YES;
    picker.quality = .5;
    picker.CallBackImage = ^(UIImage *image){
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
        imgV.image = image;
        
        if (!_showView) {
            _showView = [[ZTShowImagesView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80) andImageNumWithHorizontal:4];
            [self.view addSubview:_showView];
        }
        [_showView addImage:image];
        
    };
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
