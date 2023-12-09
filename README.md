## Python Selenium Docker Container

There are many Docker container images with Python and Selenium, but this one is mine. It supports Chromium only for now.

The aim is to be minimal, and headless mode is required since there is no X installed.

## Quickstart

Using the prebuilt image:

```
docker run -it ghcr.io/scottyeager/python-selenium-docker:main python
```

Import Selenium and add options (`--no-sandbox` is needed since we are root inside the container):

```
from selenium import webdriver
options = webdriver.ChromeOptions()
options.add_argument("--no-sandbox")
options.add_argument("--headless=new")
```

Finally start up the driver and fetch a page.

Note that the `chromium` and `chromedriver` executables will be downloaded automatically by Selenium Manager on the first execution of `webdriver.Chrome()`. This can take a minute or two.

```
driver = webdriver.Chrome(options=options)
driver.get('https://example.com')
driver.title
```

There's a convenience script included the does the above with a couple extra imports that are typically recommended and javascript enabled. So you can:

```
docker run -it ghcr.io/scottyeager/python-selenium-docker:main python -i /headless.py
```

Then `driver` will be available automatically after the downloads finish.

## Committing the binaries

If you want to save a version of the binaries for reuse, just commit a new Docker image after the step is complete:

```
docker run ghcr.io/scottyeager/python-selenium-docker:main python /headless.py
```

The container will exit when it's finished. Then commit it (tag shown is just an example):

```
docker commit $(docker ps -aq | head -n 1) python-selenium:bins
```

After that, you can now start a fresh container with binaries included like this:

```
docker run -it python-selenium:bins
```

## Development

If you want to experiment locally, just:

```
git clone https://github.com/scottyeager/python-selenium-docker.git
cd python-selenium-docker
docker buildx build -t selenium-python .
```

## Motivation

Why not `apt install python3-selenium`?

Ubuntu's package is configured to not use Selenium Manager. Likewise, the `chromedriver` shipped through `apt` is configured to only work with Chromium installed via `snap`.

Needless to say, `snap` is not ideal for a container that's intended to be lightweight. Furthermore, getting the correct version of Chromium installed can be a hassle.

By installing Selenium with `pip`, we're able to let Selenium Manager handle the fetching of needed binaries at run time. This means we get an up to date version of Chromium and the driver automatically as described above, and this image only needs to contain the minimal dependency set required to run them.
