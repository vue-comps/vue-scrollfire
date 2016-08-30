// out: ..
<template lang="pug">
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
      coerce: Number
    after:
      type: Number
      default: 0
      coerce: Number
    ignoreParent:
      type: Boolean
      default: false
    initial:
      type: Boolean
      default: false

  mixins:[
    require("vue-mixins/onWindowScroll")
    require("vue-mixins/getViewportSize")
    require("vue-mixins/onWindowResize")
  ]

  methods:
    processScroll: ->
      box = @target.getBoundingClientRect()
      top = box.top-@height
      bottom = box.bottom
      if @initial and not @lastPos
        @lastPos = {top: Number.MAX_VALUE, bottom: Number.MAX_VALUE}
      if @lastPos?
        if not @state.entered and
            (@lastPos.top > -@offset and top <= -@offset) or
            (@lastPos.bottom < @offset and bottom >= @offset)
          if @after > -@offset
            setTimeout (=>@$emit("entered")),@after
          else
            @$emit("entered")
          @state.entered = true unless @multiple

        if not @state.left and
            (@lastPos.bottom > -@offset and bottom <= -@offset) or
            (@lastPos.top < @offset and top >= @offset)
          if @after > 0
            setTimeout (=>@$emit("left")),@after
          else
            @$emit("left")
          @state.left = true unless @multiple
          setTimeout(@disposeListener,1) unless @multiple

        if (top < 0 and bottom > 0)
          @$emit("progress", {top: -top, bottom: bottom})
      @lastPos = {top: top, bottom: bottom}
    getHeight: ->
      @height = @getViewportSize().height
  compiled: ->
    @state = {entered:false,left:false}
    @getHeight()
    @onWindowResize @getHeight
    @disposeListener = @onWindowScroll @processScroll

  ready: ->
    @target = if @ignoreParent then @$el else @$el.parentElement
    @processScroll()

</script>
