<template lang="jade">
.container(style="height:1500px;padding-left:200px;padding-top:50px")
  a(href="https://github.com/vue-comps/vue-comps-scrollspy/blob/master/dev/basic.vue") source
  p open console and scroll down
  div(style="margin-top:800px;width:200px;height:200px;background-color:blue") div
    scrollfire(@entered="entered")
    scrollfire(@entered="enteredOffset",:offset=200)
    scrollfire(@entered="enteredNegativOffset",:offset=-200)
    scrollfire(@entered="enteredAfter",:after=5000)
</template>

<script lang="coffee">
module.exports =
  components:
    "scrollfire": require "../src/scrollfire.vue"
  methods:
    entered: -> console.log "div entered view"
    enteredOffset: -> console.log "div entered view 200px before"
    enteredNegativOffset: -> console.log "div will enter view in 200px"
    enteredAfter: -> console.log "div entered view 5sec before"
</script>
