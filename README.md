[![Build Status](https://travis-ci.org/DusanMadar/ScrapeMeAgain.svg?branch=master)](https://travis-ci.org/DusanMadar/ScrapeMeAgain)


# ScrapeMeAgain

ScrapeMeAgain is a Python 3 powered web scraper. It uses multiprocessing to get the work done quicker and stores collected data in an [SQLite](http://www.sqlite.org/) database.


## Usage

### Basic
You have to provide your own database table description and an actual scraper class which must follow the `BaseScraper` interface. See `scrapemeagain/scrapers/examplescraper` for more details.

#### Run `examplescraper` locally

1. Run `examplesite`

```
python3 scrapemeagain/scrapers/examplescraper/examplesite/app.py
```

2. Start `examplescraper`

```
 python3 scrapemeagain/scrapers/examplescraper/main.py
```

**NOTE** You may need to update your `PYTHONPATH`.

### Dockerized

With Docker it is possible to use multiple Tor IPs at the same time and, unless you abuse it, scrape data faster.

The easiest way to start is to duplicate `scrapemeagain/scrapers/examplescraper` and then update, rename, expand, etc. your scraper and related classes.

Your scraper must define `config.py` and `main_dockerized.py`. These two names are hardcoded throughout the codebase.

A dynamic `docker-compose` is responsible for orchestrating scraper instances. The idea is that the first scraper (`scp1`) is a `master` scraper and hence is the host for a couple of helper services which communicate over HTTP (see [`dockerized/apps`](https://github.com/DusanMadar/ScrapeMeAgain/tree/master/scrapemeagain/dockerized/apps)).

#### Run `examplescraper` with Docker

1. Get Docker host Ip

```
ip addr show docker0
```

**NOTE** Your Docker interface name may be different from *docker0*.

2. Run `examplesite` on Docker host IP

```
python3 scrapemeagain/scrapers/examplescraper/examplesite/app.py 172.17.0.1
```

**NOTE** Your Docker host IP may be different from *172.17.0.1*.

3. Start `docker-compose`

```
python3 docker-compose.py -s examplescraper -c tests.integration.fake_config | docker-compose -f - up
```

**NOTE** A special config file path is provided: `-c tests.integration.fake_config`.


## System requirements
ScrapeMeAgain leverages `Tor` and `Privoxy`.

[Tor](https://www.torproject.org/) in combination with [Privoxy](http://www.privoxy.org/) are used for anonymity (i.e. regular IP address changes). For more details about installation and configuration refer to:
 * [A step-by-step guide how to use Python with Tor and Privoxy](https://gist.github.com/DusanMadar/8d11026b7ce0bce6a67f7dd87b999f6b)
 * [Crawling anonymously with Tor in Python](http://sacharya.com/crawling-anonymously-with-tor-in-python/) ([alternative link (Gist)](https://gist.github.com/KhepryQuixote/46cf4f3b999d7f658853))


## Legacy
The Python 2.7 version of ScrapeMeAgain, which also provides geocoding capabilities, is available under the `legacy` branch and is no longer maintained.
