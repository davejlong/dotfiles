# Setting up Mutt

## Creating Password Pack

I use GnuPG to create a password pack to save my passwords in an encrypted file
on my laptop.

Start by creating a pass pack in a secure location on your computer. For me
that's `~/Private`. Create a temporary plain text pass pack at
`~/Private/mutt_pass`:

    # Account names and passwords for Mutt
    hostname.tld my_password
    otheremail.tld other_password

Then encrypt that file with `gpg`:

    $ gpg -c ~/Private/mutt_pass

That command should create a new encrypted file called `mutt_pass.gpg` in
`~/Private`.

## Setting up an account

First we need to tell Mutt what accounts are out there. To do that open
`~/.muttrc.local` and add the following:

    folder-hook 'hostname.tld' 'source ~/.mutt/hostname.tld'
    folder-hook 'otheremail.tld' 'source ~/.mutt/otheremail.tld'

    # Change to this account with <f2>
    macro index <f2> '<sync-mailbox><enter-command>source
    ~/.mutt/hostname.tld<enter><change-folder>!<enter>'
    # Change to this account with <f2>
    macro index <f2> '<sync-mailbox><enter-command>source
    ~/.mutt/otheremail.tld<enter><change-folder>!<enter>'

    source ~/.mutt/hostname.tld

For each account add both the `folder-hook` line and `macro index` line changing
the `hostname.tld` to be the name you want to use for your account. Only add the
last line for the account you want to be default.

Now to setup your account, create `~/.mutt/hostname.tld`. I have a few templates
in this directory for Gmail and Office365 email accounts.

## Adding a Signature

To add a signature, just create a text file in `~/.mutt/hostname.tld.signature`
with your signature and uncomment the proper line in your account file.
