import SwiftUI

struct PrayerTime {
    var name: String
    var time: String
}

struct ContentView: View {
    @State var mosque_name = "Central Park Masjid"
    @State private var arabic_date: String = ""
    func loadArabicDate() {
        let gregorianDate = Date()
        let hijriCalendar = Calendar(identifier: .islamicCivil)
        let formatter = DateFormatter()
        
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "MMMM d, yyyy"  // Adjust the format as needed

        arabic_date = formatter.string(from: gregorianDate)
    }
    @State var remainingTime = ""
    
    let prayerDetails = [
        PrayerTime(name: "Fazr", time: "5:00 AM"),
        PrayerTime(name: "Zuhr", time: "1:30 PM"),
        PrayerTime(name: "Asr", time: "4:40 PM"),
        PrayerTime(name: "Magrib", time: "7:15 PM"),
        PrayerTime(name: "Isha", time: "8:50 PM")
    ]

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                VStack(spacing: 10) {
                    Text(mosque_name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text(arabic_date)
                                .font(.headline)
                                .opacity(0.8)
                                .onAppear(perform:loadArabicDate) // Call the function when the view appears
                }
                
                HStack(spacing: 130) {
                    prayerTimeView(prayer: prayerDetails[0].name, time: prayerDetails[0].time)
                    prayerTimeView(prayer: prayerDetails[1].name, time: prayerDetails[1].time)
                }
                
                ZStack {
                    ProgressRing(mid_time: prayerDetails[3].time)
                    VStack(spacing: 15) {
                        Text(remainingTime)
                            .font(.headline)
                            .padding()
                    }
                }
                
                HStack(spacing: 130) {
                    prayerTimeView(prayer: prayerDetails[2].name, time: prayerDetails[2].time)
                    prayerTimeView(prayer: prayerDetails[4].name, time: prayerDetails[4].time)
                }
            }
            .padding()
            .foregroundColor(Color.black)
            .onReceive(timer) { _ in
                updateRemainingTime()
            }
        }
    }

    func prayerTimeView(prayer: String, time: String) -> some View {
        VStack(spacing: 10) {
            Text(prayer)
                .font(.headline)
                .padding(18)
                .background(Circle().fill(Color.white))
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 4)
                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                )
            Text(time)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }

    func updateRemainingTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let now = Date()
        
        for detail in prayerDetails {
            if let prayerTime = dateFormatter.date(from: detail.time), now < prayerTime {
                let timeInterval = Int(prayerTime.timeIntervalSince(now))
                let hours = timeInterval / 3600
                let minutes = (timeInterval % 3600) / 60
                remainingTime = "\(hours)h \(minutes)m left"
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
