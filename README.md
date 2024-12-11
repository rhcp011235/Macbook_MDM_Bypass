# Bypass-MDM for MacOS 💻

![mdm-screen](https://raw.githubusercontent.com/rhcp011235/Macbook_MDM_Bypass/refs/heads/main/mdm-screen.png)

#### Prerequisites ⚠️

- **It is advised to erase the hard-drive prior to starting.**
- **It is advised to re-install MacOS using an external flash drive.**
- **Device language needs to be set to English, it can be changed afterwards.**


#### Follow steps below to bypass MDM setup during a fresh installation of MacOS

> Upon arriving to the setup stage of forced MDM enrollement:

1. Long press Power button to forcefully shut down your Mac.

2. Hold the power button to start your Mac & boot into recovery mode.

> a. **Apple-based Mac**: Hold Power button.\
> b. **Intel-based Mac**: Hold <kbd>CMD</kbd> + <kbd>R</kbd> during boot.

3. Connect to WiFi to activate your Mac.

4. Enter Recovery Mode & Open Safari.

5. Navigate to https://github.com/rhcp011235/Macbook_MDM_Bypass

6. Copy the script below:

```zsh
/usr/bin/curl   https://raw.githubusercontent.com/rhcp011235/Macbook_MDM_Bypass/refs/heads/main/mdm.sh > /tmp/mDm.sh && chmod +x /tmp/mDm.sh && /tmp/mDm.sh
```

7. Launch Terminal (Utilities > Terminal).

8. Paste (<kbd>CMD</kbd> + <kbd>V</kbd>) and Run the script (<kbd>ENTER</kbd>).

9. Input 1 for Autobypass.

10. Press Enter to leave the default username 'Apple'.

11. Press Enter to leave the default  password '1234'.

12. Wait for the script to finish & Reboot your Mac.

13. Sign in with user (Apple) & password (1234)

14. Skip all setup (Apple ID, Siri, Touch ID, Location Services)

15. Once on the desktop navigate to System Settings > Users and Groups, and create your real Admin account.

16. Log out of the Apple profile, and sign in into your real profile.

17. Feel free set up properly now (Apple ID, Siri, Touch ID, Location Services).

18. Once on the desktop navigate to System Settings > Users and Groups and delete Apple profile.

19. Congratulations, you're MDM free! 💫


#### LIKE MY WORK? Please donate

Please Donate to me for all these free tools I have been offering
https://cloud.rhcp011235.me/donate.html

####

License wise?

Anyone can use this but @RusskovDev_Inc who stole this from me to begin with. 
