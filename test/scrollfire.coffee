env = null
basic = require("../dev/basic.vue")
vp = null
scroll = (y,cb) ->
  window.scrollTo(0,y)
  scrollEvent = document.createEvent( 'CustomEvent' )
  scrollEvent.initCustomEvent( 'scroll', false, false, null )
  window.dispatchEvent(scrollEvent)
  window.requestAnimationFrame -> window.requestAnimationFrame ->
    cb()
describe "scrollfire", ->

  describe "basic env", ->

    before (done) ->
      basic.compiled = ->
        @entered = chai.spy("entered")
        @left = chai.spy("left")
        @progress = chai.spy("progress")
        @enteredOffset = chai.spy("enteredOffset")
        @leftOffset = chai.spy("leftOffset")
        @enteredNegativOffset = chai.spy("enteredNegativOffset")
        @enteredAfter = chai.spy("enteredAfter")
        @initial = chai.spy("initial")
        @initialLeft = chai.spy("initialLeft")
      env = loadComp(basic)
      vp = env.getViewportSize()
      env.$nextTick ->
        done()

    after ->
      #unloadComp(env)

    it "should work on scrolling down", (done) ->
      box = env.$els.div.getBoundingClientRect()
      top = box.top
      bottom = box.bottom
      timeoutCalled = false
      finished = false
      scroll top - vp.height - 200, ->
        env.enteredNegativOffset.should.be.called.once
        scroll top - vp.height , ->
          setTimeout (->
            env.enteredAfter.should.be.called.once
            timeoutCalled = true
            done() if finished
            ),1010
          env.entered.should.be.called.once
          env.initial.should.be.called.once
          scroll top - vp.height + 200, ->
            env.enteredOffset.should.be.called.once
            env.progress.should.be.called.once
            scroll bottom, ->
              env.left.should.be.called.once
              env.initialLeft.should.be.called.once
              scroll bottom+200, ->
                env.leftOffset.should.be.called.once
                finished = true
                done() if timeoutCalled

    it "should work on scrolling up", (done) ->
      env.setCss(document.body, "height", "4000px")
      timeoutCalled = false
      finished = false
      scroll 4000, ->
        env.$destroy(true)
        env = loadComp(basic)
        env.$nextTick ->
          env.initial.should.be.called.once
          env.initialLeft.should.be.called.once
          scroll env.$els.div.offsetTop+env.$els.div.offsetHeight+200, ->
            env.enteredNegativOffset.should.be.called.once
            scroll env.$els.div.offsetTop+env.$els.div.offsetHeight, ->
              env.entered.should.be.called.once
              setTimeout (->
                env.enteredAfter.should.be.called.once
                timeoutCalled = true
                done() if finished
                ),1010
              scroll env.$els.div.offsetTop + env.$els.div.offsetHeight - 200, ->
                env.enteredOffset.should.be.called.once
                env.progress.should.be.called.once
                scroll env.$els.div.offsetTop - vp.height, ->
                  env.left.should.be.called.once
                  scroll env.$els.div.offsetTop - vp.height - 200, ->
                    env.left.should.be.called.once
                    finished = true
                    done() if timeoutCalled
