# ASR Rules PoSh GUI

Attack Surface Reduction Rules can be set on different ways. If you don't use any Device Management and no Group Policies, there's only one way left: Powershell. But this is not as userfriendly as I hoped (especially the GUID). So I developed GUI for setting ASR Rules via Powershell. 

## Getting Started

Just use the Powershell Script (for Development or Enhancement) or the EXE File (for just setting ASR Rules).

### Prerequisites

1. You will need Windows 10 Pro or Windows 10 Enterprise in Version 1709 or later.

2. The Powershell Script as well as the Exe have to run in admin mode to work properly.

### Development
For development and testing you might need to set the Powershell ExecutionPolicy to Unrestricted. Because of Security Risk it is recommended to set the policy to restricted after finishing development.

Before Development:
```
Set-ExecutionPolicy Unrestricted
```

After Development
```
Set-ExecutionPolicy Restricted
```

### Installing

There is no installation as the EXE is based on the Powershell Script.

## Built With

* Visual Studio Designer
* Powershell ISE 5.0


## Authors

* **Hermann Maurer** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
Thanks to
* **António Vasconcelos** - [anvascon](https://github.com/anvascon)
* [anthonws](https://github.com/anthonws)

for Inspiration and initial Code base which is used in the "Report"-Function.
