//
//  WWViewController.m
//  Werewolf
//
//  Created by Shay Davidson on 3/6/13.
//  Copyright (c) 2013 IIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface WWViewController : UIViewController <GKSessionDelegate, GKPeerPickerControllerDelegate>

@property (nonatomic) GKSession *session;
@property (nonatomic) GKPeerPickerController *picker;
@property (nonatomic) NSMutableArray *peers;

- (void) connectToPeers:(id) sender;
- (void) sendALoudFart:(id)sender;
- (void) sendASilentAssassin:(id)sender;

@end

@implementation WWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker = [GKPeerPickerController new];
    self.picker.delegate = self;
    
    self.picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    self.peers = [NSMutableArray new];
    
    [self createConnectButton];
    
    // state machine methods
//    [self createNoVoteButton];
}

- (void)createConnectButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn addTarget:self action:@selector(connectToPeers:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Connect" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 100, 280, 30);
    btn.tag = 12;
    [self.view addSubview:btn];
 
}

// Connect to other peers by displayign the GKPeerPicker
- (void) connectToPeers:(id) sender{
    [self.picker show];
}

- (void) sendALoudFart:(id)sender{
    // Making up the Loud Fart sound <img src="http://vivianaranha.com/wp-includes/images/smilies/icon_razz.gif" alt=":P" class="wp-smiley">
    NSString *loudFart = @"Brrrruuuuuummmmmmmppppppppp";
    
    // Send the fart to Peers using teh current sessions
    [self.session sendData:[loudFart dataUsingEncoding: NSASCIIStringEncoding] toPeers:self.peers withDataMode:GKSendDataReliable error:nil];
    
}

- (void) sendASilentAssassin:(id)sender{
    // Making up the Silent Assassin <img src="http://vivianaranha.com/wp-includes/images/smilies/icon_razz.gif" alt=":P" class="wp-smiley">
    NSString *silentAssassin = @"Puuuuuuuusssssssssssssssss";
    
    // Send the fart to Peers using teh current sessions
    [self.session sendData:[silentAssassin dataUsingEncoding: NSASCIIStringEncoding] toPeers:self.peers withDataMode:GKSendDataReliable error:nil];
    
}

#pragma mark - GKPeerPickerControllerDelegate

// This creates a unique Connection Type for this particular applictaion
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type{
    // Create a session with a unique session ID - displayName:nil = Takes the iPhone Name
    GKSession* session = [[GKSession alloc] initWithSessionID:@"com.vivianaranha.sendfart" displayName:nil sessionMode:GKSessionModePeer];
    return session;
}

// Tells us that the peer was connected
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    
    // Get the session and assign it locally
    self.session = session;
    session.delegate = self;
    
    //No need of teh picekr anymore
    picker.delegate = nil;
    [picker dismiss];
}

// Function to receive data when sent from peer
- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    //Convert received NSData to NSString to display
    NSString *whatDidIget = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    //Dsiplay the fart as a UIAlertView
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fart Received" message:whatDidIget delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
    
    if(state == GKPeerStateConnected){
        // Add the peer to the Array
        [self.peers addObject:peerID];
        
        NSString *str = [NSString stringWithFormat:@"Connected with %@",[session displayNameForPeer:peerID]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connected" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        // Used to acknowledge that we will be sending data
        [session setDataReceiveHandler:self withContext:nil];
        
        [[self.view viewWithTag:12] removeFromSuperview];
        
        UIButton *btnLoudFart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnLoudFart addTarget:self action:@selector(sendALoudFart:) forControlEvents:UIControlEventTouchUpInside];
        [btnLoudFart setTitle:@"Loud Fart" forState:UIControlStateNormal];
        btnLoudFart.frame = CGRectMake(20, 150, 280, 30);
        btnLoudFart.tag = 13;
        [self.view addSubview:btnLoudFart];
        
        UIButton *btnSilentFart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnSilentFart addTarget:self action:@selector(sendASilentAssassin:) forControlEvents:UIControlEventTouchUpInside];
        [btnSilentFart setTitle:@"Silent Assassin" forState:UIControlStateNormal];
        btnSilentFart.frame = CGRectMake(20, 200, 280, 30);
        btnSilentFart.tag = 14;
        [self.view addSubview:btnSilentFart];
    }
    
}

@end

