// out: ..
<template lang="jade">
span
  slot
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
      top = @$el.getBoundingClientRect().top+@offset-@height
      bottom = @$el.getBoundingClientRect().bottom+@offset
      if (@lastPos.top > 0 and top <= 0) || (@lastPos.bottom < 0 and bottom >= 0)
        if @after > 0
          setTimeout (=>@$emit("left")),@after
        else
          @$emit("entered")

      if (@lastPos.bottom > 0 and bottom <= 0) || (@lastPos.top < 0 and top >= 0)
        if @after > 0
          setTimeout (=>@$emit("left")),@after
        else
          @$emit("left")
        setTimeout(@distopeListener,1) unless @multiple

      if (top < 0 and bottom > 0)
        @$emit("progress", {top: -top, bottom: bottom})

      @lastPos = {top: top, bottom: bottom}
    getHeight: ->
      @height = @getViewportSize().height
  compiled: ->
    @lastPos = {top: Number.MAX_VALUE, bottom: Number.MAX_VALUE}
    @getHeight()
    @onWindowResize @getHeight
    @distopeListener = @onWindowScroll @processScroll

</script>
