//
//  Protocols.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 15/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#ifndef Protocols_h
#define Protocols_h

#import <UIKit/UIKit.h>

@protocol sendStationFromProtocol <NSObject>

- (void)sendStation:(Station *)station segueID:(NSString *)segueID;

@end



#endif /* Protocols_h */
