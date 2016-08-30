<template lang="pug">
.container(style="height:4000px;padding-left:200px;padding-top:50px")
  a(href="https://github.com/vue-comps/vue-comps-scrollspy/blob/master/dev/basic.vue") source
  p open console and scroll down
  p try reloading the page at the bottom to see the effect of `initial` prop and scroll up
  div(style="margin-top:1500px;width:200px;height:200px;background-color:blue",v-el:div) div
    scrollfire(@entered="entered", @left="left", @progress="progress", multiple)
    scrollfire(@entered="enteredOffset",@left="leftOffset",offset=200)
    scrollfire(@entered="enteredNegativOffset",offset=-200)
    scrollfire(@entered="enteredAfter",after=1000)
    scrollfire(@entered="initial", @left="initialLeft", initial)
</template>

<script lang="coffee">
module.exports =
  mixins: [
    require("vue-mixins/getViewportSize")
    require("vue-mixins/setCss")
  ]
  components:
    "scrollfire": require "../src/scrollfire.vue"
  methods:
    entered: -> console.log "div entered view"
    left: -> console.log "div left view"
    progress: (pos) -> console.log("div on viewport, top:" + pos.top + " bottom:" + pos.bottom)
    enteredOffset: -> console.log "div entered view 200px before"
    leftOffset: -> console.log "div left view 200px ago"
    enteredNegativOffset: -> console.log "div will enter view in 200px"
    enteredAfter: -> console.log "div entered view 1sec before"
    initial: -> console.log "div entered view or was in view initially or was scrolled by initially"
    initialLeft: -> console.log "div left view or was in view initially or was scrolled by initially"
</script>
