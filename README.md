# Runestone Academy Docker image
A docker container with a 
[Runestone academy](https://runestone.academy/) build environment.
The image is fairly light, based on alpine linux.

Runestone is a framework for creating interactive textbooks.
It is based on [Sphinx](http://www.sphinx-doc.org).
This image also includes sphinx extensions for 
[graphviz](https://graphviz.gitlab.io) and
[matplotlib](https://matplotlib.org).

The easient way to get the image is from docker hub:

```
docker pull dparillo/runestone
```

or clone this repository and build it yourself.

```
docker build -t dparillo/runestone .
```
  
# Running the container
The container is a means to run runestone commands on runestone files stored
on your local filesystem.
The image defines a volume (`/var/book`) where you can mount your book source
and make it visible to the docker container.

Runestone also can serve books from a lightweight web server for local testing.
To test, you'll need to map the web server port.

To create a temporary image that will be removed after it closes that
mounts the local directory `~/work/my-book` to the reserved volume
and maps local port `8080` to the container runestone server port 8000:

```
docker run --rm -it -v ~/work/my-book:/var/book -p 8080:8000 dparillo/runestone
```

Once running, the container will start an alpine shell.
 
To start a project, 
create a new folder and then run `runestone init`.
For example:

```
mkdir myproject
cd myproject
runestone init
```

The init command will ask you some questions and setup a default project.

To build the included default project run:

```
runestone build
```

Init creates a build folder with a file index.html in it,
along with some default content.
The contents of the build folder are suitable for hosting anywhere 
that you can serve static web content.
For a small class you could even serve the content using the builtin 
Python webserver.

```
runestone serve
```

Once the `serve` process is running,
open up `http://localhost:8080/`.
You should see the table of contents for a sample page.
If you edit ``_sources/index.html`` or ``_sources/overview.rst`` and 
then rebuild and serve again you will see your changes.

Details on the many options available when writing textbook content is
available from the 
[author's guide](https://runestone.academy/runestone/static/authorguide/index.html)
and from the main 
[Sphinx doc](http://www.sphinx-doc.org) page.


