//
//  NvXmlUtils.h
//  textxml
//
//  Created by 施周虎 on 2019/6/14.
//  Copyright © 2019 施周虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NvXmlUtils : NSObject

- (BOOL)create:(NSString *)filePath data:(NSData *)data;

- (NSXMLDocument *)createXMLDocument;

- (NSXMLElement *)createRootElement;

- (NSXMLElement *)createLevel1Element:(NSString *)name;

- (NSXMLElement *)createLevel2ElementWith:(NSString *)name attributes:(NSMutableDictionary *)attributes;

- (NSData *)formatXMLData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
