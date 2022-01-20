//
//  ProgressRing.swift
//  CentralParkMasjid_01
//
//  Created by Mahdi Ashrafee on 8/9/22.
//

import SwiftUI

struct ProgressRing: View {
    
    //1Variables for CountDown
    
    @State var timerRunning = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //1!
    
    //2-Variable for Circle and what's inside
    @State var progress = 0.0
    @State var mid_name = "Magrib"
    @State var mid_time = "7:45 PM"
    @State var countDownTimer = 010.22
    //2!
    
    
   //------------------------------------Extra_Notification Functions
    func registerForPushNotifications() {
      UNUserNotificationCenter.current()
    .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
          print("Permission granted: \(granted)")
        }
    }
    //Extra!
    
    //-----//
    
//Main Program Off Progress Ring***********************************

    var body: some View {
    
        
//Circle Work-----------------
        ZStack{
            //Mark: Placeholder Ring
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            //Mark: Colored ring
            
            Circle()
                
                .trim(from: 0.0, to: min(progress,1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.4990131259, blue: 0.3690933585, alpha: 1)),Color(#colorLiteral(red: 0.8097479939, green: 0.515781045, blue: 0.9619458318, alpha: 1)),Color(#colorLiteral(red: 0, green: 0.8446387649, blue: 0.9508324265, alpha: 1)),Color(#colorLiteral(red: 0.6729030013, green: 0.303827405, blue: 0.9693880677, alpha: 1)),Color(#colorLiteral(red: 0, green: 0.6145805717, blue: 0.6419005394, alpha: 1)),Color(#colorLiteral(red: 0.9985464215, green: 0.5187285542, blue: 0.6105555892, alpha: 1))]),center:.center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration:countDownTimer),value:progress)
            
            
            
            
            
 
//CountDown Work-----------------------
        VStack(spacing: 30){
            
        //Mark: Elapse Time
            
            
                //CountDown for Prayer
                VStack(spacing:5)
                {
                    Text("\(mid_name)")
                       .opacity(0.7)
                    Text("\(mid_time)")
                    Text("Remaining Time")
                    Text(String(format: "%.0f", countDownTimer))
                        .onReceive(timer) { _ in
                            if countDownTimer > 1 && timerRunning {
                                registerForPushNotifications()
                                countDownTimer -= 1
                            }else{
                               
                                timerRunning = false
                            }
                            
                        }
                        .font(.system(size: 80 , weight: .bold))
                        .opacity(0.80)
                        
                }
            }
            
            
        }
        .frame(width: 250, height: 250)
        .padding()
        .onAppear{
            progress=1
        }
        
    }
}
//Extra












struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
    }
}

