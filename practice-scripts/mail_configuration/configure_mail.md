# Configuring Email Notifications on Amazon Linux with Postfix

This guide explains how to configure Postfix on Amazon Linux to send email notifications using Gmail's SMTP server.

**Install Postfix and `mailx`**

```
yum install postfix
yum install mailx

```

# Backup Configuration

Before editing the configuration, make sure to back up the existing Postfix configuration file:

`vi \etc\postfix\main.cf`

Add or update the following lines in main.cf:
```
relayhost = [smtp.gmail.com]:587
myhostname= your_hostname
```

## for host name you give command `hostname -f` to know your host name

## add the below lines in the end of main.cf

```
#Location of sasl_passwd we saved

smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd

#Enables SASL authentication for postfix
smtp_sasl_auth_enable = yes
smtp_tls_security_level = encrypt

# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
```


# Create a file to store your SMTP credentials:

Filename: sasl_passwd

Add the below line
vi /etc/postfix/sasl/sasl_passwd
`[smtp.gmail.com]:587 chethanreddy.mp@gmail.com:password`

# for password goto mail managegmail>security>app password

# convert pass file to sasl_passwd.db

`postmap sasl_passwd`

`cd /etc/postfix/sasl/`
`chmod 600 * `

`systemctl start postfix.service`

`echo "Test Mail" | mail -s "Postfix TEST" chethanreddy.mp@gmail.com`