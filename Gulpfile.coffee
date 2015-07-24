gulp = require 'gulp'
coffeeify = require 'gulp-coffeeify'
less = require 'gulp-less'
jade = require 'gulp-jade'
connect = require 'gulp-connect'

gulp.task 'coffee', ->
    gulp.src 'src/coffee/application.coffee'
        .pipe coffeeify
            debug: true
        .pipe gulp.dest './build/js'
        .pipe connect.reload()

gulp.task 'less', ->
    gulp.src 'src/less/application.less'
        .pipe less()
        .pipe gulp.dest './build/css/'
        .pipe connect.reload()

gulp.task 'jade', ->
    gulp.src ['src/jade/**/*.jade', '!src/jade/**/_*.jade']
        .pipe jade()
        .pipe gulp.dest './build/'
        .pipe connect.reload()

gulp.task 'connect', ->
    connect.server
        root: 'build'
        livereload: true

gulp.task 'watch', ->
    gulp.watch 'src/coffee/**/*.coffee', ['coffee']
    gulp.watch 'src/less/**/*.less', ['less']
    gulp.watch 'src/jade/**/*.jade', ['jade']

gulp.task 'default', ->
    gulp.run 'coffee'
    gulp.run 'less'
    gulp.run 'jade'
    gulp.run 'connect'
    gulp.run 'watch'
