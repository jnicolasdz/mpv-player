# mpv-player

Hello everyone! On my way to build a minimalist and flyweight distro based on [void-linux](https://voidlinux.org/) I have working on
a minimalist **mpv-player** script, as you probably know [mpv](https://mpv.io/) is a open source and cross-platform media player but
requires a few more tools to make it user-friendly that is the goal of this project!. 

## Attention 

Right now this project is in refactoring process, so you may expected changes in the instructions below and it has not tested
properly.

## Requirements

- mpv-mpris: the core of this project which manages the requests to youtube
- playerctl: basic and common sound channels manager 
- yad: flyweight windows creator and manager to generate the pop-ups notifications

## Installation
- Download from `https://github.com/hoyon/mpv-mpris/releases/download/0.5/mpris.so` and put it in `~/.config/mpv/scripts/`

>[!COMMENT]- Note
> The step above it is requires to add the mpv job in dbus service, if your machine do not work with dbus, you may skip this step
 
- Download and verify the packages above, download `player.sh` and `popup.sh` and storage in `~/.config/UserScripts/` 

>[!COMMENT]- Note
> I have not tested in other distros except void-linux but if it works here it should work anywhere 

## Usage 

**mpv-player** bases all its funcionallity in reproduce audio from youtube videos channels using **mpv**

### View videos availables

The videos are storage in a form of dictionary where video names are the keys and the value are the youtube links, to see which ones are storages, you can use:
```
$ player.sh ls
```
>[!COMMENT]- Note
> The index column is a way to make fast the selection of videos, it can replaces the name of the video

### Add video

In order to add a video, it is requires the name and the youtube link:
```
$ player.sh add <video-name> <video-link> 
```

### Remove video

It is requires the video name:
```
$ player.sh remove <video-name>
```

### Play video 

It is requires the video index, you can see the index by typing `$ player.sh ls`:
```
$ player.sh play <video-index>
```
If it is not an argument then it just play the last song reproduced 

### Pause a video
```
$ player.sh pause
```

### Kill a video

```
$ player.sh stop
```

### Play the previous or next video

As you see with `player.sh ls`, there is a index uses, in this case, to mark a secuential orden which you can use with:

```
$ player.sh previous
```
```
$ player.sh next
```

## Recommendation

You probably think that terminal commands are not so user-friendly, for that reason I highly recommend to configure keybinds in the
next way:

```
bindsym $mod+F10 exec --no-startup-id ~/.config/UserScripts/player.sh previous
bindsym $mod+F11 exec --no-startup-id ~/.config/UserScripts/player.sh pause
bindsym $mod+Shift+F11 exec --no-startup-id ~/.config/UserScripts/player.sh stop
bindsym $mod+F12 exec --no-startup-id ~/.config/UserScripts/player.sh next
```
With those keybinds, **mpv-player** is easy, fast and user-friendly 

Also I recommend put the next window rule to the pop-up notifications:

```
for_window [title="PopUp"] floating enable, resize set 150 5, move position center, move up 405 px
```



   
