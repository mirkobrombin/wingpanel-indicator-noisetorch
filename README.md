<div align="center">
  <h1>NoiseTorch indicator for Wingpanel</h1>
  <p>Handle NoiseTorch in pantheon through this indicator.</p>
  <img src="https://raw.githubusercontent.com/mirkobrombin/wingpanel-indicator-noisetorch/master/data/screenshot.png">
</div>

## Notice
Since there is no way to deterinate if the suppression is active or not, the indicator will default assume it is disabled.

## Build and Installation
You'll need the following dependencies:
* libgala-dev
* libgee-0.8-dev
* libglib2.0-dev
* libgranite-dev
* libgtk-3-dev
* meson
* libmutter-2-dev
* valac
* posix
* [noise-torch](https://github.com/lawl/NoiseTorch)

Configure the build environment with meson:
```
meson build --prefix=/usr
cd build
ninja
```
Install:
```
sudo ninja install
```
