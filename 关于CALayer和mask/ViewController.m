//
//  ViewController.m
//  关于CALayer和mask
//
//  Created by th on 2018/7/29.
//  Copyright © 2018年 huant. All rights reserved.
//

#import "ViewController.h"
#import "AudioView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AudioView *BgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
}


- (void)initView{

    NSLog(@"%f, %f", self.BgView.frame.size.width, self.BgView.frame.size.height);
    
    [self.BgView layOutLayers];
    [self.BgView updatePercent:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
