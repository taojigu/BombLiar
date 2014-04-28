//
//  BombSettingViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-24.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "BombSettingViewController.h"

@interface BombSettingViewController ()<UITextFieldDelegate>{
    @private
    IBOutlet UITextField*densityTextField;

}

@end

@implementation BombSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger density=[[NSUserDefaults standardUserDefaults] integerForKey:DefaultSettingDensityKey];
    NSAssert(0!=density, @"Invalidate density setting");
    
    densityTextField.text=[NSString stringWithFormat:@"%li",(long)density];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [densityTextField resignFirstResponder];
}
#pragma mark -- action messages

-(IBAction)navigateBack:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- delegate messages

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString*numString=textField.text;
    NSInteger density=[numString intValue];
    if (0==density) {
        NSLog(@"Please input legal number");
        return;
    }
    [[NSUserDefaults standardUserDefaults]setInteger:density forKey:DefaultSettingDensityKey];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
