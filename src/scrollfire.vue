// out: ..
<template lang="jade">
span
</template>

<script lang="coffee">
module.exports =

  props:
    multiple:
      type: Boolean
      default: false
    offset:
      type: Number
      default: 0
    after:
      type: Number
      default: 0

  mixins:[
    require("vue-mixins/onWindowScroll")
    require("vue-mixins/getViewportSize")
    require("vue-mixins/onWindowResize")
  ]
  methods:
    processScroll: ->
      pos = @$el.getBoundingClientRect().top+@offset-@height
      if @lastPos > 0 and pos <= 0
        if @after > 0
          setTimeout (=>@$emit("entered")),@after
        else
          @$emit("entered")
        setTimeout(@disposeListener,1) unless @multiple
      @lastPos = pos
    getHeight: ->
      @height = @getViewportSize().height
  compiled: ->
    @lastPos = Number.MAX_VALUE
    @getHeight()
    @onWindowResize @getHeight
    @disposeListener = @onWindowScroll @processScroll

</script>
