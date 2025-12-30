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

Then you'll need to set up the VM370 environment. The website at [vm370.org]https://vm370.org/vm370/) details the process.

With that taken out of our way, we can start to have fun.

### Adding a user for you

It's no fun to log in as CMSUSER every time you want to do something. You'll want a user for yourself, with reasonable permissions to do things to the machine. In my case, I want to create an "RBANFFY" user for me.

TBA

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

I am not sure whether PC-DOS copied the "dir" and "type" command from CP/M or from CMS (or CP), but this is they do more or less the same as you would expect on the smaller computers.

![dir and type](dir-and-type-hello-fortran.png)

#### Let's compile that FORTRAN program (so we can run it)

[TBA]
