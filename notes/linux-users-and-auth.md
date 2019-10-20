# Linux Users and Auth

Create new user:

	adduser george

Add pubkey to `/home/george/.ssh/authorized_keys`.

If you want to change auth settings, edit `/etc/ssh/sshd_config`.

If you want to completely remove password auth, edit:

	ChallengeResponseAuthentication no
	PasswordAuthentication no
	UsePAM no

After editing this file, restart ssh service.

	service ssh restart
	service sshd restart

To add a user to "suoders" group:

	usermod -aG sudo george
