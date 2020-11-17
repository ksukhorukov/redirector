# Redirector

URLs minifying service

### Requirements

`Ruby 2.7`

### Installation

```
$ cd redirector
$ bundle install
$ rails s
```

### Usage

Create minified link:

```
curl -d url=http://www.google.com http://localhost:3000/urls

{"status":"ok","short_url":"afc4b"}
```

To visit minified link open ```http://localhost:3000/urls/afc4b``` in your browser

To see the stats of minified link open ```http://localhost:3000/urls/afc4b/stats``` in your browser:

```
{"staus":"ok","counter":1}
```

# EOF