Music Plugin Example
===================

## How to use this example

If below packagges are not installed, install first globally.

```bash
$ sudo npm install -g ionic cordova bower
```

Then, to prepare to build it.

```bash
$ bower install
$ ionic state restore
```

Then, to run it.

```bash
$ ionic platform add android
$ ionic build android
$ ionic emulate android
```