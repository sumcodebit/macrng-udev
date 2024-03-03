# - simple MAC address randomizer -

randomizes your MAC address for unicast address space (device-to-device)

## dependencies

- udev / eudev

## install

1. add the file `56-macrng_udev.rules` into `/etc/udev/rules.d/`

	change index number, owner and/or permissions if needed.

2. add the file `macrng.sh` into `/usr/local/bin/`

	or any other favourite place which is part of your `$PATH` environment variable;
	in which case, please do not forget to change the value of keyword `RUN` which links to the script.

3. reboot or just tell `udev` to reload its newly accuired ruleset

	```sh
	sudo udevadm control --reload-rules
	```
	you may want to trigger `udev` to apply the rules to all existing devices or a specific one
	<br/>or manually reconnect them
	```sh
	sudo udevadm trigger
	sudo udevadm trigger --attr-match=vendor='VENDOR' --attr-match=model='MODEL'
	```
> [!NOTE]
> default locations for `udev` rules are found in: <br/>
> system wide rules:  `/usr/lib/udev/rules.d/` and `/usr/local/lib/udev/rules.d/` <br/>
> custom rules for local administration:  `/etc/udev/rules.d/` <br/>

## usage

install and forget about it.

when `udev` detects any addition of a net interface, the script will randomize its MAC address.

excluded interface names are:
	- loopback:		`lo*`
	- wireguard:	`wg*`
