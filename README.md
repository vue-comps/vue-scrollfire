# vue-scrollfire

Fires an event on a specific scroll position

### [Demo](https://vue-comps.github.io/vue-scrollfire)


# Install

```sh
npm install --save-dev vue-scrollfire
```
or include `build/bundle.js`.

## Usage
```coffee
# in your component
components:
  "scrollfire": require("vue-scrollfire")
# or, when using bundle.js
components:
  "scrollfire": window.vueComps.scrollfire
```
```html
<scrollfire></scrollfire>
```

For examples see [`dev/`](dev/).

#### Props
| Name | type | default | description |
| ---:| --- | ---| --- |
| multiple | Boolean | false | set to fire on every time the element enters the viewport |
| offset | Number | 0 | lateral offset when to fire |
| after | Number | 0 | milliseconds to wait until fire |

#### Events
| Name |  description |
| ---:| --- |
| entered |  will be fired on entering of viewport |

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
