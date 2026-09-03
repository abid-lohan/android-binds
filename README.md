# Android Binds
Some terminal binds, useful for dealing with Android, to enhance speed on pentests.

## Functions

| Function | Platform | Description |
|----------|----------|-------------|
| `list-apks` | Windows, Linux | Lists all third-party packages installed on the device. It's possible to filter passing an argument. |
| `pull-apks` | Windows, Linux | Extracts split APK files from a specified package to a local directory. |
| `frida-on` | Windows, Linux | Starts Frida server binary on the device in the background. Allows specifying a custom binary name. |
| `frida-off` | Windows, Linux | Kills the Frida server binary on the device. Allows specifying a custom binary name. |
| `get-front` | Windows, Linux | Displays the currently focused/frontmost activity of the application running on the device. |
| `burp-on` | Windows, Linux | Enables global HTTP proxy pointing to Burp Suite via adb reverse. |
| `burp-off` | Windows, Linux | Disables global HTTP proxy and removes adb reverse port forwarding. |

## Windows Version

Just paste the code into your PowerShell profile.
```
notepad $PROFILE
```

## Linux Version

Paste at the end of .bashrc/.zshrc or any variation.