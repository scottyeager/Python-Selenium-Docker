## Python Selenium Docker Container

There are many Docker container images with Python and Selenium, but this one is mine. It supports Chromium only for now.

The aim is to be minimal, and headless mode is required since there is no X installed.

## Quickstart

First clone the repo and build the container:

```
git clone https://github.com/scottyeager/python-selenium-docker.git
cd python-selenium-docker
docker buildx build -t selenium-python .
```

Now start up a copy of the container interactively:

```
docker run -it selenium-python:latest
```

Then start Python inside the container and fetch a page with Selenium. Note that the `chromium` and `chromedriver` executables will be downloaded automatically by Selenium Manager on the first execution of `webdriver.Chrome()`. This can take a few minutes.

```
python

from selenium import webdriver
options = webdriver.ChromeOptions()
options.add_argument("--no-sandbox")
options.add_argument("--headless=new")

driver = webdriver.Chrome(options=options)
driver.get('https://example.com')
driver.title
```

There's a convenience script included the does the above with a couple extra imports that are typically recommended and javascript enabled. So you can:

```
python -i /root/headless.py
```

and `driver` will be setup for you.


## Motivation

Why not `apt install python3-selenium`?

Ubuntu's package is configured to not use Selenium Manager. Likewise, the `chromedriver` shipped through `apt` is configured to only work with Chromium installed via `snap`.

Needless to say, `snap` is not ideal for a container that's intended to be lightweight. Furthermore, getting the correct version of Chromium installed can be a hassle.

By installing Selenium with `pip`, we're able to let Selenium Manager handle the fetching of needed binaries at run time. This means we get an up to date version of Chromium and the driver automatically as described above, and this image only needs to contain the minimal dependency set required to run them.
