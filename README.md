# Fokker Services

Fokker IOS application, this application provide Fokker engineer the service of checking the availability for the planes parts they need to get or to repair in different warehouses world wide, also allow to send emails for ordering those parts or asking for a qoute 

## Features 
- Search For part number
- Check Part in Stock
- Add part to checklist
- Send Request for Parts (Send RFQ)
- Check Repair availability warehouses
- Send Repair inquiry
- Search History
- Set Account Info
- Request Order Status
- Request Order Document
- Spares Quick Quate
- Send Feedback via e-Mail

## Requirements

- IOS 8+
- Xcode 8+
- Objective-c

## Installing

- Download the project Development Branch
- Install cocoapods for the app "pod install"
- Set Application Certificate for Testing on device, you can find it in following confulunce page https://doc.themobilecompany.com/display/FOKKER/Stock+Info+-+iPhone

## Libraries
- TMCConfigEngine 1.1.2
- TMCAnalytics 0.0.7
- SSZipArchive 0.3.1
- StyledPageControl 1.0


## Update Database 

In some Cases you maybe asked for updating the Fokker.sqlite file , for create new file follow instruction in "Database & Script" section in confulunce page 
https://doc.themobilecompany.com/display/FOKKER/Stock+Info+-+iPhone

Note: you have to increase the value of constaint "kDBCurrentVersion" in FokkerDefines.h when updating the database file so app can detect new file on update.

## What's new in 2.2
- Updated Database
- Add Request spare Qoutes 
- Remove Atlanta warehours from Reparing option
- Add Rating Screen that shows automatically after second launch and accesible from home screen