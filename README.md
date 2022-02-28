# PratibhaGoldmanSachs NASA-APOD

# Steps to run the project successfully:

1- Download Xcode 13.0

2- Create a folder in you machine and go the the folder

   `cd NASA-APOD/`
   
3- Clone project locally in your machine with below command:

    git clone https://github.com/PD006/PratibhaGoldmanSachsNASA-APOD.git
   
4- Go to the root directory where PratibhaGoldmanSachsNASA-APOD project is 

    cd PratibhaGoldmanSachsNASA-APOD/
   
5- Install Cocoapods dependencies

    pod install
   
6- If you are facing any issue as pod command not found then you need to install the Cocoapods. Please follow the step no: 7 otherwise jump to the step: 8

7- Install CocoaPods

    sudo gem install cocoapods
   
8- Open the project named as "PratibhaGoldmanSachsNASA-APOD.xcworkspace"

9- Clean the project by using a command
   
   `"command+Shift+K" or Xcode -> Product -> Clean`
   
10- Build & Run the project

   `Bild: "command+B" or Xcode -> Product -> Build #OR
    Run: "command+R" or Xcode -> Product -> Run`
    
11- Build the project and run it on the real device or Xcode Simulator


## General Note:

1- Run the project on the real device or Xcode Simulator.

2- On Landing screen application has:

-`Calendar` (Using Calendar we are allowing users to search for the picture for a date of their choice). User can not select future date in calendar and by swiping can select any past date.

-`Favourite` button with heart image on it. clicking this button user will have the list of favourite pictures list with detail able to click on cell and get more deatils. 

-`Show Picture` button by clicking this we are redirecting to the next page to get the picture details.

3- Details screen is howing Picture, title, explanation, and a button to add in favourite list.

4- On Favourite list by swiping can delete value from Favourite list.


