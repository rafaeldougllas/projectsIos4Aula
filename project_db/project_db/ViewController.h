//
//  ViewController.h
//  project_db
//
//  Created by Treinamento on 19/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <UIKit/UIKit.h>
//UITextViewDelegate esconder o teclado
@interface ViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;

@end

