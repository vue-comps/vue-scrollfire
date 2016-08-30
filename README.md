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
Name | type | default | description
---:| --- | ---| ---
multiple | Boolean | false | set to fire on every time the element enters, leaves or moves within the viewport
offset | Number | 0 | lateral offset when to fire
after | Number | 0 | milliseconds to wait until fire
ignoreParent | Boolean | false | don't use the bounding box of parent but of scrollfire `span`
initial | Boolean | false | fires `entered` and `left` on initial page load when element `top` or `bottom` is in or above viewport

#### Events
Name |  description
---:| ---
entered |  will be fired on entering of viewport
progress |  will be fired on scrolling of viewport. Argument: `{top,bottom}`
left |  will be fired on leaving of viewport

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
