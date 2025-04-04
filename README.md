# Auto Backup Script

## Step 1: Install rclone

Rclone should be in your distribution's repositories. If it is not, visit https://rclone.org/install/ for manual installation instructions.

## rclone configuration
To start the configurator, run the command:
```bash
rclone config
```
Follow the instructions to set up at least two remotes
   - Choose **New remote**
   - Enter a name (`REMOTE1` or `REMOTE2`)
   - Select the appropriate storage provider (S3, B2, etc)
   - Follow the prompts for authentication.
   - You can optionally use `rclone crypt` and point it to `REMOTE2` if you want to have your off-site backup be encrypted

Confirm the remotes you added with:
```bash
rclone listremotes
```

## Script configuration

Set `DIR`  to the directory you want to back up, for example 

```DIR="/home/user/directory"```

Replace `REMOTE1` and `REMOTE2` with your configured remote names and the folder path on the remote where backups should go:

```REMOTE1="s3_encrypted:/server-backups"```

Finish editing and save your changes. If you want the script to be globally reachable, add it to `/usr/local/bin` with:

```bash
sudo install -m 755 cloud-backup.sh /usr/local/bin/cloud-backup
```

## Automatic schedule with crontab

Open crontab with:
```bash
crontab -e
```

Add the following line to run the backup script weekly. This example runs the script weekly at midnight:

```bash
0 0 * * 0 /usr/local/bin/cloud-backup >> /var/log/backup.log 2>&1
```
A short explanation:

`0 0 * * 0` → Runs at **00:00 (midnight) every Sunday**

`>> /var/log/backup.log 2>&1` → Logs output to `/var/log/backup.log` for troubleshooting.

Save and exit when you're finished.

Test the script by running:
```bash
/usr/local/bin/cloud-backup >> /var/log/backup.log
```

You can check from rclone if the script appears on your remote.
```bash
rclone ls s3_encrypted:/server-backups
```