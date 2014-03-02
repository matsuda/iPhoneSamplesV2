//
//  ViewController.m
//  TestXSWI
//
//  Created by Kosuke Matsuda on 2013/06/26.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "XMLWriter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self constructXML];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)constructXML
{
    XMLWriter *xmlWriter = [[XMLWriter alloc] init];
//    xmlWriter.lineBreak = NULL;
//    xmlWriter.indentation = NULL;
    [xmlWriter writeStartDocumentWithVersion:@"1.0"];

    // <- customer_request
    [xmlWriter writeStartElement:@"customer_request"];

    // <- credential
    [xmlWriter writeStartElement:@"credential"];

    // <- id
    [xmlWriter writeStartElement:@"id"];
    [xmlWriter writeCharacters:@"staff01"];
    [xmlWriter writeEndElement];
    // >- id

    [xmlWriter writeEndElement];
    // >- credential

    // <- customer
    [xmlWriter writeStartElement:@"customer"];

    // <- customer_number
    [xmlWriter writeStartElement:@"customer_number"];
    [xmlWriter writeCharacters:@"12345678"];
    [xmlWriter writeEndElement];
    // >- customer_number

    [xmlWriter writeEndElement];
    // >- customer

    [xmlWriter writeEndElement];
    // >- customer_request

    [xmlWriter writeEndDocument];

    NSString *xmlString = [xmlWriter toString];
    NSLog(@"XML >>>>> \n%@", xmlString);

    [xmlWriter release];
}

@end
