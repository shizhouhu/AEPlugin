//
//  NvXmlUtils.m
//  textxml
//
//  Created by 施周虎 on 2019/6/14.
//  Copyright © 2019 施周虎. All rights reserved.
//

#import "NvXmlUtils.h"

#define C_ROOT_NAME                         @"Root"
#define C_ROOT_ELEMENT_START                "<Root>"
#define C_ROOT_ELEMENT_START_RETURN         "\n<Root>"
#define C_ROOT_ELEMENT_END                  "</Root>"
#define C_ROOT_ELEMENT_END_RETURN           "\n</Root>"
#define C_TO_NS(STRING)                     [NSString stringWithCString:STRING encoding:NSUTF8StringEncoding]

@implementation NvXmlUtils {
    NSMutableArray *level1Elements;
    NSMutableArray *level2Elements;
}

- (instancetype)init {
    self = [super init];
    
    level1Elements = [NSMutableArray new];
    level2Elements = [NSMutableArray new];
    return self;
}

- (BOOL)create:(NSString *)filePath data:(NSData *)data{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    return [fileManager createFileAtPath:filePath contents:data attributes:nil];
}

- (NSXMLDocument *)createXMLDocument {
    return [[NSXMLDocument alloc] initWithXMLString:@"Test" options:NSXMLDocumentTidyXML error:    nil];
}

- (NSXMLElement *)createRootElement {
    return [NSXMLNode elementWithName:C_ROOT_NAME];
}

- (NSXMLElement *)createLevel1Element:(NSString *)name {
    if (![level1Elements containsObject:name])
        [level1Elements addObject:name];
    return [NSXMLNode elementWithName:name];
}

- (NSXMLElement *)createLevel2ElementWith:(NSString *)name attributes:(NSMutableDictionary *)attributes {
    if (![level2Elements containsObject:name])
        [level2Elements addObject:name];
    NSXMLElement *element = [NSXMLNode elementWithName:name];

    for (NSString *key in attributes) {
        [element addAttribute:[NSXMLNode attributeWithName:key stringValue:attributes[key]]];
    }

    return element;
}

- (NSData *)formatXMLData:(NSData *)data {
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    dataString = [dataString stringByReplacingOccurrencesOfString:C_TO_NS(C_ROOT_ELEMENT_START) withString:C_TO_NS(C_ROOT_ELEMENT_START_RETURN)];
    dataString = [dataString stringByReplacingOccurrencesOfString:C_TO_NS(C_ROOT_ELEMENT_END) withString:C_TO_NS(C_ROOT_ELEMENT_END_RETURN)];
    for (NSString *level1Element in level1Elements) {
        dataString = [dataString stringByReplacingOccurrencesOfString: [@"<" stringByAppendingString: level1Element] withString:[@"\n\t<" stringByAppendingString: level1Element]];
        dataString = [dataString stringByReplacingOccurrencesOfString: [@"</" stringByAppendingString: level1Element] withString:[@"\n\t</" stringByAppendingString: level1Element]];
    }
    for (NSString *level2Element in level2Elements) {
        dataString = [dataString stringByReplacingOccurrencesOfString: [@"<" stringByAppendingString: level2Element] withString:[@"\n\t\t<" stringByAppendingString: level2Element]];
    }
    
    return [dataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end

