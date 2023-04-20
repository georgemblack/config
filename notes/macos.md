To change animation speed of hidden dock:

```
defaults write http://com.apple.Dock autohide-delay -float 0
defaults write http://com.apple.dock autohide-time-modifier -float 0.65
killall Dock
```

To undo it:

```
defaults delete http://com.apple.dock autohide-time-modifier
defaults delete http://com.apple.dock autohide-delay
killall Dock
```