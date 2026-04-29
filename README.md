# Android Binds
Some terminal binds, useful for dealing with Android, to enhance speed on pentests.

## Functions

| Function | Platform | Description |
|----------|----------|-------------|
| `list-apks` | Windows, Linux | Lists all third-party packages installed on the device. It's possible to filter passing an argument. |
| `pull-apks` | Windows, Linux | Extracts split APK files from a specified package to a local directory. |
| `frida-srv` | Windows, Linux | Manages Frida server binary on the device. Supports `start` and `stop` actions. Allows specifying a custom binary name. |
| `get-front` | Windows, Linux | Displays the currently focused/frontmost activity of the application running on the device. |

## Windows Version

Just paste the code into your PowerShell profile.
```
notepad $PROFILE
```

## Linux Version

Paste at the end of .bashrc/.zshrc or any variation.