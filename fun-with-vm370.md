# Fun things to do with your VM/370 machine

## Intro

This page assumes you have a machine (emulated or not) running the VM370 Community Edition OS available. There are a couple ways to get one, and you might want to choose the one that appeals to you the most (or the one that's less work - it's up to you).

### With Docker

This assumes you have Docker installed. If you do, you can just issue a shell command to have your own machine.

```shell
docker run -n vm370 -p 3270:3270 rbanffy/vm370ce
```

This will bring up the machine and display the Hercules console on your terminal.

### With Hercules

If you don't have Hercules installed on your machine, you can install it on any civilised operating system with its package manager GUI. If you want a command-line shortcut, use something like:

```shell
sudo dnf install sdl-hercules
```

Package name and version varies depending on which operating system you are using. If you are on Windows, you'll need to find the installer - start from the [GitHub repo](https://github.com/SDL-Hercules-390/hyperion).

Then you'll need to set up the VM370 environment. The website at [vm370.org](https://vm370.org/vm370/) details the process.

With that taken out of our way, we can start to have fun.

### Logging on

For normal things, we'll log on to the CMSUSER VM, or, if you renamed it, to your own VM. The default password is "CMSUSER":

On the banner screen, press ENTER.

![VM/370 CE](vm370ce-banner.png)

The screen will clear. You can then enter `logon cmsuser`:

![logon cmsuser](logon-cmsuser.png)

And enter the password, "cmsuser":

![enter password](enter-password.png)

As expected, the password isn't shown. The red cursor means that.

![logged on](logged-on.png)

At this point, you are logged on. When you press ENTER another time, a program, called "PROFILE EXEC" will be run:

![profile-exec](profile-exec.png)

We can examine it. Note that "PROFILE EXEC" means the name is "PROFILE" and the type is "EXEC" (a script). To show the contents of the file, use:

```text
type profile exec
```

![type profile exec](type-profile-exec.png)

I am not sure whether PC-DOS copied the "dir" and "type" command from CP/M or from CMS (or CP), but they do more or less the same as you would expect on the smaller computers.

As for the PROFILE program, we'll look at it later.

### Running a BASIC program

What is a vintage computer without a BASIC interpreter, right?

Let's start with the lamest, most basic BASIC program: a Hello World.

On your terminal, type:

```text
edit hello basic
```

Note that "basic" is not a suffix, but a type - it's a separate parameter. The type of the file is a property of the file and will remain with it unless forcibly changed.

![Edit hello basic](edit-hello-basic.png)

When you press enter (or send) you'll end up on the EDIT program. On the surface, it looks a lot like `vi` from the Unix side: it's terse, hard to use, and sometimes counter-intuitive. It's also hard to guess how to exit it. That's about where the similarities end.

![Empty editor](edit-empty.png)

Let's start typing our program:

```basic
10 print 'hello world'
```

When you press enter, you'll see the line was entered. It was also changed to uppercase (see the "CASE=U" at the top line?). Let's save the file and quit the editor. Type "file" and press Enter.

![A very short program](10-print-hello.png)

The line at the bottom shows a "MORE..." note. This means the terminal is waiting for you before it shows more output. Press PA2 (Alt-2 for x3270) and you'll see you have exited EDIT.

Now we can run our program:

```text
basic hello
```

You'll see your command ("basic hello") show up at the top of the screen (after the message indicating EDIT finished), then the message you ordered it to print "HELLO WORLD", followed by another line telling how much CPU it used and how long did it take to run your program.

![Program output](hello-world.png)

### A bit of FORTRAN

VM/370 CE comes with a couple hello world programs. You can use the "dir" command to list what files are in the disk you are seeing. We typed our own in BASIC, but there is one in C and one in FORTRAN. Let's see the FORTRAN one:

```text
type hello fortran
```

![dir and type](dir-and-type-hello-fortran.png)

#### Let's compile that FORTRAN program (so we can run it)

[TBA]

### Navigating the disks

The VM370CE distribution has a lot of disks. You can check which ones you have immediate access with. If you logged on as CMSUSER, you can use the LISTFILE (we abreviated it to "LIST") command to see what files are on your default disk. In CMS, commands can be abbreviated - the actual command is `LISTFILE` but `LIST` is neat enough.

![list](list.png)

To check the disks you have, use `QUERY DISK` (query can also be abbreviated - `Q` will suffice for the computer to understand what you want):

![query disk](query-disk.png)

To list what's on a disk, you'll use `LIST * * [disk]`. The first "*" is a wildcard that will show all file names, the second is for all types. If you are familiar with windcards from CP/M, MS-DOS, or Unix, these don't behave the same.

he third parameter is the disk:

![list * * a](list-star-star-a.png)

So... Looking at the output of `LIST` and `LIST * * A`, we can conclude we were start from disk A. In this case, A is a shortcut to disk 191 (mainframes always were supposed to have lots of disks, and our emulated one - a tricked out 4381 - has more than most companies could afford, or that would fit in most period accurate computer rooms). In our case, 191 is the "address" of the disk, and tells where the disk is connected to the virtual machine. Disks also have 6-character labels (or "VOLSER" in mainframe slang). A is "CMS190".

Let's check the other disks:

![D, E, F, and G are empty](d-e-f-g-empty.png)

Disks D, E, F, and G are empty. That wouldn't be a surprise if we had paid attention to the output of `QUERY DISK` - it clearly says they have zero files, and use 5 blocks (rounded to 0% of the disk).

There is also disk S (or 190, or ). It has 172 files, so it'll take a couple pages to list everything. In the list you'll see a lot of interesting files - this disk contains system utilities - there's ACCESS, EDIT, QUERY, SET, SORT, GLOBAL, and other things that we have seen before or that look like things an OS would provide (not a big surprise, as its label is "CMSDSK"). Binary programs seem to be of type "MODULE". Let's remember that. Try listing all files of type MODULE in S:

```text
DIR * MODULE S
```

![dir * module s](dir-star-module-s.png)

[Other disks TBA]

### Uploading files to your machine

The easiest way to do it, is with the x3270 app - on the File menu select "File Transfer":

![File Transfer Dialog](file-transfer-dialog.png)

Since we are uploading a VMARC file (think a .zip or .tar.bz2), we'll chose a binary transfer. The file will be saved to our disk D. And it'll be a while (if my powerful Raspberry Pi Zero W running a docker container is any indication).

![Transfer is happening](ongoing-transfer.png)

### Adding a user for you

It's no fun to log in as CMSUSER every time you want to do something. You'll want a user for yourself, with reasonable permissions to do things to the machine. In my case, I want to create an "RBANFFY" user for me.

Here's the first shock for those who come from other platforms - you wouldn't create a user, you'd create a VM, and you log in to that VM.

![One does not simply add a user to TSO](one-does-not-simply-add-a-user.jpg)

Creating a VM is a bit involved - you'll need to do a lot of things before - allocate and format storage, for instance. We'll leave that for later.

In the meantime, if you want to rename the CMSUSER VM to your preferred name (and changing the password), we can explain that For that, we'll start logging on as MAINT (which means, logging on to the MAINT VM).


